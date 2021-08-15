package cn.stylefeng.guns.modular.area.controller;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.model.params.AreaParam;
import cn.stylefeng.guns.modular.area.service.AreaService;
import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.core.reqres.response.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 控制器
 *
 * @author ipman
 * @Date 2021-08-15 12:12:10
 */
@Controller
@RequestMapping("/area")
public class AreaController extends BaseController {

    private String PREFIX = "/area";

    @Autowired
    private AreaService areaService;

    /**
     * 跳转到主页面
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("")
    public String index() {
        return PREFIX + "/area.html";
    }

    /**
     * 新增页面
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/add")
    public String add() {
        return PREFIX + "/area_add.html";
    }

    /**
     * 编辑页面
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/edit")
    public String edit() {
        return PREFIX + "/area_edit.html";
    }

    /**
     * 新增接口
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/addItem")
    @ResponseBody
    public ResponseData addItem(AreaParam areaParam) {
        this.areaService.add(areaParam);
        return ResponseData.success();
    }

    /**
     * 编辑接口
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/editItem")
    @ResponseBody
    public ResponseData editItem(AreaParam areaParam) {
        this.areaService.update(areaParam);
        return ResponseData.success();
    }

    /**
     * 删除接口
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseData delete(AreaParam areaParam) {
        this.areaService.delete(areaParam);
        return ResponseData.success();
    }

    /**
     * 查看详情接口
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseData detail(AreaParam areaParam) {
        Area detail = this.areaService.getById(areaParam.getId());
        return ResponseData.success(detail);
    }

    /**
     * 查询列表
     *
     * @author ipman
     * @Date 2021-08-15
     */
    @ResponseBody
    @RequestMapping("/list")
    public LayuiPageInfo list(AreaParam areaParam) {
        return this.areaService.findPageBySpec(areaParam);
    }

}


