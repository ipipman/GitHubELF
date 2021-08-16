layui.use(['table', 'admin', 'ax', 'func'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;

    /**
     * 定时任务管理
     */
    var Timers = {
        tableId: "timersTable"
    };

    /**
     * 初始化表格的列
     */
    Timers.initColumn = function () {
        return [[
            {type: 'checkbox'},
            {field: 'timerId', hide: true, title: '定时器id'},
            {field: 'timerName', sort: true, title: '任务名称'},
            {field: 'actionClass', sort: true, title: '执行任务的class的类名（实现了TimerAction接口的类的全称）'},
            {field: 'cron', sort: true, title: '定时任务表达式'},
            {field: 'params', sort: true, title: '参数'},
            {field: 'jobStatus', sort: true, title: '状态：1-运行，2-停止'},
            {field: 'remark', sort: true, title: '备注信息'},
            {field: 'delFlag', sort: true, title: '是否删除：Y-被删除，N-未删除'},
            {field: 'createTime', sort: true, title: '创建时间'},
            {field: 'createUser', sort: true, title: '创建人'},
            {field: 'updateTime', sort: true, title: '修改时间'},
            {field: 'updateUser', sort: true, title: '修改人'},
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };

    /**
     * 点击查询按钮
     */
    Timers.search = function () {
        var queryData = {};
        queryData['condition'] = $("#condition").val();
        table.reload(Timers.tableId, {
            where: queryData, page: {curr: 1}
        });
    };

    /**
     * 弹出添加对话框
     */
    Timers.openAddDlg = function () {
        func.open({
            title: '添加定时任务',
            content: Feng.ctxPath + '/timers/add',
            tableId: Timers.tableId
        });
    };

    /**
    * 点击编辑
    *
    * @param data 点击按钮时候的行数据
    */
    Timers.openEditDlg = function (data) {
        func.open({
            title: '修改定时任务',
            content: Feng.ctxPath + '/timers/edit?timerId=' + data.timerId,
            tableId: Timers.tableId
        });
    };

    /**
     * 导出excel按钮
     */
    Timers.exportExcel = function () {
        var checkRows = table.checkStatus(Timers.tableId);
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
    Timers.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/timers/delete", function (data) {
                Feng.success("删除成功!");
                table.reload(Timers.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("timerId", data.timerId);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    // 渲染表格
    var tableResult = table.render({
        elem: '#' + Timers.tableId,
        url: Feng.ctxPath + '/timers/list',
        page: true,
        height: "full-158",
        cellMinWidth: 100,
        cols: Timers.initColumn()
    });

    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        Timers.search();
    });

    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        Timers.openAddDlg();
    });

    // 导出excel
    $('#btnExp').click(function () {
        Timers.exportExcel();
    });

    // 工具条点击事件
    table.on('tool(' + Timers.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            Timers.openEditDlg(data);
        } else if (layEvent === 'delete') {
            Timers.onDeleteItem(data);
        }
    });
});
