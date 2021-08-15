layui.use(['table', 'admin', 'ax', 'func', 'element', 'laydate'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var router = layui.router();
    var func = layui.func;
    var laydate = layui.laydate;

    /**
     * 管理
     */
    var Project = {
        tableId: "projectTable"
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
    Project.initColumn = function () {
        return [[
            {type: 'checkbox', fixed: 'left'},
            {field: 'id', sort: true, title: 'ID', fixed: 'left', width: 60},
            {field: 'projectName', sort: true, title: '项目名称', fixed: 'left', width: 160},

            {field: 'projectStatusName', sort: true, title: '项目状态' ,width: 140},
            {field: 'projectExecStatusName', sort: true, title: '执行状态' ,width: 100, align: 'middle'},
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
            {sort: true, title: '订单总数', width: 80, align: 'middle',
                templet: function(d) {
                    return '<span class="link-btn" data-href="/orders?id='+ d.projectId +'&name='+encodeURIComponent(d.projectName)+'" data-title="订单管理">'+ (d.orderCount || 0) + '</span>'
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
            {field: 'saleGroupCompany', sort: true, title: '公司'},
            {field: 'saleGroup', sort: true, title: '销售分组', align: 'middle'},
            {field: 'saleName', sort: true, title: '销售', width: 140, align: 'middle'},
            {field: 'createTime', sort: true, title: '创建时间', width: 170},
            {field: 'creatorName', sort: true, title: '创建者'},
            // {field: 'isDel', sort: true, title: '是否删除'},
            {align: 'center', toolbar: '#tableBar', title: '操作', width: 180, fixed: 'right'}
        ]];
    };
    function getQuery() {
        var queryData = {};
        var condition = $("#condition").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        queryData['projectName'] = $('#projectName').val();
        queryData['saleName'] = $('#saleName').val();
        queryData['saleId'] =  $('#saleId').val();
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
    Project.search = function () {
        renderTable();
    };

    /**
     * 导出excel按钮
     */
    Project.exportExcel = function () {
        var checkRows = table.checkStatus(Project.tableId);
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
    Project.onDeleteCheckedItem = function (data) {
        var rows = table.checkStatus(Project.tableId).data;
        if (!rows){
            return Feng.error("请先选择要删除的内容!");
        }
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/project/delete-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                table.reload(Project.tableId);
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
    Project.onDeleteItem = function (data) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/project/delete", function (data) {
                if (data.code === 500) {
                    return Feng.error("删除失败!" + data.message);
                }
                Feng.success("删除成功!");
                table.reload(Project.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
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
    Project.onStart = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/project/start-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Project.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };

    Project.onStop = function (rowData) {
        var operation = function () {
            var ajax = new $ax(Feng.ctxPath + "/project/stop-checkrows", function (data) {
                if (data.code === 500) {
                    return Feng.error("操作失败!" + data.message);
                }
                Feng.success("操作成功!");
                table.reload(Project.tableId);
            }, function (data) {
                Feng.error("操作失败!" + data.responseJSON.message + "!");
            });
            ajax.set("rows", JSON.stringify(rowData));
            ajax.start();
        };
        Feng.confirm("确认操作？", operation);
    };


    function showDialog(form_type, data) {
        var options = {
            type: 2,
            title: '添加项目',
            area: ['700px', '400px'],
            shade: 0,
            maxmin: true,
            resize: true,
            content: '/project/add',
            end: function() {
                Project.search();
                if (admin.getLayerData(layIndex, 'formOk')) {  // 判断表单操作成功标识
                    Project.search();
                }
            }
        };
        if (form_type == 'edit' && data) {
            options.data = data;
            options.title = '修改项目';
        }
        var layIndex = admin.open(options);
    }
    initSearch();
    // 渲染表格
    renderTable()
    function renderTable() {
        var tableResult = table.render({
            elem: '#' + Project.tableId,
            url: Feng.ctxPath + '/project/list',
            page: true,
            cellMinWidth: 100,
            toolbar: '#toolbar',
            where: getQuery(),
            cols: Project.initColumn()
        });
    }
    // 搜索按钮点击事件
    $('body').on('click', '#btnSearch', function () {
        Project.search();
    })

    // 添加按钮点击事件
    $('body').on('click', '#btnAdd', function () {
        showDialog();
    })
    // delete
    $('body').on('click', '#btnDeleteChecked', function () {
        Project.onDeleteCheckedItem();
    })
    // btnOpen
    $('body').on('click', '#btnStart', function () {
        var data = table.checkStatus(Project.tableId).data
        Project.onStart(data);
    })

    // btnOpen
    $('body').on('click', '#btnStop', function () {
        var data = table.checkStatus(Project.tableId).data
        Project.onStop(data);
    })
    // 导出excel
    $('body').on('click', '#btnExp', function () {
        Project.exportExcel();
    })

    // 工具条点击事件
    table.on('tool(' + Project.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            showDialog('edit', data)
        } else if (layEvent === 'delete') {
            Project.onDeleteItem(data);
        }else if (layEvent === 'stop') {
            Project.onStop([data]);
        }else if (layEvent === 'start') {
            Project.onStart([data]);
        }
    });
    function initSearch() {
        var  saleId = getQueryString('id')
        var  saleName = getQueryString('name')
        saleId && $('#saleId').val(saleId);
        saleName && $('#saleName').val(saleName);
        $('#startTime').val(getRecentDay(-7));
    }

});
