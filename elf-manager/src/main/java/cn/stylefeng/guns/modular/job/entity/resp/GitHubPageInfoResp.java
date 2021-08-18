package cn.stylefeng.guns.modular.job.entity.resp;

import lombok.Data;

/**
 * Created by ipipman on 2021/8/18.
 *
 * @version V1.0
 * @Package cn.stylefeng.guns.modular.job.entity.resp
 * @Description: (用一句话描述该文件做什么)
 * @date 2021/8/18 11:37 上午
 */
@Data
public class GitHubPageInfoResp {

    private String startCursor;
    private String endCursor;
    private Boolean hasNextPage;

}
