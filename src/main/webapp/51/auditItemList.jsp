<%@ page contentType="text/html; charset=UTF-8"%>
<!-- <script type="text/javascript" src="./userDoc.js"></script> -->
<script>
	
	function closeAuditWindow() {
		$("#auditContent").empty()
		$("#auditLog").empty()
	    $("#auditItemAccordion").accordion("select", 0); 
	}

	function stylerHczt(val, row, index) {
	    if (val == 1) {
	        return "";
	    } else if (val == 2) {
	        return "background-color:yellow";
	    } else if (val == 3) {
	        return "background-color:lightgreen";
	    }
	}

	function stylerHcjg(val, row, index) {
	    if (val == 1) {
	        return "background-color:lightgreen";
	    } else if (val == 2) {
	        return "background-color:pink";
	    } else {
	        return "";
	    }
	}

	function auditItemsTabSelectHandler(title,index) {
		if(canBeSelected(index)) {
			if(window.auditItemDataReady) {
				_auditItemsTabSelectHandler(index)
			} else {
				$.subscribe("AUDITITEM_DATA_INITIALIZED", _auditItemsTabSelectHandler, [index]);
			} 
		}
	}
	
	function _auditItemsTabSelectHandler(index) {
		if(canBeSelected(index)) {
			var tabPanel = $("#auditItemTabs").tabs("getTab", index);
			if(index == 0) {
				annualAuditItemInit();
			} else {
				instanceAuditItemInit()
			}
		}
	}
	
	function canBeSelected(index) {
		var hcrw = $('#grid1').datagrid('getSelected');
		return hcrw.nr == 3 || (hcrw.nr == 1 && index == 0) || (hcrw.nr == 2 && index == 1);
	}
	
	function initAuditItemList() {
		$("#auditItemAccordion").accordion("select", 0); 
		var hcrw = $('#grid1').datagrid('getSelected');
		if(hcrw.nr == 1) {
			$("#auditItemTabs").tabs("enableTab", 0).tabs("select", 0);
			$("#auditItemTabs").tabs("disableTab", 1);
		} else if(hcrw.nr == 2) {
			$("#auditItemTabs").tabs("disableTab", 0);
			$("#auditItemTabs").tabs("enableTab", 1).tabs("select", 1);
		} else {
			$("#auditItemTabs").tabs("enableTab", 0).tabs("select", 0);
			$("#auditItemTabs").tabs("enableTab", 1);
		} 
	} 
	
	function doAuditItemListInit() {
		window.auditItemDataReady = false;
		var hcrw = $('#grid1').datagrid('getSelected');
		$.ajax({
	        url: "./" + hcrw.id + "/initStatus",
	        data: {hcrwId: hcrw.id},
	        type: 'GET',
	        success: function (response) {
	            if (response.status == SUCCESS) {
	                if (response.data == 0) {
	                    $.messager.confirm('确认', '核查列表尚未生成,是否认生成核查列表?', function (r) {
	                        if (r) {
	                            $.ajax({
	                                url: "./" + hcrw.id + "/init",
	                                type: 'POST',
	                                success: function (response) {
	                                    if (response.status == SUCCESS) {
	                                    	$.publish("AUDITITEM_DATA_INITIALIZED", null);
	                                    	window.auditItemDataReady = true;
	                                    	initAuditItemList();
	                                    } else {
	                                        //$.messager.alert('删除失败', response, 'info');
	                                    }
	                                }
	                            });
	                        }
	                    });
	                } else {
	                	$.publish("AUDITITEM_DATA_INITIALIZED", null);
	                	window.auditItemDataReady = true;
	                	initAuditItemList();
	                }

	            }
	        }
	    });
	}
	
	//-----------annual
	
	
function annualAuditItemClickHandler() {
    if ($('#annualAuditItemGrid').datagrid('getSelected') != null) {
        $('#btnAnnualAudit').linkbutton('enable');
    } else {
        $('#btnAnnualAudit').linkbutton('disable');
    }
}

function annualAuditItemDblClickHandler(index, row) {
    window.selected = index;
    $('#annualAuditItemGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
    _funcAnnualAudit();
}
	
function funcAnnualAudit() {
	if(!$(this).linkbutton('options').disabled) {
		_funcAnnualAudit();
	}
}
function _funcAnnualAudit() {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
    	$.alert("未配置比对页面")
    } else {
    	$("#auditItemAccordion").accordion("select", 1); 
        //showModalDialog("auditWindow");
        $("#auditContent").panel({
            href: '../audit/' + auditItem.page + '.jsp',
            onLoad: function () {
                doInit();
            }
        });
        /* 
        if ($("#auditLog").length == 0) {
            $('<div id="auditLog" style="margin-top:5px;"></div>').appendTo($("#auditWindow"))
        }
        $("#auditLog").panel({
            href: '../audit/log.jsp',
            onLoad: function () {
                //doInit();
            }
        }); */
        
        
    }
}

