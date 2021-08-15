layui.use(['table', 'admin', 'ax', 'func'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;

    /**
     * 管理
     */
    var Crowd = {
        tableId: "crowdTable"
    };

    /**
     * 初始化表格的列
     */
    Crowd.initColumn = function () {
        return [[
            {type: 'checkbox'},
            {field: 'id', hide: true, title: 'ID'},
            {field: 'crowdName', sort: true, title: '人群包名称'},
            {field: 'crowdRemake', sort: true, title: '人群包说明'},
            // {field: 'isDel', sort: true, title: '是否删除'},
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };

    /**
     * 点击查询按钮
     */
    Crowd.search = function () {
        var queryData = {};
        queryData['condition'] = $("#condition").val();
        table.reload(Crowd.tableId, {
            where: queryData, page: {curr: 1}
        });
    };

    /**
     * 弹出添加对话框
     */
    Crowd.openAddDlg = function () {
        func.open({
            title: '添加',
            content: Feng.ctxPath + '/crowd/add',
            tableId: Crowd.tableId
        });
    };

    /**
    * 点击编辑
    *
    * @param data 点击按钮时候的行数据
    */
    Crowd.openEditDlg = function (data) {
        func.open({
            title: '修改',
            content: Feng.ctxPath + '/crowd/edit?id=' + data.id,
            tableId: Crowd.tableId
        });
    };

    /**
     * 导出excel按钮
     */
    Crowd.exportExcel = function () {
        var checkRows = table.checkStatus(Crowd.tableId);
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
    Crowd.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/crowd/delete", function (data) {
                Feng.success("删除成功!");
                table.reload(Crowd.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    // 渲染表格
    var tableResult = table.render({
        elem: '#' + Crowd.tableId,
        url: Feng.ctxPath + '/crowd/list',
        page: true,
        height: "full-158",
        cellMinWidth: 100,
        cols: Crowd.initColumn()
    });

    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        Crowd.search();
    });

    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        Crowd.openAddDlg();
    });

    // 导出excel
    $('#btnExp').click(function () {
        Crowd.exportExcel();
    });

    // 工具条点击事件
    table.on('tool(' + Crowd.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            Crowd.openEditDlg(data);
        } else if (layEvent === 'delete') {
            Crowd.onDeleteItem(data);
        }
    });

    // 渲染laydate
    laydate.render({
        elem: '#edtDateFormBas',
        range: true
    });
});

layui.use(['layer', 'form', 'laydate'], function () {
    var $ = layui.jquery;
    var layer = layui.layer;
    var form = layui.form;
    var laydate = layui.laydate;
    var config = layui.config;

    form.render('select');
    form.render('radio');

    // 渲染laydate
    laydate.render({
        elem: '#edtDateFormBas',
        range: true
    });


});
