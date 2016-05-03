function tabOnContextMenu(e, title) {
    e.preventDefault();
    $('#tabsMenu').menu('show', {
        left : e.pageX,
        top : e.pageY
    }).data("tabTitle", title);
}

//实例化menu的onClick事件
function tabsMenuOnClickHandler(item) {
    handleTabsMenuClick(this, item.name);
}

//几个关闭事件的实现
function handleTabsMenuClick(menu, type) {
    var curTabTitle = $(menu).data("tabTitle");
    var tabs = $("#tabs");

    if (type === "reload") {
        $('#tabs').tabs('getSelected').find("iframe")[0].contentWindow.location.reload();
        return;
    } else if (type === "close") {
        tabs.tabs("close", curTabTitle);
        return;
    } else {
        var allTabs = tabs.tabs("tabs");
        var closeTabsTitle = [];

        $.each(allTabs, function () {
            var opt = $(this).panel("options");
            if (opt.closable && opt.title != curTabTitle && type === "other") {
                closeTabsTitle.push(opt.title);
            } else if (opt.closable && type === "all") {
                closeTabsTitle.push(opt.title);
            }
        });

        for (var i = 0; i < closeTabsTitle.length; i++) {
            tabs.tabs("close", closeTabsTitle[i]);
        }
    }
}


function showTaskWindow(date) {
    loadForm($("#taskTable"), {});
    showModalDialog("taskWindow");
    $("#p_createTime").datebox("setValue", moment(new Date()).format("YYYY-MM-DD"));
    $("#p_start").datetimebox("setValue", moment(date).format("YYYY-MM-DD hh:mm"));
    $("#p_end").datetimebox("setValue", moment(date).format("YYYY-MM-DD hh:mm"));
    $("#p_importance").combobox("setValue", 1);
    $("#p_instancy").combobox("setValue", 1);
    return false;
}

function HelloWorld(event){
    if(event.which == 3){
        console.log("event right click .....")
        console.log(event.pageX)
        console.log(event.pageY)
        //event.preventDefault();
        $('#tabsMenu').menu('show', {
            left : event.pageX,
            top : event.pageY
        });//.data("tabTitle", title);
    }
}

function setTaskWindowButtonStatus(task) {
    console.log(task)
    var buttonStatus = getButtonStatus(task);
    console.log(buttonStatus)
    for (var i = 0; i < buttons.length; i++) {
        //console.log(buttons[i] + " - " + getButtonStatusStatement(buttonStatus[i]));
        $("#" + buttons[i]).linkbutton(getButtonStatusStatement(buttonStatus[i]));
    }
}

