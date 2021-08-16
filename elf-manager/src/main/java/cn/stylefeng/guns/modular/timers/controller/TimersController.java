package cn.stylefeng.guns.modular.timers.controller;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.timers.entity.Timers;
import cn.stylefeng.guns.modular.timers.model.params.TimersParam;
import cn.stylefeng.guns.modular.timers.service.TimersService;
import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.core.reqres.response.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 定时任务控制器
 *
 * @author ipman
 * @Date 2021-08-16 10:05:42
 */
@Controller
@RequestMapping("/timers")
public class TimersController extends BaseController {

    private String PREFIX = "/timers";

    @Autowired
    private TimersService timersService;

    /**
     * 跳转到主页面
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("")
    public String index() {
        return PREFIX + "/timers.html";
    }

    /**
     * 新增页面
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/add")
    public String add() {
        return PREFIX + "/timers_add.html";
    }

    /**
     * 编辑页面
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/edit")
    public String edit() {
        return PREFIX + "/timers_edit.html";
    }

    /**
     * 新增接口
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/addItem")
    @ResponseBody
    public ResponseData addItem(TimersParam timersParam) {
        this.timersService.add(timersParam);
        return ResponseData.success();
    }

    /**
     * 编辑接口
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/editItem")
    @ResponseBody
    public ResponseData editItem(TimersParam timersParam) {
        this.timersService.update(timersParam);
        return ResponseData.success();
    }

    /**
     * 删除接口
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseData delete(TimersParam timersParam) {
        this.timersService.delete(timersParam);
        return ResponseData.success();
    }

    /**
     * 查看详情接口
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseData detail(TimersParam timersParam) {
        Timers detail = this.timersService.getById(timersParam.getTimerId());
        return ResponseData.success(detail);
    }

    /**
     * 查询列表
     *
     * @author ipman
     * @Date 2021-08-16
     */
    @ResponseBody
    @RequestMapping("/list")
    public LayuiPageInfo list(TimersParam timersParam) {
        return this.timersService.findPageBySpec(timersParam);
    }

}


