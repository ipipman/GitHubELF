/**
 * 添加或者修改页面
 */
var TaskInfoDlg = {
    data: {
        taskName: "",
        taskDate: "",
        taskOs: "",
        taskImprCount: "",
        taskImprUrls: "",
        taskClickCount: "",
        taskClickUrl: "",
        taskReferer: "",
        orderId: "",
        taskTwojump: "",
        taskOutjump: "",
        taskAreaId: "",
        isDel: "",
        createTime: "",
        updateTime: "",
        deleteTime: "",
        creatorName: "",
        crowdId: "",
        taskStatus: "",
        jsId: "",
        id: "",
        isFlash: "",
    }
};

layui.use(['form', 'admin', 'ax', 'cascader', 'formX'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var params = admin.getLayerData();
    //让当前iframe弹层高度适应
    admin.iframeAuto();

    var cascader = layui.cascader;


    initLinkageData(params);

    function initLinkageData(params) {
        var elems = ['area', 'orders', 'crowd', 'js'];
        for (let i = 0; i < elems.length; i++) {
            let elem = elems[i];
            var ajax = new $ax(Feng.ctxPath + "/" + elem + "/linkage", function (data) {
                if (data.code === 500) {
                    Feng.error(data.message);
                    admin.putTempData('formOK', true);
                    return;
                }
                var defaultValue = window.getFullPath(data.data, params && params[elem + "Id"] || '0');
                console.log('defaultValue', defaultValue, data.data)
                initSelect(defaultValue, data.data, elem)
            }, function (data) {
                Feng.error("" + data.responseJSON.message)
            });
            ajax.start();
        }
    }

    function initSelect(defaultValue, data, elem) {
        console.log(1);
        var select = cascader.render({
            elem: '#' + elem + 'Id',
            itemHeight: '220px',
            data: data
        });
        if (defaultValue) {
            select.setValue(defaultValue);
        }
        return select;
    }

    function setValue(params) {
        for (var i in TaskInfoDlg.data) {
            console.log(params)
            if (params[i] !== undefined) {
                let val = params[i];
                if (i === "isFlash"){
                    val = params[i] ? 1 : 0;
                }
                $('#' + i).val(val)
            }
            form.render('select');
        }
    }

    initForm(params)

    function initForm(params) {
        var $ = layui.jquery;
        params && setValue(params);
        var defaultValue = window.getFullPath(citysData, params && params.area || '17');
        if (params) {
            if (params && params.taskImprUrlsList.length) {
                initImprInput('impr', params.taskImprUrlsList);
            } else {
                initImprInput('impr');
            }
        } else {
            initImprInput('impr');
        }
    }


    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {

        var field = Object.assign({}, data.field);
        var path = params ? '/task/editItem' : '/task/addItem';

        field.ordersId = parseInt(field.ordersId.split(',')[field.ordersId.split(',').length - 1]);
        field.areaId = parseInt(field.areaId.split(',')[field.areaId.split(',').length - 1]);
        field.crowdId = parseInt(field.crowdId.split(',')[field.crowdId.split(',').length - 1]);
        field.taskTwojump = parseInt(field.taskTwojump) || 0;
        field.jsId = parseInt(field.jsId) || 0;
        field.taskImprCount = parseInt(field.taskImprCount) || 0;
        field.taskClickCount = parseInt(field.taskClickCount) || 0;
        field.id = parseInt(field.id) || 0;
        field.isFlash = parseInt(field.isFlash) || 0;
        field.taskOs = parseInt(field.taskOs) || 1;

        var ajax = new $ax(Feng.ctxPath + path, function (data) {
            if (data.code === 500) {
                return Feng.error(data.message);
            }
            Feng.success("操作成功！");
            //传给上个页面，刷新table用
            admin.putTempData('formOk', true);

            //关掉对话框
            admin.closeThisDialog();

        }, function (data) {
            return Feng.error("操作失败！" + data.responseJSON.message)
        });
        ajax.set(field);
        ajax.start();

        return false;
    });
    $('body').on('click', '.addImprBtn', function () {
        var $box = $(this).closest('.impr-group');
        $box.append(
            '<div class="layui-row" style="display: flex">\n' +
            '                                <input  name="taskImprUrls[]" placeholder="请输入" type="text" class="layui-input taskImprUrls" lay-verify="urlX" style="width:200px;display: inline-block"/>\n' +
            '                                <button type="button" class="layui-btn layui-btn-primary addImprBtn">\n' +
            '                                    <i class="layui-icon">&#xe654;</i>\n' +
            '                                </button>\n' +
            '                                <button type="button" class="layui-btn layui-btn-primary deleteBtn">\n' +
            '                                    <i class="layui-icon">&#xe640;</i>\n' +
            '                                </button>\n' +
            '                            </div>'
        )
    })

    $('body').on('click', '.deleteBtn', function () {
        // if ($(this).closest('.layui-row').length < 2) {
        //     return;
        // }
        $(this).closest('.layui-row').remove();
    })

    //

    function initImprInput(type, list) {
        var inputName = '';
        var addBtnClass = '';
        var inputClass = '';
        var boxClass = '';
        if (type == 'impr') {
            inputName = 'taskImprUrls';
            inputClass = 'taskImprUrls'
            addBtnClass = 'addImprBtn';
            boxClass = "impr-group";
        } else {
            inputName = 'taskClickUrl';
            inputClass = 'taskClickUrls';
            addBtnClass = 'addClickBtn';
            boxClass = "click-group";
        }
        var str = "";
        try {
            for (var i = 0; i < list.length; i++) {
                var item = list[i];
                str += '<div class="layui-row">\n' +
                    '                                <input  name="' + inputName + '[]" value="' + item + '" placeholder="请输入" type="text" class="layui-input ' + inputClass + '" lay-verify="urlX" style="width:200px;display: inline-block"/>\n' +
                    '                                <button type="button" class="layui-btn layui-btn-primary ' + addBtnClass + '">\n' +
                    '                                    <i class="layui-icon">&#xe654;</i>\n' +
                    '                                </button>\n' +
                    '                                <button type="button" class="layui-btn layui-btn-primary deleteBtn">\n' +
                    '                                    <i class="layui-icon">&#xe640;</i>\n' +
                    '                                </button>\n' +
                    '                            </div>'
            }
            $('.' + boxClass).append(str)
        } catch (e) {
            $('.' + boxClass).append(
                '<div class="layui-row">\n' +
                '                                <input  name="' + inputName + '[]" placeholder="请输入" type="text" class="layui-input ' + inputClass + '" lay-verify="urlX" style="width:200px;display: inline-block"/>\n' +
                '                                <button type="button" class="layui-btn layui-btn-primary ' + addBtnClass + '">\n' +
                '                                    <i class="layui-icon">&#xe654;</i>\n' +
                '                                </button>\n' +
                '                                <button type="button" class="layui-btn layui-btn-primary deleteBtn">\n' +
                '                                    <i class="layui-icon">&#xe640;</i>\n' +
                '                                </button>\n' +
                '                            </div>'
            )
        }

    }

});