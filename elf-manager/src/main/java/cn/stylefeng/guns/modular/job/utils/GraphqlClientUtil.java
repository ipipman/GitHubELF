package cn.stylefeng.guns.modular.job.utils;

import cn.stylefeng.guns.modular.job.entity.req.GitHubGraphqlFormatReq;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubDataResp;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubGraphqlResp;
import cn.stylefeng.guns.modular.job.entity.resp.GitHubRepositoriesNodesResp;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import org.apache.commons.lang3.StringUtils;
import org.mountcloud.graphql.GraphqlClient;
import org.mountcloud.graphql.request.query.DefaultGraphqlQuery;
import org.mountcloud.graphql.request.query.GraphqlQuery;
import org.mountcloud.graphql.response.GraphqlResponse;
import org.springframework.lang.Nullable;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ipipman on 2021/8/16.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.utils
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/16 3:58 下午
 */

public class GraphqlClientUtil {

    public static GitHubGraphqlResp doPostJson(String location, @Nullable String after) throws IOException {
        if (StringUtils.isBlank(location)) {
            return null;
        }
        String response = HttpClientUtil.doPostJson(
                GitHubGraphqlFormatReq.SERVER_URL,
                new GitHubGraphqlFormatReq(location, after).toString(),
                GitHubGraphqlFormatReq.SERVER_HANDLER
        );
        if (response != null) {
            return JSONObject.parseObject(response,
                    new TypeReference<GitHubGraphqlResp>() {
                    });
        }
        return null;
    }
}