function renderCalendar() {
    $('#calendar').fullCalendar({
        theme: true,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultDate: moment(new Date()).format("YYYY-MM-DD"),
        lang: 'zh-cn',
        timezone: "local",
        buttonIcons: false, // show the prev/next text
        weekNumbers: true,
        weekends:true,
        editable: false, //日程能否拖动
        allDaySlot : true,
        ignoreTimezone: true,
        eventLimit: true, // allow "more" link when too many events

        dayClick: function(date, allDay, jsEvent, view) { // //日期点击后弹出的jq ui的框，添加日程记录
            var currDate = new Date();
            if(currDate > date) {
                $.messager.confirm('确认','是否补录过去的日程信息?',function(r){
                    if (r){
                        showTaskWindow(date);
                        $('#p_status').combobox("setValue", "4");
                    }
                });
            } else {
                showTaskWindow(date);
                $('#p_status').combobox("setValue", "1");

            }
        },

        eventClick: function(event, jsEvent) {  // 定义了点击日历项的动作，这里将会调用jQueryUi的dialog显示日历项的内容
            if(jsEvent.which == 3){
                console.log("event right click .....")
                console.log(event.pageX)
                console.log(event.pageY)
                //event.preventDefault();
                $('#tabsMenu').menu('show', {
                    left : event.pageX,
                    top : event.pageY
                });//.data("tabTitle", title);
            } else {
                showModalDialog("taskWindow");
                loadForm($("#taskWindow"), event);
                setTaskWindowButtonStatus(event);
            }
            return false;
        },

        eventRender: function(event, element) {
            //var fstart  = timeOnlyFormatter(event.start, false); //(event.start, "HH:mm");
            var fstart  = moment(event.start).format("HH:mm"); //(event.start, "HH:mm");
            //var fend  = timeOnlyFormatter(event.end, false); //(event.end, "HH:mm");
            var fend  = moment(event.end).format("HH:mm"); //(event.end, "HH:mm");
            // Bug in IE8
            //element.html('<a href=#>' + fstart + "-" +  fend + '<div style=color:#E5E5E5>' +  event.title + "</div></a>");
            //element.on('mousedown',{elemento:"xxxx",evento:"yyyy",vista:"zzz"} , HelloWorld);
        },

        eventAfterRender : function(event, element, view) {//数据绑定上去后添加相应信息在页面上
            //var fstart  = timeOnlyFormatter(event.start, false); //(event.start, "HH:mm");
            //var fend  = timeOnlyFormatter(event.end, false); //(event.end, "HH:mm");
            var fstart  = moment(event.start).format("HH:mm"); //(event.start, "HH:mm");
            var fend  = moment(event.end).format("HH:mm"); //(event.end, "HH:mm");

            var confbg='';
            var color;
            if(event.importance==1){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "green";
            }else if(event.importance==2){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "blue";
            }else if(event.importance==3){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "yellow";
            }else if(event.importance==4){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "orange";
            }else if(event.importance==5){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "pink";
            }else if(event.importance==6){
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "amber";
            }else{
                confbg = confbg + '<span class="fc-event-bg"></span>';
                color = "red";
            }

            var titlebg = '<span class="fc-event-conf" >&nbsp;' + event.title + '</span>';
            if(event.repweeks>0){
                titlebg = titlebg + '<span class="fc-event-conf" style="background:#fff;top:0;right:15;color:#3974BC;font-weight:bold">R</span>';
            }
            if(view.name=="month"){
                var evtcontent = '<div class="fc-event-vert"><a>';
                evtcontent = evtcontent + confbg;
                evtcontent += "<span style='color:green;background-color:yellow;margin-right:5px;padding-left:2px;padding-right:2px;'>"
                if(event.ownerId == userInfo.id) {
                    evtcontent = evtcontent + "执/"
                }
                if(event.superintendentId == userInfo.id) {
                    evtcontent = evtcontent + "责/"
                }
                if(event.verifierId == userInfo.id) {
                    evtcontent = evtcontent + "核/"
                }
                if(event.approverId == userInfo.id) {
                    evtcontent = evtcontent + "审/"
                }
                if(event.coupler.contains(userInfo.id)) {
                    evtcontent = evtcontent + "协/"
                }
                evtcontent = evtcontent.substr(0,evtcontent.length-1) + "</span>";
                /*
                evtcontent = evtcontent + '<span class="fc-event-titlebg">' +  fstart + " ";
                if(null != event.end) {
                    evtcontent = evtcontent + "- " + fend;
                }*/
                evtcontent = evtcontent + titlebg + '</span>';
                evtcontent = evtcontent + '</a><div class="ui-resizable-handle ui-resizable-e"></div></div>';
                element.html(evtcontent);
            }else if(view.name=="agendaWeek"){
                var evtcontent = '<a>';
                evtcontent = evtcontent + confbg;
                evtcontent = evtcontent + '<span class="fc-event-time">' +  fstart + " ";
                if(null != event.end) {
                    evtcontent = evtcontent + "- " + fend;
                }
                evtcontent = evtcontent + titlebg + '</span>';

                evtcontent = evtcontent + '</a><span class="ui-icon ui-icon-arrowthick-2-n-s"><div class="ui-resizable-handle ui-resizable-s"></div></span>';
                element.html(evtcontent);
            }else if(view.name=="agendaDay"){
                var evtcontent = '<a>';
                evtcontent = evtcontent + confbg;
                evtcontent = evtcontent + '<span class="fc-event-time">' +  fstart + " ";
                if(null != event.end) {
                    evtcontent = evtcontent + "- " + fend;
                }
                evtcontent = evtcontent + titlebg + '</span>';

                evtcontent = evtcontent + '<span>Room: ' +  event.confname + '</span>';
                evtcontent = evtcontent + '<span>Host: ' +  event.fullname + '</span>';
                evtcontent = evtcontent + '<span>Topic: ' +  event.topic + '</span>';
                evtcontent = evtcontent + '</a><span class="ui-icon ui-icon-arrow-2-n-s"><div class="ui-resizable-handle ui-resizable-s"></div></span>';
                element.html(evtcontent);
                console.log(evtcontent)
            }
        },

        eventMouseover: function (calEvent, jsEvent, view) {
            var fstart = moment(calEvent.start).format("MM-DD HH:mm"); //(calEvent.start, "yyyy/MM/dd HH:mm");
            var fend = moment(calEvent.end).format("MM-DD HH:mm"); //(calEvent.end, "yyyy/MM/dd HH:mm");
            //$(this).attr('title', fstart + " - " + fend + " " + "标题" + " : " + calEvent.title);
            $(this).css('font-weight', 'normal');
            $(this).tooltip({
                position: 'right',
                content: '<span style="color:#fff">' + fstart + " - " + fend + " " + " : " + calEvent.title + '</span> <br/> <span>' + calEvent.description + '</span>',
                onShow: function(){
                    $(this).tooltip('tip').css({
                        backgroundColor: '#666',
                        borderColor: '#666'
                    });
                }
            });
        },

        events: {
            url: '../task',
            error: function() {
                $('#script-warning').show();
            }
        },

        loading: function(bool) {
            $('#loading').toggle(bool);
        }

    });
}

