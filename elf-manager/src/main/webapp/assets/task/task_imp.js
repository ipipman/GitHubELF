/**
 * 详情对话框
 */
var TaskInfoDlg = {
    data: {
        fileName: "",
        projectId: "",
    }
};

layui.use(['form', 'admin', 'ax', 'cascader'], function () {

    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var cascader = layui.cascader;

    var params = admin.getLayerData();
    initLinkageData(params);

    function initLinkageData(params) {
        var ajax = new $ax(Feng.ctxPath + "/project/linkage", function (data) {
            if (data.code === 500) {
                Feng.error(data.message);
                admin.putTempData('formOK', true);
                return;
            }
            var defaultValue = window.getFullPath(data.data, params && params.projectId);
            initSelect(defaultValue, data.data)
        }, function (data) {
            Feng.error("请先添加项目！" + data.responseJSON.message)
        });
        ajax.start();
    }

    function initSelect(defaultValue, data) {
        var select = cascader.render({
            elem: '#projectId',
            itemHeight: '220px',
            data: data
        });
        // defaultValue "A,AA"
        if (defaultValue) {
            select.setValue(defaultValue);
        }
        return select;
    }

    //让当前iframe弹层高度适应
    admin.iframeAuto();

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var fileString = $("#fileName").val();
        var suffixStr = fileString.substring(fileString.lastIndexOf(".") + 1);//文件后缀
        if (suffixStr !== "xls" && suffixStr !== "xlsx") {
            Feng.error("必须上传xls 或者xlsx文件");
            return;
        }
        if (!$("#projectId").val()) {
            Feng.error("项目组必填");
            return;
        }
        var formData = new FormData();
        formData.append("fileName", $("#fileName")[0].files[0]);
        formData.append("projectId", $("#projectId").val().split(',')[$("#projectId").val().split(',').length - 1]);
        //提交信息
        $.ajax({
            type: "post",
            url: Feng.ctxPath + "/task/import",
            dataType: "json",
            async: false,
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.code === 200) {
                    Feng.success("导入成功！");
                    //传给上个页面，刷新table用
                    admin.putTempData('formOk', true);
                    //关掉对话框
                    admin.closeThisDialog();
                } else {
                    Feng.info(data.message);
                }
            },
            error: function (data) {
                Feng.error("批量新增失败!" + data.responseJSON.message + "!");
            }
        });

        // var field = Object.assign({}, data.field);
        // var ajax = new $ax(Feng.ctxPath + "/task/import", function (data) {
        //     Feng.success("导入成功！");
        //
        //     //传给上个页面，刷新table用
        //     admin.putTempData('formOk', true);
        //
        //     //关掉对话框
        //     admin.closeThisDialog();
        //
        // }, function (data) {
        //     Feng.error("导入失败！" + data.responseJSON.message)
        // });
        // field.projectId = field.projectId.split(',')[field.projectId.split(',').length - 1];
        // ajax.set(field);
        // //ajax.set(data.field);
        // ajax.start();

        return false;
    });

});