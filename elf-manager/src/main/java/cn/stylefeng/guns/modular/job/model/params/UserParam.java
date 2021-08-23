package cn.stylefeng.guns.modular.job.model.params;

import lombok.Data;
import cn.stylefeng.roses.kernel.model.validator.BaseValidatingParam;
import java.util.Date;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 
 * </p>
 *
 * @author ipman
 * @since 2021-08-23
 */
@Data
public class UserParam implements Serializable, BaseValidatingParam {

    private static final long serialVersionUID = 1L;


    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户唯一标识
     */
    private String id;

    /**
     * 用户邮箱
     */
    private String email;

    /**
     * 用户地理位置
     */
    private String location;

    /**
     * 用户ID
     */
    private Integer areaId;

    /**
     * 公司
     */
    private String company;

    /**
     * 用户最新活跃时间
     */
    private Date updatedAt;

    /**
     * 用户头像
     */
    private String avatarUrl;

    /**
     * 个人简介
     */
    private String bio;

    /**
     * 登录ID
     */
    private String login;

    /**
     * 用户创建时间
     */
    private Date createdAt;

    /**
     * github年限
     */
    private Integer gitAge;

    /**
     * 跟随者
     */
    private Integer followers;

    /**
     * 关注过多个项目
     */
    private Integer following;

    /**
     *  个人博客
     */
    private String websiteUrl;

    @Override
    public String checkParam() {
        return null;
    }

}
