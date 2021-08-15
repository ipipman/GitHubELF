layui.use(['table', 'admin', 'ax', 'laydate'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var laydate = layui.laydate;
    /**
     * 管理
     */
    var Task = {
        tableId: "taskTable"
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
    Task.initColumn = function () {
        return [[
            // {field: 'selectItem', radio: true},
            {type: 'checkbox', fixed: 'left'},
            {field: 'id',  fixed: 'left', visible: true, align: 'left', title: '#', width: 60},
            {field: 'taskName', sort: true, title: '任务名称', align: 'left', valign: 'middle', fixed: 'left', width: 160},
            {field: 'taskExecStatusName', sort: true, title: '任务执行状态',  align: 'left',width: 140,},
            {field: 'taskStatusName', sort: true, title: '任务状态',  align: 'left',width: 140,},
            {field: 'taskTodayHandlerName', sort: true, title: '今日分发状态', align: 'middle',width: 140,},
            {field: 'taskTodayImprReport', sort: true, title: '今日曝光数量',  align: 'left', width: 140,
                templet: function(d) {
                    if (d.taskTodayImprReport == -1) return '-';
                    return d.taskTodayImprReport;
                }
            },
            {field: 'taskTodayImprRate', sort: true, title: '今日曝光进度', width: 140,
                templet: function(d) {
                    if (d.taskTodayImprRate == -1) return '-';
                    var per = (d.taskTodayImprRate== undefined ? 0 : d.taskTodayImprRate);
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },
            // {field: 'taskImprUrls', sort: true, title: '曝光地址', hide: true, align: 'left', valign: 'middle'},
            {field: 'taskTodayClickReport', sort: true, title: '今日点击数量', hide: false, align: 'left', width: 140,
                templet: function(d) {
                    if (d.taskTodayClickReport == -1) return '-';
                    return d.taskTodayClickReport;
                }
            },
            {field: 'taskTodayClickRate', sort: true, title: '今日点击进度', width: 120,
                templet: function(d) {
                    if (d.taskTodayClickRate == -1) return '-';
                    var per = (d.taskTodayClickRate== undefined ? 0 : d.taskTodayClickRate);
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },

            {field: 'taskTotalsClickReport', sort: true, title: '总点击数量', hide: false, align: 'left', width: 140,
                templet: function(d) {
                    if (d.taskTotalsClickReport == -1) return '-';
                    return d.taskTotalsClickReport;
                }
            },
            {field: 'taskTotalsClickRate', sort: true, title: '总点击进度', width: 120,
                templet: function(d) {
                    if (d.taskTotalsClickRate == -1) return '-';
                    var per = (d.taskTotalsClickRate== undefined ? 0 : d.taskTotalsClickRate);
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },

            {field: 'taskTotalsImprReport', sort: true, title: '总曝光数量', hide: false, align: 'left', width: 140,
                templet: function(d) {
                    if (d.taskTotalsImprReport == -1) return '-';
                    return d.taskTotalsImprReport;
                }
            },
            {field: 'taskTotalsImprRate', sort: true, title: '总曝光进度', width: 120,
                templet: function(d) {
                    if (d.taskTotalsImprRate == -1) return '-';
                    var per = (d.taskTotalsImprRate== undefined ? 0 : d.taskTotalsImprRate);
                    return '<div class="layui-progress layui-progress-big">' +
                        '<div class="layui-progress-bar" style="width: '+per+'px;text-align: right"></div><span class="per-txt">' + per + '%</span>'+
                        '</div>'
                }
            },
            {field: 'taskDateCount', sort: true, title: '总天数', hide: false, align: 'middle', valign: 'middle'},
            {field: 'areaName', sort: true, title: '区域', hide: false, align: 'left'},
            {field: 'taskOs', sort: true, title: '终端', hide: false, align: 'middle', valign: 'middle', templet: function(d) {
                    if (d.taskOs === 1) return 'PC';
                    if (d.taskOs === 2) return 'WAP';
                    return 'APP';
            }},
            {field: 'taskImprUrlsList', sort: true, title: '曝光地址', hide: false, align: 'left', templet: function(d) {
                    if (!d.taskImprUrlsList) return '-';
                    var res = "";
                    for (let i = 0; i < d.taskImprUrlsList.length; i++) {
                        res += "<a target='_blank' href='"+d.taskImprUrlsList[i]+"'>["+(i+1)+"]</a>&nbsp;&nbsp;";
                    }
                    return res;
            }},
            {field: 'taskClickUrl', sort: true, title: '点击地址', hide: false, align: 'left', templet: function(d) {
                    if (!d.taskClickUrl) return '-';
                    return "<a target='_blank' href='"+d.taskClickUrl+"'>[1]</a>&nbsp;&nbsp;";
                }},
            {field: 'taskReferer', sort: true, title: '页面来源', hide: false, align: 'left', templet: function(d) {
                    if (!d.taskReferer) return '-';
                    return "<a target='_blank' href='"+d.taskReferer+"'>[1]</a>&nbsp;&nbsp;";
                }},
            {field: 'projectName', sort: true, title: '项目', hide: false, align: 'left', valign: 'middle'},
            {field: 'ordersName', sort: true, title: '订单', hide: false, align: 'left', valign: 'middle'},
            {field: 'orderNumber', sort: true, title: '订单编号', hide: false, align: 'left', valign: 'middle'},
            {field: 'isFlash', sort: true, title: 'Flash广告', hide: false, align: 'middle', templet: function(d) {
                    if (!d.isFlash) return '否';
                    return '是';
                }},
            {field: 'jsName', sort: true, title: '个性化配置', hide: false, align: 'left'},
            {field: 'crowdName', sort: true, title: '人群包配置', hide: false, align: 'left'},
            {field: 'taskTwojump', sort: true, title: '二跳率', hide: false, align: 'middle', templet: function(d) {
                    if (!d.taskTwojump) return '-';
                    return d.taskTwojump+'%';

                }},
            {field: 'taskOutjump', sort: true, title: '跳出率', hide: false, align: 'middle', templet: function(d) {
                    if (!d.taskOutjump) return '-';
                    return d.taskOutjump+'%';

                }},
            {field: 'createTime', sort: true, title: '创建时间' ,hide: false, align: 'left', width: 170},
            {field: 'creatorName', sort: true, title: '创建者' ,hide: false, align: 'left'},
            {align: 'center', toolbar: '#tableBar', title: '操作', width: 180, fixed: 'right'}
        ]];
    };

    function getQuery() {
        var queryData = {};
        var taskName = $("#taskName").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var orderId = $("#orderId").val();
        taskName && (queryData['taskName'] = taskName);
        orderId && (queryData['orderId'] = orderId);
        startTime && (queryData['startTime'] = startTime);
        endTime && (queryData['endTime'] = endTime);
        return queryData;
    }

    /**
     * 点击查询按钮
     */
    Task.search = function () {
        renderTable()
        return;
    };

    function showDialog(form_type, data) {
        var options = {
            type: 2,
            title: '添加项目',
            area: ['700px', '400px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/task/add',
            end: function() {
                renderTable()
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    renderTable()
                }
            }
        };
        if (form_type == 'edit' && data) {
            options.data = data;
            options.title = '修改项目';

        }
        var layIndex = admin.open(options);
    }

    /**
     * 批量导入
     * @param data
     */
    function showImport() {
        var options = {
            type: 2,
            title: '批量添加',
            area: ['700px', '450px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/task/imp',
            end: function() {
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    //renderTable()
                }
            }
        };
        var layIndex = admin.open(options);
    }

    /**
     * 导出excel按钮
     */
    Task.exportExcel = function () {
        var checkRows = table.checkStatus(Task.tableId);
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
    Task.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/task/delete", function (data) {
                Feng.success("删除成功!");
                table.reload(Task.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    /**
     * 点击删除
     *
     * @param data 点击按钮时候的行数据
     */
    Task.onDeleteCheckedItem = function (data) {
        var rows = table.checkStatus(Task.tableId).data;
        if (!rows){
            return Feng.error("请先选择要删除的内容!");
        }
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/task/delete-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("删除成功!");
                table.reload(Task.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
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
    Task.onStart = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/task/start-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Task.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };

    Task.onStop = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/task/stop-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Task.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };
    initSearch()
    // 渲染表格
    renderTable()
    function renderTable() {
        table.render({
            elem: '#' + Task.tableId,
            url: Feng.ctxPath + '/task/list',
            page: true,
            cellMinWidth: 100,
            toolbar: '#toolbar',
            where: getQuery(),
            cols: Task.initColumn()
        });
    }

    // 搜索按钮点击事件
    $('body').on('click', '#btnSearch', function () {
        Task.search();
    })

    // 添加按钮点击事件
    $('body').on('click', '#btnAdd', function () {
        showDialog();
    })

    // 添加按钮点击事件
    $('body').on('click', '#btnImp', function () {
        showImport();
    })
    // delete
    $('body').on('click', '#btnDeleteChecked', function () {
        Task.onDeleteCheckedItem();
    })
    // btnOpen
    $('body').on('click', '#btnStart', function () {
        var data = table.checkStatus(Task.tableId).data
        Task.onStart(data);
    })

    // btnStop
    $('body').on('click', '#btnStop', function () {
        var data = table.checkStatus(Task.tableId).data
        Task.onStop(data);
    })
    // 导出excel
    $('body').on('click', '#btnExp', function () {
        Task.exportExcel();
    })

    // 工具条点击事件
    table.on('tool(' + Task.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            showDialog('edit', data)
        } else if (layEvent === 'delete') {
            Task.onDeleteItem(data);
        } else if (layEvent === 'stop') {
            Task.onStop([data]);
        } else if (layEvent === 'start') {
            Task.onStart([data]);
        }
    });
    function initSearch() {
        var  orderId = getQueryString('id');
        // var  saleName = getQueryString('name')
        orderId && $('#orderId').val(orderId);
        $('#startTime').val(getRecentDay(-7));
        // saleName && $('#saleName').val(saleName);
    }
});
