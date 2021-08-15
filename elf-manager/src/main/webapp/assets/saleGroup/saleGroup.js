layui.use(['table', 'admin', 'ax', 'func', 'index'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;
    var index = layui.index;

    console.log(index);

    /**
     * 管理
     */
    var SaleGroup = {
        tableId: "saleGroupTable"
    };

    /**
     * 初始化表格的列
     */
    SaleGroup.initColumn = function () {
        return [[
            {type: 'checkbox'},
            {field: 'saleGroupName', sort: true, title: '销售组'},
            {field: 'saleGroupCompany', sort: true, title: '公司'},
            {
                field: 'saleCount', sort: true, title: '销售总数', width: 120, valign: 'middle',align: 'middle',
                templet: function (d) {
                    return '<span class="link-btn" data-href="/sale?id=' + d.id + '&name=' + encodeURIComponent(d.saleGroupName) + '" data-title="销售管理">' + (d.saleCount || 0) + '</span>'
                }
            },
            {field: 'creatorName', sort: false, title: '创建者', valign: 'middle'},
            {field: 'createTime', sort: true, title: '创建时间', width: 180, valign: 'middle'},
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };


    SaleGroup.gotoSalePage = function (d) {
        // layui.router('#/sale?saleGroupId=' + d.id).search;
    };

    function getQuery() {
        var queryData = {};
        var saleGroupName = $("#saleGroupName").val();
        var saleGroupCompanyName = $("#saleGroupCompanyName").val();
        saleGroupName && (queryData['saleGroupName'] = saleGroupName);
        saleGroupCompanyName && (queryData['saleGroupCompanyName'] = saleGroupCompanyName);
        return queryData;
    }

    /**
     * 点击查询按钮
     */
    SaleGroup.search = function () {
        renderTable();
    };

    /**
     * 弹出添加对话框
     */
    SaleGroup.openAddDlg = function () {
        func.open({
            title: '添加',
            content: Feng.ctxPath + '/saleGroup/add',
            tableId: SaleGroup.tableId
        });
    };

    /**
     * 点击编辑
     *
     * @param data 点击按钮时候的行数据
     */
    SaleGroup.openEditDlg = function (data) {
        func.open({
            title: '修改',
            content: Feng.ctxPath + '/saleGroup/edit?id=' + data.id,
            tableId: SaleGroup.tableId
        });
    };

    /**
     * 导出excel按钮
     */
    SaleGroup.exportExcel = function () {
        var checkRows = table.checkStatus(SaleGroup.tableId);
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
    SaleGroup.onDeleteCheckedItem = function (data) {
        var rows = table.checkStatus(SaleGroup.tableId).data;
        if (!rows){
            return Feng.error("请先选择要删除的内容!");
        }
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/saleGroup/delete-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                SaleGroup.search();
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set('rows', JSON.stringify(rows));
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
        return false;
    };

    /**
     * 点击删除
     *
     * @param data 点击按钮时候的行数据
     */
    SaleGroup.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/saleGroup/delete", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                Sale.search();
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
        return false;
    };

    // 渲染表格
    renderTable()
    function renderTable() {
        var tableResult = table.render({
            elem: '#' + SaleGroup.tableId,
            url: Feng.ctxPath + '/saleGroup/list',
            page: true,
            cellMinWidth: 100,
            toolbar: '#toolbar',
            where: getQuery(),
            cols: SaleGroup.initColumn()
        });
    }

    // 搜索按钮点击事件
    $('body').on('click', '#btnSearch', function () {
        SaleGroup.search();
    })

    // 添加按钮点击事件
    $('body').on('click', '#btnAdd', function () {
        SaleGroup.openAddDlg();
    })

    // 导出excel
    $('body').on('click', '#btnExp', function () {
        SaleGroup.exportExcel();
    })

    // delete
    $('body').on('click', '#btnDeleteChecked', function () {
        SaleGroup.onDeleteCheckedItem();
    })

    // 工具条点击事件
    table.on('tool(' + SaleGroup.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            SaleGroup.openEditDlg(data);
        } else if (layEvent === 'delete') {
            SaleGroup.onDeleteItem(data);
        }
    });
});
