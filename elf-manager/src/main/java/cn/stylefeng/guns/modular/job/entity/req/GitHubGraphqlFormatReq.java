package cn.stylefeng.guns.modular.job.entity.req;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.springframework.lang.Nullable;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.entity.req
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 2:28 下午
 */
@Data
public class GitHubGraphqlFormatReq {

    private String location;

    private String page = "";

    public final static String SERVER_URL = "https://api.github.com/graphql";

    public final static Map<String, String> SERVER_HANDLER;

    static {
        SERVER_HANDLER = new ConcurrentHashMap<>();
        SERVER_HANDLER.put("Authorization", "bearer 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");
    }

    public GitHubGraphqlFormatReq(String location, @Nullable String after) {
        this.location = location;
        if (StringUtils.isNoneBlank(after)) {
            this.page = ", after:\\\"" + after + "\\\"";
        }
    }

    @Override
    public String toString() {
        return "{\"query\":" +
                "\"{ search(query:" +
                "\\\"location:" + location + "\\\", " +
                "    type: USER, " +
                "    first:30 " + page + ") { userCount pageInfo{ startCursor endCursor hasNextPage } " +
                "   edges { node { " +
                "   ... on User { " +
                "       id login avatarUrl email createdAt updatedAt company websiteUrl location bio " +
                "       following { totalCount } " +
                "       followers { totalCount } " +
                "       organizations( first:5) { totalCount nodes { id name avatarUrl websiteUrl } } " +
                "       repositories(first: 5, isFork: false, orderBy: {field: STARGAZERS, direction: DESC}) " +
                "           { totalCount nodes { stargazerCount forkCount isPrivate description " +
                "           repositoryTopics(first: 5) " +
                "           { totalCount nodes { topic { name } } } " +
                "           issues { totalCount } " +
                "           languages(first: 5) " +
                "           { nodes { name } } " +
                "           primaryLanguage{ name } " +
                "       } } } } }" +
                " } }\"}";
    }
}