function save() {
    if($('#taskTable').form('validate')) {
        $.post("../task/", drillDownForm('taskTable'), function(response) {
            if(response.status == FAIL){
                $.messager.alert('保存失败', response.message, 'info');
            } else {
                //$("#mainGrid").datagrid("reload");
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('addEventSource', '../task');
                $('#calendar').fullCalendar('rerenderEvents');
                $.messager.show({
                    title : '提示',
                    msg : "保存成功"
                });
            }
        }, "json");
    }
    return false;
}

function changeTaskStatus(e) {
    if(!$(this).linkbutton('options').disabled) {
        var src = $(e.target).parent().parent().attr("id");
        //var status = 0;
        //$('#btnStart').click(changeTaskStatus);
        //$('#btnPause').click(changeTaskStatus);
        //$('#btnStop').click(changeTaskStatus);
        //$('#btnComplete').click(changeTaskStatus);
        var oriStatus = $("#p_status").combobox("getValue");

        var data = {
            id: $("#p_id").val()
        }
        if (src == "btnStart") {
            data.status = 4;
            if (oriStatus == 3) {
                data.startAct = datetimeFormatter(new Date(), true);
            }
        } else if (src == "btnPause") {
            data.status = 5;
        } else if (src == "btnStop") {
            data.status = 6;
            data.endAct = datetimeFormatter(new Date(), true);
        } else if (src == "btnComplete") {
            $("#p_progress").html(formatProgress(100));
            data.progress = 100;
            if ($("#p_isDeptPlan").val() == 1 && $("#p_needVerify").val() == 1) {
                data.status = 7;
            } else {
                data.status = 8;
            }
        }

        $.post("../plan/changeStatus/", data, function (response) {
            if (response.status == SUCCESS) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                $("#p_status").combobox("setValue", data.status);
                if (data.startAct != undefined) {
                    $('#p_startAct').datebox("setValue", data.startAct);
                    $('#btnStart').linkbutton("disable");
                }
                if (data.endAct != undefined) {
                    $('#p_endAct').datebox("setValue", data.endAct);
                }

                setTaskWindowButtonStatus({
                    status: data.status,
                    superintendentId: $("#p_superintendentId").val(),
                    ownerId: $("#p_ownerId").val(),
                    coupler: $("#p_coupler").textbox("getValue"),
                    verifierId: $("#p_verifierId").val(),
                });
                $('#calendar').fullCalendar('refetchEvents');
            } else {
                $.messager.alert("错误", response.message);
            }
        });
    }
}

