layui.use(['table', 'admin', 'ax', 'func'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;

    /**
     * 管理
     */
    var User = {
        tableId: "userTable"
    };

    /**
     * 初始化表格的列
     */
    User.initColumn = function () {
        return [[
            {type: 'checkbox'},
            {field: 'userId', hide: true, title: '用户ID'},
            {field: 'id', sort: true, title: '用户唯一标识'},
            {field: 'email', sort: true, title: '用户邮箱'},
            {field: 'location', sort: true, title: '用户地理位置'},
            {field: 'areaId', sort: true, title: '用户ID'},
            {field: 'company', sort: true, title: '公司'},
            {field: 'updatedAt', sort: true, title: '用户最新活跃时间'},
            {field: 'avatarUrl', sort: true, title: '用户头像'},
            {field: 'bio', sort: true, title: '个人简介'},
            {field: 'login', sort: true, title: '登录ID'},
            {field: 'createdAt', sort: true, title: '用户创建时间'},
            {field: 'gitAge', sort: true, title: 'github年限'},
            {field: 'followers', sort: true, title: '跟随者'},
            {field: 'following', sort: true, title: '关注过多个项目'},
            {field: 'websiteUrl', sort: true, title: ' 个人博客'},
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };

    /**
     * 点击查询按钮
     */
    User.search = function () {
        var queryData = {};
        queryData['condition'] = $("#condition").val();
        table.reload(User.tableId, {
            where: queryData, page: {curr: 1}
        });
    };

    /**
     * 弹出添加对话框
     */
    User.openAddDlg = function () {
        func.open({
            title: '添加',
            content: Feng.ctxPath + '/user/add',
            tableId: User.tableId
        });
    };

    /**
    * 点击编辑
    *
    * @param data 点击按钮时候的行数据
    */
    User.openEditDlg = function (data) {
        func.open({
            title: '修改',
            content: Feng.ctxPath + '/user/edit?userId=' + data.userId,
            tableId: User.tableId
        });
    };

    /**
     * 导出excel按钮
     */
    User.exportExcel = function () {
        var checkRows = table.checkStatus(User.tableId);
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
    User.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/user/delete", function (data) {
                Feng.success("删除成功!");
                table.reload(User.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("userId", data.userId);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    // 渲染表格
    var tableResult = table.render({
        elem: '#' + User.tableId,
        url: Feng.ctxPath + '/user/list',
        page: true,
        height: "full-158",
        cellMinWidth: 100,
        cols: User.initColumn()
    });

    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        User.search();
    });

    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        User.openAddDlg();
    });

    // 导出excel
    $('#btnExp').click(function () {
        User.exportExcel();
    });

    // 工具条点击事件
    table.on('tool(' + User.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            User.openEditDlg(data);
        } else if (layEvent === 'delete') {
            User.onDeleteItem(data);
        }
    });
});
