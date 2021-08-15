layui.use(['table', 'admin', 'ax', 'func', 'laydate'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;
    var laydate = layui.laydate;

    /**
     * 管理
     */
    var Orders = {
        tableId: "ordersTable"
    };

    laydate.render({
        elem: '#startTime'
        ,value: getRecentDay(-7)
        ,isInitValue: true
    });

    /**获取近N天*/
    function getRecentDay(day){
        var today = new Date();
        var targetday_milliseconds=today.getTime() + 1000*60*60*24*day;
        today.setTime(targetday_milliseconds);
        var tYear = today.getFullYear();
        var tMonth = today.getMonth();
        var tDate = today.getDate();
        tMonth = doHandleMonth(tMonth + 1);
        tDate = doHandleMonth(tDate);
        return tYear+"-"+tMonth+"-"+tDate;
    }
    function doHandleMonth(month){
        var m = month;
        if(month.toString().length == 1){
            m = "0" + month;
        }
        return m;
    }


    /**
     * 初始化表格的列
     */
    Orders.initColumn = function () {
        return [[
            {type: 'checkbox', fixed: 'left'},
            {field: 'id', sort: true, title: 'ID', width: 60, fixed: 'left'},
            {field: 'orderName', title: '订单名称', width: 140, fixed: 'left'},
            {field: 'orderNumber', title: '订单编号', width: 180},
            {field: 'orderStatusName', sort: true, title: '项目状态' ,width: 140},
            {field: 'orderExecStatusName', sort: true, title: '执行状态' ,width: 100, align: 'middle'},
            {field: 'taskImprRate', sort: true, title: '曝光完成度', width: 120,
                templet: function(d) {
                    var per = (d.imprSchedule== undefined ? 0 : d.imprSchedule);
                    if (per === -1){
                        return "<span>-</span>";
                    }
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },
            {field: 'taskClickRate', sort: true, title: '点击完成度', width: 120,
                templet: function(d) {
                    var per = (d.clickSchedule== undefined ? 0 : d.clickSchedule);
                    if (per === -1){
                        return "<span>-</span>";
                    }
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },
            {sort: true, title: '任务总数', width: 120, align: 'middle',
                templet: function(d) {
                    return '<span class="link-btn" data-href="/task?id='+ d.id +'&name='+encodeURIComponent(d.orderName)+'" data-title="任务管理">'+ (d.taskCount || 0) + '</span>'
                }
            },
            {
                field: 'imprCount', sort: true , width: 80,  title: '总曝光量', templet: function (d) {
                    var per = (d.imprCount == undefined ? 0 : d.imprCount);
                    if (per === -1) {
                        return "<span>-</span>";
                    }
                    return "<span>" + d.imprCount + "</span>";
                }
            },
            {
                field: 'imprReport', sort: true , width: 80,  title: '完成曝光量', templet: function (d) {
                    var per = (d.imprReport == undefined ? 0 : d.imprReport);
                    if (per === -1) {
                        return "<span>-</span>";
                    }
                    return "<span>" + d.imprReport + "</span>";
                }
            },
            {
                field: 'clickCount', sort: true, width: 80, title: '总点击量', templet: function (d) {
                    var per = (d.clickCount == undefined ? 0 : d.clickCount);
                    if (per === -1) {
                        return "<span>-</span>";
                    }
                    return "<span>" + d.clickCount + "</span>";
                }
            },
            {
                field: 'clickReport', sort: true , width: 80,  title: '完成点击量', templet: function (d) {
                    var per = (d.clickReport == undefined ? 0 : d.clickReport);
                    if (per === -1) {
                        return "<span>-</span>";
                    }
                    return "<span>" + d.clickReport + "</span>";
                }
            },
            {field: 'projectName', title: '项目'},
            // {field: 'orderStatusName', sort: true, title: '订单状态'},
            // {field: 'projectId', sort: true, title: '项目ID'},
            // {field: 'saleId', sort: true, title: '销售ID', hide: true},
            {field: 'createTime', sort: true, title: '创建时间'},
            {field: 'creatorName', title: '创建者'},
            {align: 'center', toolbar: '#tableBar', title: '操作', fixed: 'right', width: 180}
        ]];
    };

    function getQuery() {
        var queryData = {};
        var orderName = $("#orderName").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        queryData['orderName'] = orderName;
        queryData['projectName'] = $('#projectName').val();
        queryData['projectId'] =  $('#projectId').val();
        queryData['status'] =  $('#status').val();
        if (startTime) {
            queryData['startTime'] = startTime;
        }
        if (endTime) {
            queryData['endTime'] = endTime;
        }
        return queryData;
    }

    /**
     * 点击查询按钮
     */
    Orders.search = function () {
        renderTable();
    };

    function showDialog(form_type, data) {
        var options = {
            type: 2,
            title: '添加订单',
            area: ['700px', '400px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/orders/add',
            end: function() {
                Orders.search();
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    Orders.search();
                }
            }
        };
        if (form_type == 'edit' && data) {
            options.data = data;
            options.title = '修改订单';
        }
        var layIndex = admin.open(options);
    }

    /**
     * 导出excel按钮
     */
    Orders.exportExcel = function () {
        var checkRows = table.checkStatus(Orders.tableId);
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
    Orders.onDeleteItem = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/orders/delete", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("删除成功!");
                table.reload(Orders.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };
    /**
     * 点击删除
     *
     * @param data 点击按钮时候的行数据
     */
    Orders.onDeleteCheckedItem = function (data) {
        var rows = table.checkStatus(Orders.tableId).data;
        if (!rows){
            return Feng.error("请先选择要删除的内容!");
        }
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/orders/delete-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("删除成功!");
                table.reload(Orders.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            //var rows = table.checkStatus(Orders.tableId).data;
            ajax.set("rows", JSON.stringify(rows));
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };
    /**
     * 点击删除
     *
     * @param data 点击按钮时候的行数据
     */
    Orders.onStart = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/orders/start-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Orders.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };

    Orders.onStop = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/orders/stop-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Orders.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };
    initSearch();
    // 渲染表格
    renderTable()
    function renderTable() {
        var tableResult = table.render({
            elem: '#' + Orders.tableId,
            url: Feng.ctxPath + '/orders/list',
            page: true,
            cellMinWidth: 100,
            toolbar: '#toolbar',
            where: getQuery(),
            cols: Orders.initColumn()
        });
    }

    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        Orders.search();
    });

    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        showDialog()
    });

    // 导出excel
    $('body').on('click', '#btnExp', function () {
        Orders.exportExcel();
    })
    // delete
    $('body').on('click', '#btnDeleteChecked', function () {
        Orders.onDeleteCheckedItem();
    })
    // btnOpen
    $('body').on('click', '#btnStart', function () {
        var data = table.checkStatus(Orders.tableId).data
        Orders.onStart(data);
    })

    // btnOpen
    $('body').on('click', '#btnStop', function () {
        var data = table.checkStatus(Orders.tableId).data
        Orders.onStop(data);
    })
    // 工具条点击事件
    table.on('tool(' + Orders.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            showDialog('edit', data)
        } else if (layEvent === 'delete') {
            Orders.onDeleteItem([data]);
        } else if (layEvent === 'stop') {
            Orders.onStop([data]);
        }else if (layEvent === 'start') {
            Orders.onStart([data]);
        }
    });
    function initSearch() {
        var  projectId = getQueryString('id')
        var  projectName = getQueryString('name');
        console.log(projectName)
        projectId && $('#saleId').val(projectId);
        projectName && $('#projectName').val(decodeURIComponent(projectName));
        $('#startTime').val(getRecentDay(-7));
    }
});
