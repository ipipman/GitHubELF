package cn.stylefeng.guns.modular.area.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ipman
 * @since 2021-08-15
 */
@TableName("t_area")
public class Area implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("pid")
    private Integer pid;

    @TableField("name")
    private String name;

    @TableField("pinyin")
    private String pinyin;

    @TableField("level")
    private Integer level;

    @TableField("areatype")
    private Integer areatype;

    @TableField("type_name")
    private String typeName;

    @TableField("status")
    private Integer status;

    @TableField("pid_name")
    private String pidName;

    @TableField("area_id")
    private Integer areaId;

    /**
     * 城市码
     */
    @TableField("code")
    private Integer code;

    /**
     * 目的地id
     */
    @TableField("destination_id")
    private Integer destinationId;

    /**
     * pv
     */
    @TableField("pv")
    private Integer pv;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPinyin() {
        return pinyin;
    }

    public void setPinyin(String pinyin) {
        this.pinyin = pinyin;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getAreatype() {
        return areatype;
    }

    public void setAreatype(Integer areatype) {
        this.areatype = areatype;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getPidName() {
        return pidName;
    }

    public void setPidName(String pidName) {
        this.pidName = pidName;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Integer getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(Integer destinationId) {
        this.destinationId = destinationId;
    }

    public Integer getPv() {
        return pv;
    }

    public void setPv(Integer pv) {
        this.pv = pv;
    }

    @Override
    public String toString() {
        return "Area{" +
        "id=" + id +
        ", pid=" + pid +
        ", name=" + name +
        ", pinyin=" + pinyin +
        ", level=" + level +
        ", areatype=" + areatype +
        ", typeName=" + typeName +
        ", status=" + status +
        ", pidName=" + pidName +
        ", areaId=" + areaId +
        ", code=" + code +
        ", destinationId=" + destinationId +
        ", pv=" + pv +
        "}";
    }
}