function deletePlan() {
    alert("1.自有任务可以删除,上级指派任务不可删除;\n2.需要confirm对话框");
}

function adjustProgress() {
    if(!$(this).linkbutton('options').disabled) {
        showModalDialog("progressWindow");
    }
}

function returnBack() {
    $("#taskWindow").window("close");
}

function estimatePlan(planId){
    "use strict";
    /*console.log("estimatePlan");
    var plan={"id":planId};
    if(userInfo.userId==$("#p_ownerId").val()){
        plan.selfQualityEstimate=$("input:radio[name='quality']:checked").val();
        plan.selfEffectiveEstimate=$("input:radio[name='effective']:checked").val();
    }else{
        plan.qualityEstimate=$("input:radio[name='quality']:checked").val();
        plan.effectiveEstimate=$("input:radio[name='effective']:checked").val();
    }

    $.post("../plan/update", plan,function(response){
        if(response.status == SUCCESS) {
            $('#grid1').treegrid("reload");
            if(userInfo.userId==$("#p_ownerId").val()){
                $("#p_selfQualityEstimate").combobox("setValue",$("input:radio[name='quality']:checked").val()) ;
                $("#p_selfEffectiveEstimate").combobox("setValue",$("input:radio[name='effective']:checked").val()) ;
            }else{
                $("#p_qualityEstimate").combobox("setValue",$("input:radio[name='quality']:checked").val()) ;
                $("#p_effectiveEstimate").combobox("setValue",$("input:radio[name='effective']:checked").val()) ;
            }

            $.messager.show({
                title : '提示',
                msg : response.message
            });
            $("#diaEstimate").dialog("close");
        } else {
            $.messager.alert("错误", response.message);
        }
    });*/
}

function saveProgress() {
    var data = {
        id:$("#p_id").val(),
    }

    data.progress = $("#k_progress").numberspinner("getValue") ;
    $.post("../plan/changeProgress/", data, function(response){
        if(response.status == SUCCESS) {
            $.messager.show({
                title : '提示',
                msg : response.message
            });

            $("#p_progress").html(formatProgress(data.progress));
            $('#calendar').fullCalendar('refetchEvents');
            $("#progressWindow").window("close");

        } else {
            $.messager.alert("错误", response.message);
        }
    });

}

function verify() {
    if(!$(this).linkbutton('options').disabled) {
        $.messager.confirm('任务核实', '是否确认该项计划任务已经完成?', function (r) {
            if (r) {
                var data = {
                    id: $("#p_id").val(),
                    status: 8
                }
                $.post("../plan/changeStatus/", data, function (response) {
                    if (response.status == SUCCESS) {
                        $.messager.show({
                            title: '提示',
                            msg: response.message
                        });

                        $('#p_status').combobox("setValue", 8);
                        $('#calendar').fullCalendar('refetchEvents');
                    } else {
                        $.messager.alert("错误", response.message);
                    }
                });
            }
        });
    }
}

$(function(){

    renderCalendar();

    //$("#btnSave").click(save);

    $('#tabsMenu').menu({onClick:tabsMenuOnClickHandler,width:110});

    $('#btnStart').click(changeTaskStatus);
    $('#btnPause').click(changeTaskStatus);
    $('#btnStop').click(changeTaskStatus);
    $('#btnEstimate').click(estimatePlan);
    $('#btnDelete').click(deletePlan);
    $('#btnProgress').click(adjustProgress);
    $('#btnComplete').click(changeTaskStatus);
    $('#btnCancel').click(returnBack);
    $('#btnSaveProgress').click(saveProgress);
    $('#btnVerify').click(verify);
});