function annualAuditItemInit() {
	var options = $("#annualAuditItemGrid").datagrid("options");
    options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
    $('#annualAuditItemGrid').datagrid('load', {
    	hcrwId: $('#grid1').datagrid('getSelected').id,
    	hclx: 1
    });
}
//---------------annual end and instance begin

function instanceAuditItemGridClickHandler() {
    if ($('#instanceAuditItemGrid').datagrid('getSelected') != null) {
        $('#btnInstanceAudit').linkbutton('enable');
    } else {
        $('#btnInstanceAudit').linkbutton('disable');
    }
}

function instanceAuditItemGridDblClickHandler(index, row) {
	window.selected = index;
    $('#instanceAuditItemGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
    _funcInstanceAudit();
}
	
function funcInstanceAudit() {
	if(!$(this).linkbutton('options').disabled) {
		 _funcInstanceAudit();
	}
}

function _funcInstanceAudit() {
	var auditItem = $("#instanceAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
        $.alert("未配置比对页面")
    } else {
        //showModalDialog("auditWindow");
        $("#auditContent").panel({
            href: '../audit/' + auditItem.page + '.jsp',
            onLoad: function () {
                doInit();
            }
        });
        if ($("#auditLog").length == 0) {
            $('<div id="auditLog" style="margin-top:5px;"></div>').appendTo($("#auditWindow"))
        }
        $("#auditLog").panel({
            href: '../audit/log.jsp',
            onLoad: function () {
                //doInit();
            }
        });
        
        $("#auditItemAccordion").accordion("select", 1); 
    }
}

function instanceAuditItemInit() {
	var options = $("#instanceAuditItemGrid").datagrid("options");
    options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
    $('#instanceAuditItemGrid').datagrid('load', {
    	hcrwId: $('#grid1').datagrid('getSelected').id,
    	hclx: 2
    });
	
}


//================instance end=========
$(function () {
	$("#btnAnnualAudit").click(funcAnnualAudit);
	$("#btnInstanceAudit").click(funcInstanceAudit);
});

</script>
<div id="auditItemAccordion" class="easyui-accordion" data-options="fit:true,border:false,animate:true" style="width:500px;height:467px;"> 
	<div title="核查事项列表" data-options="iconCls:'icon2 r4_c20', selected:true" style="overflow:auto;">
		<div id="auditItemTabs" class="easyui-tabs" data-options="fit: true, border: false, onSelect:auditItemsTabSelectHandler">
			<div data-options="title: '年报信息', iconCls: 'icon2 r9_c2', refreshable: false, selected: true">
				<table id="annualAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,height: 380,	
				    	onClickRow:annualAuditItemClickHandler,width:805,
						ctrlSelect:true,method:'get',onDblClickRow:annualAuditItemDblClickHandler,
						toolbar: '#annualAuditItemGridToolbar'" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">核查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
				             formatter="formatCodeList">核查方式</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
				         <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
				             formatter="formatCodeList"  styler="stylerHczt">核查状态</th>
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">核查结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
				     </tr>
				     </thead>
				 </table>
				 <div id="annualAuditItemGridToolbar">
				     <a href="#" id="btnAnnualAudit" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" disabled>核查/查看</a>
				 </div>
			</div>
			<div data-options="title: '即时信息', iconCls: 'icon2 r8_c1', refreshable: false">
				<table id="instanceAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,	height: 380,
						onClickRow:instanceAuditItemGridClickHandler,width:805,
						ctrlSelect:true,method:'get',onDblClickRow:instanceAuditItemGridDblClickHandler,
						toolbar: '#instanceAuditItemGridToolbar'" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">核查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
				             formatter="formatCodeList">核查方式</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
				         <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
				             formatter="formatCodeList"  styler="stylerHczt">核查状态</th>
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">核查结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
				     </tr>
				     </thead>
				 </table>
				 <div id="instanceAuditItemGridToolbar">
				     <a href="#" id="btnInstanceAudit" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" disabled>核查/查看</a>
				 </div>
			</div>
		</div>
    </div>
    <div title="事项内容" data-options="iconCls:'icon2 r11_c17'" style="padding:5px;">
        <div id="auditWindow"  title="核查"
		     data-options="modal:true,closed:true,iconCls:'icon-search'"
		     style="width: 750px; height: 420px; padding: 10px;">
			<div id="auditContent" style="padding:10px;"></div>
			<div id="auditLog" style="margin-top:5px;"></div>
		</div>
    </div>
</div>
</div>
     
