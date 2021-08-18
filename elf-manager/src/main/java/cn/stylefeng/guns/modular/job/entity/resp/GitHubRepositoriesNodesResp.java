package cn.stylefeng.guns.modular.job.entity.resp;

import lombok.Data;

import java.util.List;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.entity.resp
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 11:54 上午
 */
@Data
public class GitHubRepositoriesNodesResp {

    /**
     * stargazerCount : 2697
     * forkCount : 193
     * isPrivate : false
     * description : A curated list of Ant Design resources and related projects. The main idea is that everyone can contribute here, so we can have a central repository of informations about Ant Design that we keep up-to-date
     * repositoryTopics : {"totalCount":0,"nodes":[]}
     * issues : {"totalCount":22}
     * languages : {"nodes":[]}
     * primaryLanguage : null
     */

    private Integer stargazerCount;
    private Integer forkCount;
    private Boolean isPrivate;
    private String description;
    private GitHubRepositoryTopicsResp repositoryTopics;
    private GitHubIssuesResp issues;
    private GitHubLanguagesResp languages;
    private GitHubPrimaryLanguageResp primaryLanguage;

}
