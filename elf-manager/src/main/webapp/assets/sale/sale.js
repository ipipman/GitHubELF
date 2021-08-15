layui.use(['table', 'admin', 'ax', 'func', 'cascader', 'form', 'laydate','layer'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;
    var cascader = layui.cascader;
    var form = layui.form;
    var laydate = layui.laydate;
    var layer = layui.layer;

    /**
     * 管理
     */
    var Sale = {
        tableId: "saleTable"
    };


    /**
     * 初始化表格的列
     */
    Sale.initColumn = function () {
        return [[
            {type: 'checkbox', fixed: 'left'},
            {field: 'id', sort: true, title: 'ID', width: 60, fixed: 'left'},
            {field: 'saleName', sort: false, title: '销售', fixed: 'left',width: 140},
            {field: 'salePhone', sort: false, title: '电话', width:120, valign: 'middle'},
            {field: 'saleEmail', sort: false, title: '邮箱', width: 140, valign: 'middle'},

            {sort: false, title: '项目总数', width: 90,align: 'middle',valign: 'middle',
                templet: function(d) {
                    return '<span class="link-btn" data-href="/project?id='+ d.id +'&name='+d.saleName+'" data-title="项目管理">'+ (d.projectCount || 0) + '</span>'
                }
            },
            // {field: 'saleGroupId', sort: true, title: '销售分组', hide: false, align: 'left', valign: 'middle'},
            {field: 'saleGroupCompany', sort: false, title: '公司', hide: false, align: 'middle', valign: 'middle'},
            {field: 'saleGroupName', sort: false, title: '销售分组', hide: false, align: 'middle', width: 140, valign: 'middle'},
            {field: 'createTime', sort: true, title: '创建时间', width: 170, align: 'left', valign: 'middle'},
            {field: 'creatorName', sort: false, title: '创建者', valign: 'middle'},
            {align: 'center', toolbar: '#tableBar', title: '操作', width: 120,fixed: 'right'}
        ]];
    };

    function getQuery() {
        var queryData = {};
        queryData['saleName'] = $("#saleName").val();
        queryData['saleGroupName'] = $("#saleGroupName").val();
        queryData['saleGroupId'] = $("#saleGroupId").val();
        return queryData;
    }

    /**
     * 点击查询按钮
     */
    Sale.search = function () {
        renderTable();
    };

    function showDialog(form_type, data) {
        var options = {
            type: 2,
            title: '添加销售',
            area: ['700px', '450px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/sale/add',
            end: function() {
                Sale.search();
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    alert('刷新表格')
                }
            }
        };
        if (form_type == 'edit' && data) {
            options.data = data;
            options.title = '修改销售';
        }
        var layIndex = admin.open(options);
    }

    /**
     * 导出excel按钮
     */
    Sale.exportExcel = function () {
        var checkRows = table.checkStatus(Sale.tableId);
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
    Sale.onDeleteCheckedItem = function (data) {
        var rows = table.checkStatus(Sale.tableId).data;
        if (!rows){
            return Feng.error("请先选择要删除的内容!");
        }
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/sale/delete-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                Sale.search();
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
    Sale.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/sale/delete", function (data) {
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

    initSearch();
    // 渲染表格
    renderTable()
    function renderTable() {
        var tableResult = table.render({
            elem: '#' + Sale.tableId,
            url: Feng.ctxPath + '/sale/list',
            page: true,
            cellMinWidth: 100,
            where: getQuery(),
            toolbar: '#toolbar',
            cols: Sale.initColumn()
        });
    }

    // 搜索按钮点击事件
    $('body').on('click', '#btnSearch', function () {
        Sale.search();
    })
    // add page
    $('body').on('click', '#btnAddSale', function () {
        showDialog('add');
    })
    // delete
    $('body').on('click', '#btnDeleteChecked', function () {
        Sale.onDeleteCheckedItem();
    })

    // 导出excel
    $('body').on('click', '#btnExp', function () {
        Sale.exportExcel();
    })

    // 工具条点击事件
    table.on('tool(' + Sale.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            showDialog('edit', data)
        } else if (layEvent === 'delete') {
            Sale.onDeleteItem(data);
        }
    });

    function initSearch() {
        var  saleGroupId = getQueryString('id');
        var  saleGroupName = getQueryString('name');
        saleGroupId && $('#saleGroupId').val(saleGroupId);
        saleGroupName && $('#saleGroupName').val(saleGroupName);
    }
});
