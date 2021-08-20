package cn.stylefeng.guns.modular.job.service.impl;

import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.mapper.AreaMapper;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubDataResp;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubGraphqlResp;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubPageInfoResp;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubSearchResp;
import cn.stylefeng.guns.modular.job.service.ISyncGitHubUserService;
import cn.stylefeng.guns.modular.job.utils.GraphqlClientUtil;
import cn.stylefeng.roses.core.util.ToolUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.service.impl
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 2:48 下午
 */
@Service
@Slf4j
public class SyncGitHubUserServiceImpl implements ISyncGitHubUserService {

    private final static Integer AREA_LEVEL = 2;

    @Resource
    private AreaMapper areaMapper;

    private List<Area> toAreaListByLevel(final Integer level) {
        List<Area> areaList = areaMapper.selectAreaListByLevel(level);
        if (ToolUtil.isEmpty(areaList)) {
            return Collections.emptyList();
        }
        return areaList;
    }

    @Override
    public void syncGitHubUserByLocation() {
        toAreaListByLevel(AREA_LEVEL).forEach(area -> {
            String cityPinyin = area.getPinyin();
            try {
                log.info("城市：[" + area.getName() + "]");
                recursionUserPage(cityPinyin, null, null);
            } catch (RuntimeException | IOException e) {
                log.error("Sync GitHub Graphql API City={}, Error={}", cityPinyin, e);
            }
        });
    }

    private void recursionUserPage(String cityPinyin, @Nullable String after, @Nullable Integer userCount)
            throws RuntimeException, IOException {
        GitHubGraphqlResp resp = GraphqlClientUtil.doPostJson(cityPinyin, after);
        if (!checkResponse(resp)) {
            return;
        }
        GitHubDataResp data = resp.getData();
        GitHubSearchResp search = data.getSearch();
        GitHubPageInfoResp pageInfo = search.getPageInfo();
        if (userCount == null) {
            userCount = Optional.ofNullable(search.getUserCount()).orElse(null);
            log.info("，人数【"+ userCount+"】");
        }
        after = pageInfo.getEndCursor();
        // 循环获取
        while (userCount > 0) {
            recursionUserPage(cityPinyin, after, userCount - 30);
        }
    }

    private static boolean checkResponse(GitHubGraphqlResp resp) {
        return ToolUtil.isNotEmpty(resp)
                && ToolUtil.isNotEmpty(resp.getData())
                && ToolUtil.isNotEmpty(resp.getData().getSearch())
                && ToolUtil.isNotEmpty(resp.getData().getSearch().getPageInfo().getEndCursor())
                && ToolUtil.isNotEmpty(resp.getData().getSearch().getUserCount());
    }
}
