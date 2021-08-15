/**
 * 添加或者修改页面
 */
var JsInfoDlg = {
    data: {
        jsName: "",
        jsText: ""
    }
};

layui.use(['form', 'admin', 'ax'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;

    //让当前iframe弹层高度适应
    admin.iframeAuto();
    var params = admin.getLayerData();
    initForm(params);

    function initForm(params) {
        var $ = layui.jquery;
        if (params && params.jsName) {
            $('#jsName').val(params.jsName)
        }
        if (params && params.jsText) {
            $('#jsText').val(params.jsText)
        }
        if (params && params.id) {
            $('#id').val(params.id)
        }
    }

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var path = params ? '/js/editItem' : '/js/addItem';
        var ajax = new $ax(path, function (data) {
            if (data.code === 500) {
                return Feng.error("操作失败!" + data.message);
            }

            Feng.success("添加成功！");
            //传给上个页面，刷新table用
            admin.putTempData('formOk', true);

            //关掉对话框
            admin.closeThisDialog();

        }, function (data) {
            Feng.error("添加失败！" + data.responseJSON.message)
        });
        ajax.set(data.field);
        ajax.start();

        return false;
    });

});