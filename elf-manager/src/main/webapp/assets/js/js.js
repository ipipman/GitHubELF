layui.use(['table', 'admin', 'ax', 'func'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;

    /**
     * 管理
     */
    var Js = {
        tableId: "jsTable"
    };

    /**
     * 初始化表格的列
     */
    Js.initColumn = function () {
        return [[
            {type: 'checkbox'},
            {field: 'id', hide: false, title: 'ID', sort: true, width: 60},
            {field: 'jsName', title: '个性化名称'},
            {field: 'jsText', title: '个性化代码'},
            {field: 'taskCount', sort: true, title: '任务总数', valign: 'middle'},
            // {field: 'isDel', sort: true, title: '是否删除'},
            {field: 'createTime', sort: true, title: '创建时间', width: 170},
            // {field: 'updateTime', sort: true, title: '修改时间'},
            // {field: 'deleteTime', sort: true, title: '删除时间'},
            {field: 'creatorName', title: '创建者'},
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };

    function getQuery() {
        var queryData = {};
        var condition = $("#condition").val();
        condition && (queryData['condition'] = condition);
        return queryData;
    }
    /**
     * 点击查询按钮
     */
    Js.search = function () {
        renderTable();
    };

    function showDialog(form_type, data) {
        var options = {
            type: 2,
            title: '添加个性化',
            area: ['700px', '400px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/js/add',
            end: function () {
                Js.search();
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    Js.search();
                }
            }
        };
        if (form_type == 'edit' && data) {
            options.data = data;
            options.title = '修改个性化';
        }
        var layIndex = admin.open(options);
    }

    /**
     * 导出excel按钮
     */
    Js.exportExcel = function () {
        var checkRows = table.checkStatus(Js.tableId);
        if (checkRows.data.length === 0) {
            Feng.error("请选择要导出的数据");
        } else {
            table.exportFile(tableResult.config.id, checkRows.data, 'xls');
        }
    };

    /**
     * 点击删除
     *
     * @param data 点击按钮时候的行数据
     */
    Js.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/js/delete", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                // table.reload(Js.tableId);
                Js.search();
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    // 渲染表格
    renderTable()
    function renderTable() {
        var tableResult = table.render({
            elem: '#' + Js.tableId,
            url: Feng.ctxPath + '/js/list',
            page: true,
            where: getQuery(),
            cellMinWidth: 100,
            toolbar: true,
            cols: Js.initColumn()
        });
    }
    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        Js.search();
    });

    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        showDialog();
    });

    // 导出excel
    $('body').on('click', '#btnExp', function () {
        Js.exportExcel();
    })

    // 工具条点击事件
    table.on('tool(' + Js.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;
        if (layEvent === 'edit') {
            showDialog('edit', data);
        } else if (layEvent === 'delete') {
            Js.onDeleteItem(data);
        }
    });
});
