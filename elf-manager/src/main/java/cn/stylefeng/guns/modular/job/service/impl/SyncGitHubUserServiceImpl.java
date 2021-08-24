package cn.stylefeng.guns.modular.job.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.mapper.AreaMapper;
import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.job.entity.resp.*;
import cn.stylefeng.guns.modular.job.mapper.GitHubUserMapper;
import cn.stylefeng.guns.modular.job.service.ISyncGitHubUserService;
import cn.stylefeng.guns.modular.job.utils.GraphqlClientUtil;
import cn.stylefeng.roses.core.util.ToolUtil;
import com.sun.org.apache.bcel.internal.generic.ConstantPushInstruction;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

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

    // 指定批量插入分页大小
    private static final int MAX_LIST_SIZE = 5000;

    @Resource
    private AreaMapper areaMapper;

    @Resource
    private GitHubUserMapper gitHubUserMapper;

    private ConcurrentHashMap<String, CopyOnWriteArrayList<User>> userMapping = new ConcurrentHashMap<>();

    /**
     * 按城市级别获取城市列表
     *
     * @param level 城市级别
     */
    private List<Area> toAreaListByLevel(final Integer level) {
        List<Area> areaList = areaMapper.selectAreaListByLevel(level);
        if (ToolUtil.isEmpty(areaList)) {
            return Collections.emptyList();
        }
        return areaList;
    }

    /**
     * 按城市同步GitHub用户信息
     */
    @Override
    public void syncGitHubUserByLocation() {
        toAreaListByLevel(AREA_LEVEL).forEach(area -> {
            String cityPinyin = area.getPinyin();
            try {
                log.info("城市：[" + area.getName() + "]");
                // 初始化用户Mapping表
                initUserMapping(area);
                // 按分页获取用户信息
                recursionUserPage(area, null, null);
                // 消费用户Mapping表数据
                consumerUser(area);
            } catch (RuntimeException | IOException e) {
                log.error("Sync GitHub Graphql API City={}, Error={}", cityPinyin, e);
            } finally {
                // 删除用户Mapping表
                destroyUserMapping(area);
            }
        });
    }

    /**
     * 消费UserMapping数据，批量写入Mysql中
     *
     * @param area Area 城市
     */
    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public void consumerUser(Area area) {
        CopyOnWriteArrayList<User> userList = userMapping.get(area.getPinyin());
        if (userList.isEmpty()) {
            return;
        } else if (userList.size() <= MAX_LIST_SIZE) {
            gitHubUserMapper.insertUsers(userList);
        } else {
            int pages = (int) Math.ceil((double) userList.size() / (double) MAX_LIST_SIZE);
            for (int i = 0; i < pages; i++) {
                int fromIndex = i * MAX_LIST_SIZE;
                int toIndex = Math.min((i + 1) * MAX_LIST_SIZE, userList.size());
                gitHubUserMapper.insertUsers(userList.subList(fromIndex, toIndex));
            }
        }
    }

    /**
     * 初始化用户Mapping数据
     *
     * @param area Area 城市
     */
    private void initUserMapping(Area area) {
        String key = area.getPinyin();
        if (!userMapping.containsKey(key)) {
            userMapping.put(key, new CopyOnWriteArrayList<>());
        }
    }

    /**
     * 销毁用户Mapping数据
     *
     * @param area Area 城市
     */
    private void destroyUserMapping(Area area) {
        userMapping.remove(area.getPinyin());
    }

    /**
     * 过滤无效的用户信息
     *
     * @param edgesNode GitHub用户信息
     */
    private static boolean filterUserItem(GitHubEdgesNodeResp edgesNode) {
        return ToolUtil.isNotEmpty(edgesNode.getEmail()) && ToolUtil.isNotEmpty(edgesNode.getCompany());
    }

    /**
     * 记录用户基本数据
     *
     * @param area      城市信息
     * @param edgesNode GitHubEdgesNodeResp GitHub用户信息
     */
    private void productionUser(Area area, GitHubEdgesNodeResp edgesNode) {
        if (!filterUserItem(edgesNode)) {
            return;
        }
        // 获取用户数据
        User userItem = new User();
        transformUserItem(userItem, edgesNode);
        userItem.setAreaId(area.getId());

        // 新增用户
        String key = area.getPinyin();
        CopyOnWriteArrayList<User> userList = userMapping.get(key);
        userList.add(userItem);
        userMapping.put(key, userList);
    }

    /**
     * GitHub用户数据与Mysql用户数据转换
     *
     * @param userItem  用户POJO
     * @param edgesNode GitHub用户信息
     */
    private void transformUserItem(User userItem, GitHubEdgesNodeResp edgesNode) {
        userItem.setId(edgesNode.getId());
        userItem.setEmail(edgesNode.getEmail());
        if (userItem.getEmail().length() > 90) {
            userItem.setEmail(userItem.getEmail().substring(0, 90));
        }
        userItem.setLocation(Optional.ofNullable(edgesNode.getLocation()).orElse(""));
        if (userItem.getLocation().length() > 90) {
            userItem.setLocation(userItem.getLocation().substring(0, 90));
        }
        userItem.setCompany(Optional.ofNullable(edgesNode.getCompany()).orElse(""));
        if (userItem.getCompany().length() > 90) {
            userItem.setCompany(userItem.getCompany().substring(0, 90));
        }
        userItem.setUpdatedAt(edgesNode.getUpdatedAt());
        userItem.setAvatarUrl(Optional.ofNullable(edgesNode.getAvatarUrl()).orElse(""));
        if (userItem.getAvatarUrl().length() > 190) {
            userItem.setAvatarUrl(userItem.getAvatarUrl().substring(0, 190));
        }
        userItem.setBio(Optional.ofNullable(edgesNode.getBio()).orElse(""));
        if (userItem.getBio().length() > 240){
            userItem.setBio(userItem.getBio().substring(0, 240));
        }
        userItem.setLogin(Optional.ofNullable(edgesNode.getLogin()).orElse(""));
        if (userItem.getLogin().length() > 240){
            userItem.setLogin(userItem.getLogin().substring(0, 240));
        }
        userItem.setCreatedAt(edgesNode.getCreatedAt());
        userItem.setGitAge(differentYears(userItem.getCreatedAt(), new Date()));
        userItem.setFollowers(Optional.ofNullable(edgesNode.getFollowers().getTotalCount()).orElse(0));
        userItem.setFollowing(Optional.ofNullable(edgesNode.getFollowing().getTotalCount()).orElse(0));
        userItem.setWebsiteUrl(Optional.ofNullable(edgesNode.getWebsiteUrl()).orElse(""));
        if (userItem.getWebsiteUrl().length() > 240){
            userItem.setWebsiteUrl(userItem.getWebsiteUrl().substring(0, 240));
        }
    }

    /**
     * 按分页获取用户列表
     *
     * @param area      城市信息
     * @param after     上一页的页码
     * @param userCount 用户数量
     */
    private void recursionUserPage(Area area, @Nullable String after, @Nullable Integer userCount)
            throws RuntimeException, IOException {
        if (userCount != null && userCount < 0) {
            return;
        }
        // 按城市请求GitHub Graphql OpenAPI 服务
        GitHubGraphqlResp resp = GraphqlClientUtil.doPostJson(area.getPinyin(), after);
        if (!checkResponse(resp) || ToolUtil.isEmpty(resp.getData())) {
            return;
        }
        // 处理GitHub返回的数据
        GitHubDataResp data = resp.getData();
        GitHubSearchResp search = data.getSearch();
        for (GitHubEdgesResp edge : search.getEdges()) {
            if (edge != null) {
                // 记录用户
                productionUser(area, edge.getNode());
            }
        }
        // 分页查询
        GitHubPageInfoResp pageInfo = search.getPageInfo();
        if (userCount == null) {
            userCount = Optional.ofNullable(search.getUserCount()).orElse(null);
            log.info("，人数【" + userCount + "】");
        }
        // 按分页循环获取
        after = pageInfo.getEndCursor();
        System.out.println(userCount);
        userCount -= 30;
        if (userCount > 0) {
            recursionUserPage(area, after, userCount);
        }
    }

    /**
     * 检查GitHub Graphql返回的数据
     */
    private static boolean checkResponse(GitHubGraphqlResp resp) {
        return ToolUtil.isNotEmpty(resp)
                && ToolUtil.isNotEmpty(resp.getData())
                && ToolUtil.isNotEmpty(resp.getData().getSearch())
                && ToolUtil.isNotEmpty(resp.getData().getSearch().getPageInfo().getEndCursor())
                && ToolUtil.isNotEmpty(resp.getData().getSearch().getUserCount());
    }


    /**
     * 查看两个日期之间的年份差
     */
    public static int differentYears(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);

        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        int day1 = cal1.get(Calendar.DAY_OF_YEAR);
        int day2 = cal2.get(Calendar.DAY_OF_YEAR);

        int year1 = cal1.get(Calendar.YEAR);
        int year2 = cal2.get(Calendar.YEAR);
        int day3 = 0;
        if (year1 != year2) {
            int timeDistance = 0;
            for (int i = year1; i < year2; i++) {
                if (i % 4 == 0 && i % 100 != 0 || i % 400 == 0) {
                    timeDistance += 366;
                } else {
                    timeDistance += 365;
                }
            }
            day3 = (timeDistance + (day2 - day1));
        } else {
            day3 = day2 - day1;
        }
        return day3 / 365 > 0 ? day3 / 365 : 1;
    }
}
