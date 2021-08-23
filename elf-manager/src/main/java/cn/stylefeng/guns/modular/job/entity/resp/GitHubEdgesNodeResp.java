package cn.stylefeng.guns.modular.job.entity.resp;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.entity.resp
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 11:42 上午
 */
@Data
public class GitHubEdgesNodeResp {


    /**
     * id : MDQ6VXNlcjUwNzYxNQ==
     * login : afc163
     * avatarUrl : https://avatars.githubusercontent.com/u/507615?u=63a8ef8e8876c4c1fad07a7737684f5281fedaaa&amp;v=4
     * email : afc163@gmail.com
     * createdAt : 2010-12-03T06:35:28Z
     * updatedAt : 2021-08-05T08:27:21Z
     * company : Alipay
     * websiteUrl : https://twitter.com/afc163
     * location : Hangzhou, China
     * bio : Life is a box of chaos
     * following : {"totalCount":399}
     * followers : {"totalCount":5719}
     * organizations : {"totalCount":7,"nodes":[{"id":"MDEyOk9yZ2FuaXphdGlvbjUzOTE0OQ==","name":"seajs","avatarUrl":"https://avatars.githubusercontent.com/u/539149?v=4","websiteUrl":"seajs.org/"},{"id":"MDEyOk9yZ2FuaXphdGlvbjE4NDMwNjk=","name":"aralejs","avatarUrl":"https://avatars.githubusercontent.com/u/1843069?v=4","websiteUrl":"aralejs.org"},{"id":"MDEyOk9yZ2FuaXphdGlvbjI3NDAwNjA=","name":"Static Package Manager","avatarUrl":"https://avatars.githubusercontent.com/u/2740060?v=4","websiteUrl":"http://spmjs.io"},{"id":"MDEyOk9yZ2FuaXphdGlvbjM0MDQ4ODI=","name":"aliceui","avatarUrl":"https://avatars.githubusercontent.com/u/3404882?v=4","websiteUrl":"http://aliceui.org"},{"id":"MDEyOk9yZ2FuaXphdGlvbjk0NDE0MTQ=","name":"react-component","avatarUrl":"https://avatars.githubusercontent.com/u/9441414?v=4","websiteUrl":"http://react-component.github.io"},{"id":"MDEyOk9yZ2FuaXphdGlvbjEyMTAxNTM2","name":"Ant Design Team","avatarUrl":"https://avatars.githubusercontent.com/u/12101536?v=4","websiteUrl":"https://ant.design"},{"id":"MDEyOk9yZ2FuaXphdGlvbjM0NjAyNDE5","name":"语雀","avatarUrl":"https://avatars.githubusercontent.com/u/34602419?v=4","websiteUrl":"https://yuque.com"}]}
     * repositories : {"totalCount":72,"nodes":[{"stargazerCount":2697,"forkCount":193,"isPrivate":false,"description":"A curated list of Ant Design resources and related projects. The main idea is that everyone can contribute here, so we can have a central repository of informations about Ant Design that we keep up-to-date","repositoryTopics":{"totalCount":0,"nodes":[]},"issues":{"totalCount":22},"languages":{"nodes":[]},"primaryLanguage":null},{"stargazerCount":2636,"forkCount":412,"isPrivate":false,"description":"Transform Markdown(and other static files with transformers) into a SPA website using React.","repositoryTopics":{"totalCount":0,"nodes":[]},"issues":{"totalCount":172},"languages":{"nodes":[{"name":"JavaScript"},{"name":"HTML"},{"name":"CSS"}]},"primaryLanguage":{"name":"JavaScript"}},{"stargazerCount":1666,"forkCount":249,"isPrivate":false,"description":"😁 git commit message emoji 使用指南","repositoryTopics":{"totalCount":2,"nodes":[{"topic":{"name":"git"}},{"topic":{"name":"emoji"}}]},"issues":{"totalCount":3},"languages":{"nodes":[]},"primaryLanguage":null},{"stargazerCount":1043,"forkCount":119,"isPrivate":false,"description":"A 🇨🇳 and 🇺🇸 translate tool in your command line.","repositoryTopics":{"totalCount":7,"nodes":[{"topic":{"name":"translation"}},{"topic":{"name":"javascript"}},{"topic":{"name":"command-line"}},{"topic":{"name":"command-line-tools"}},{"topic":{"name":"nodejs"}},{"topic":{"name":"npm-package"}},{"topic":{"name":"node"}}]},"issues":{"totalCount":48},"languages":{"nodes":[{"name":"JavaScript"}]},"primaryLanguage":{"name":"JavaScript"}},{"stargazerCount":483,"forkCount":127,"isPrivate":false,"description":"专注Sea.js，深入浅出分析Sea.js模块机制","repositoryTopics":{"totalCount":0,"nodes":[]},"issues":{"totalCount":24},"languages":{"nodes":[{"name":"JavaScript"},{"name":"HTML"}]},"primaryLanguage":{"name":"JavaScript"}}]}
     */

    private String id;
    private String login;
    private String avatarUrl;
    private String email;
    private Date createdAt;
    private Date updatedAt;
    private String company;
    private String websiteUrl;
    private String location;
    private String bio;
    private GitHubFollowingResp following;
    private GitHubFollowersResp followers;
    private GitHubOrganizationsResp organizations;
    private GitHubRepositoriesResp repositories;

}
