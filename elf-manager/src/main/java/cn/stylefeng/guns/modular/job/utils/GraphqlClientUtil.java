package cn.stylefeng.guns.modular.job.utils;

import org.mountcloud.graphql.GraphqlClient;
import org.mountcloud.graphql.request.query.DefaultGraphqlQuery;
import org.mountcloud.graphql.request.query.GraphqlQuery;
import org.mountcloud.graphql.response.GraphqlResponse;

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

    public static void test() throws IOException {

        String json = "{\"query\":\"{ search(query:\\\"location:hangzhou\\\", type: USER, first:10, after:\\\"Y3Vyc29yOjEw\\\") { userCount pageInfo{ startCursor endCursor hasNextPage } edges { node { ... on User { id login avatarUrl email createdAt updatedAt company websiteUrl location bio following { totalCount } followers { totalCount } organizations( first:10) { totalCount nodes { id name avatarUrl websiteUrl } } repositories(first: 5, isFork: false, orderBy: {field: STARGAZERS, direction: DESC}) { totalCount nodes { stargazerCount forkCount isPrivate description repositoryTopics(first: 10) { totalCount nodes { topic { name } } } issues { totalCount } languages(first: 10) { nodes { name } } primaryLanguage{ name } } } } } } } }\"}";
        String serverUrl = "https://api.github.com/graphql";
        Map<String, String> headers = new HashMap<>();
        headers.put("Authorization", "bearer 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");
        System.out.println(HttpClientUtil.doPostJson(serverUrl, json, headers));


    }
}
