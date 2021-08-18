package cn.stylefeng.guns.modular.job.entity.resp;

import lombok.Data;

import java.util.List;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.entity.resp
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 11:51 上午
 */
@Data
public class GitHubOrganizationsResp {
    private Integer totalCount;
    private List<GitHubOrganizationsNodesResp> nodes;
}
