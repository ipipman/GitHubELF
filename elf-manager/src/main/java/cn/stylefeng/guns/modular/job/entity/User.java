package cn.stylefeng.guns.modular.job.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ipman
 * @since 2021-08-23
 */
@TableName("t_user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId(value = "user_id", type = IdType.AUTO)
    private Long userId;

    /**
     * 用户唯一标识
     */
    @TableField("id")
    private String id;

    /**
     * 用户邮箱
     */
    @TableField("email")
    private String email;

    /**
     * 用户地理位置
     */
    @TableField("location")
    private String location;

    /**
     * 用户ID
     */
    @TableField("area_id")
    private Integer areaId;

    /**
     * 公司
     */
    @TableField("company")
    private String company;

    /**
     * 用户最新活跃时间
     */
    @TableField("updated_at")
    private Date updatedAt;

    /**
     * 用户头像
     */
    @TableField("avatar_url")
    private String avatarUrl;

    /**
     * 个人简介
     */
    @TableField("bio")
    private String bio;

    /**
     * 登录ID
     */
    @TableField("login")
    private String login;

    /**
     * 用户创建时间
     */
    @TableField("created_at")
    private Date createdAt;

    /**
     * github年限
     */
    @TableField("git_age")
    private Integer gitAge;

    /**
     * 跟随者
     */
    @TableField("followers")
    private Integer followers;

    /**
     * 关注过多个项目
     */
    @TableField("following")
    private Integer following;

    /**
     *  个人博客
     */
    @TableField("website_url")
    private String websiteUrl;


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Integer getGitAge() {
        return gitAge;
    }

    public void setGitAge(Integer gitAge) {
        this.gitAge = gitAge;
    }

    public Integer getFollowers() {
        return followers;
    }

    public void setFollowers(Integer followers) {
        this.followers = followers;
    }

    public Integer getFollowing() {
        return following;
    }

    public void setFollowing(Integer following) {
        this.following = following;
    }

    public String getWebsiteUrl() {
        return websiteUrl;
    }

    public void setWebsiteUrl(String websiteUrl) {
        this.websiteUrl = websiteUrl;
    }

    @Override
    public String toString() {
        return "User{" +
        "userId=" + userId +
        ", id=" + id +
        ", email=" + email +
        ", location=" + location +
        ", areaId=" + areaId +
        ", company=" + company +
        ", updatedAt=" + updatedAt +
        ", avatarUrl=" + avatarUrl +
        ", bio=" + bio +
        ", login=" + login +
        ", createdAt=" + createdAt +
        ", gitAge=" + gitAge +
        ", followers=" + followers +
        ", following=" + following +
        ", websiteUrl=" + websiteUrl +
        "}";
    }
}
