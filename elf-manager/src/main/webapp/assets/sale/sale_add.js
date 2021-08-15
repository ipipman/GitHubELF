/**
 * 添加或者修改页面
 */
var SaleInfoDlg = {
    data: {
        saleName: "",
        salePhone: "",
        saleEmail: "",
        saleGroupId: "",
        createTime: "",
        updateTime: "",
        deleteTime: "",
        creatorName: "",
        isDel: ""
    }
};

var Sale = {
    tableId: "saleTable"
};

layui.use(['admin', 'ax', 'form', 'cascader', 'formX', 'table'], function () {
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var cascader = layui.cascader;
    var params = admin.getLayerData();
    var formX = layui.formX;

    initForm(params);

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var path = params ? '/sale/editItem' : '/sale/addItem';
        var ajax = new $ax(Feng.ctxPath + path, function (data) {
            if (data.code === 500) {
                return Feng.error('操作失败' + data.message)
            }
            Feng.success('操作成功!');
            admin.putTempData('formOk', true);
            admin.closeThisDialog();
        }, function (data) {
            Feng.error('操作失败' + data.responseJSON.message)
        });
        ajax.set(data.field);
        ajax.start();
        return false;
    });

    function initSelect(defaultValue, data) {
        var select = cascader.render({
            elem: '#saleGroupValue',
            itemHeight: '220px',
            data: data
        });
        // defaultValue "A,AA"
        if (defaultValue) {
            select.setValue(defaultValue);
        }
        return select;
    }

    function initForm(params) {
        var $ = layui.jquery;
        console.log(params);
        if (params && params.saleName) {
            $('#saleName').val(params.saleName)
        }
        if (params && params.salePhone) {
            $('#salePhoneValue').val(params.salePhone)
        }
        if (params && params.saleEmail) {
            $('#saleEmail').val(params.saleEmail)
        }
        if (params && params.id) {
            $('#saleId').val(params.id)
        }
        initLinkageData(params);
    }

    function initLinkageData(params) {
        var ajax = new $ax(Feng.ctxPath + "/saleGroup/linkage", function (data) {
            if (data.code === 500) {
                Feng.error(data.message);
                admin.putTempData('formOK', true);
                return;
            }
            var defaultValue = window.getFullPath(data.data, params && params.saleGroupId);
            initSelect(defaultValue, data.data)
        }, function (data) {
            Feng.error("请先添加销售组！" + data.responseJSON.message)
        });
        ajax.start();
    }
});