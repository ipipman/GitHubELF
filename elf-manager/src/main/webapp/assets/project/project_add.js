/**
 * 添加或者修改页面
 */
var ProjectInfoDlg = {
    data: {
        projectName: "",
        projectStatus: "",
        saleId: "",
        createTime: "",
        deleteTime: "",
        updateTime: "",
        creatorName: "",
        isDel: ""
    }
};

layui.use(['form', 'admin', 'ax', 'cascader', 'formX'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var cascader = layui.cascader;
    var params = admin.getLayerData();
    //让当前iframe弹层高度适应
    // admin.iframeAuto();
    initForm(params);

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var field = Object.assign({}, data.field);
        var path = params ? '/project/editItem' : '/project/addItem';
        var ajax = new $ax(Feng.ctxPath + path, function (data) {
            if (data.code === 500) {
                return Feng.error('操作失败,' + data.message)
            }
            Feng.success("操作成功！");
            admin.putTempData('formOk', true);
            admin.closeThisDialog();
        }, function (data) {
            Feng.error("操作失败！" + data.responseJSON.message)
        });
        field.saleId = field.saleId.split(',')[field.saleId.split(',').length - 1];
        ajax.set(field);
        ajax.start();

        return false;
    });
    function initForm(params) {
        var $ = layui.jquery;
        console.log(params);
        if (params && params.projectName) {
            $('#projectName').val(params.projectName)
        }
        if (params && params.saleId) {
            $('#saleId').val(params.saleId)
        }
        if (params && params.id){
            $('#id').val(params.id)
        }
        initLinkageData(params);
    }

    function initLinkageData(params) {
        var ajax = new $ax(Feng.ctxPath + "/sale/linkage", function (data) {
            if (data.code === 500) {
                Feng.error(data.message);
                admin.putTempData('formOK', true);
                return;
            }
            var defaultValue = window.getFullPath(data.data, params && params.saleId);
            console.log(defaultValue);
            initSelect(defaultValue, data.data)
        }, function (data) {
            Feng.error("请先添加销售组！" + data.responseJSON.message)
        });
        ajax.start();
    }

    function initSelect(defaultValue, data) {
        var select = cascader.render({
            elem: '#saleId',
            itemHeight: '220px',
            data: data
        });
        // defaultValue "A,AA"
        if (defaultValue) {
            select.setValue(defaultValue);
        }
        return select;
    }


});