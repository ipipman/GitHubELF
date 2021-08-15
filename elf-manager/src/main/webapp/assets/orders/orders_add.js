/**
 * 添加或者修改页面
 */
var OrdersInfoDlg = {
    data: {
        orderName: "",
        orderStatus: "",
        orderNumber: "",
        projectId: "",
        saleId: "",
        createTime: "",
        deleteTime: "",
        updateTime: "",
        creatorName: "",
        isDel: ""
    }
};

layui.use(['form', 'admin', 'ax', 'cascader'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var cascader = layui.cascader;

    var params = admin.getLayerData();
    initForm(params)
    //让当前iframe弹层高度适应
    admin.iframeAuto();

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var field = Object.assign({}, data.field);
        var path = params ? '/orders/editItem' : '/orders/addItem';
        var ajax = new $ax(Feng.ctxPath + path, function (data) {
            if (data.code === 500){
                return Feng.error("操作失败, " + data.message);
            }

            Feng.success("添加成功！");

            //传给上个页面，刷新table用
            admin.putTempData('formOk', true);

            //关掉对话框
            admin.closeThisDialog();

        }, function (data) {
            Feng.error("添加失败！" + data.responseJSON.message)
        });
        field.projectId = field.projectId.split(',')[field.projectId.split(',').length - 1];
        ajax.set(field);
        ajax.start();

        return false;
    });

    function initForm(params) {
        var $ = layui.jquery;
        console.log(params);
        if (params && params.orderName) {
            $('#orderName').val(params.orderName)
        }
        if (params && params.orderNumber) {
            $('#orderNumber').val(params.orderNumber)
        }
        if (params && params.id){
            $('#id').val(params.id);
        }
        initLinkageData(params);
    }

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

});