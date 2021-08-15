package cn.stylefeng.guns.modular.area.model.result;

import lombok.Data;
import java.util.Date;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 
 * </p>
 *
 * @author ipman
 * @since 2021-08-15
 */
@Data
public class AreaResult implements Serializable {

    private static final long serialVersionUID = 1L;


    private Integer id;

    private Integer pid;

    private String name;

    private String pinyin;

    private Integer level;

    private Integer areatype;

    private String typeName;

    private Integer status;

    private String pidName;

    private Integer areaId;

    /**
     * 城市码
     */
    private Integer code;

    /**
     * 目的地id
     */
    private Integer destinationId;

    /**
     * pv
     */
    private Integer pv;

}
