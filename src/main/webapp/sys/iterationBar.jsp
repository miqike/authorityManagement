<%@ page contentType="text/html; charset=UTF-8"%>
<div>
	<a href="javascript:void(0);" id="_btnAdd_" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
	<a href="javascript:void(0);" id="_btnFirst_" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
	<a href="javascript:void(0);" id="_btnPre_" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
	<a href="javascript:void(0);" id="_btnNext_" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
	<a href="javascript:void(0);" id="_btnLast_" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
	<a href="javascript:void(0);" id="_btnDelete_" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
</div>
<script>
function _funcAdd_() {
	window.selected = -1;
	window.navigateBar.grid.datagrid('unselectAll');
	loadForm();
}

function _funcPre_() {
	var row =  window.navigateBar.grid.datagrid('getSelected');
	var rowIndex = window.navigateBar.grid.datagrid('getRowIndex', row);
	if(rowIndex > 0) {
		window.selected = rowIndex - 1;
		window.navigateBar.grid.datagrid('unselectAll').datagrid('selectRow', window.selected);
		loadForm();
	}
}

function _funcNext_() {
	var row =  window.navigateBar.grid.datagrid('getSelected');
	var rowIndex = window.navigateBar.grid.datagrid('getRowIndex', row);
	if(rowIndex < window.navigateBar.grid.datagrid('getRows').length - 1) {
		window.navigateBar.grid.datagrid('unselectAll').datagrid('selectRow', rowIndex + 1);
		window.selected = rowIndex + 1;
		loadForm();
	}
}

function _funcFirst_() {
	var row =  window.navigateBar.grid.datagrid('getSelected');
	var rowIndex = window.navigateBar.grid.datagrid('getRowIndex', row);
	if(rowIndex > 0) {
		window.navigateBar.grid.datagrid('unselectAll').datagrid('selectRow', 0);
		window.selected = 0;
		loadForm();
	}
}

function _funcLast_() {
	var row =  window.navigateBar.grid.datagrid('getSelected');
	var rowIndex = window.navigateBar.grid.datagrid('getRowIndex', row);
	if(rowIndex < window.navigateBar.grid.datagrid('getRows').length - 1) {
		window.selected = window.navigateBar.grid.datagrid('getRows').length - 1;
		window.navigateBar.grid.datagrid('unselectAll').datagrid('selectRow', window.selected);
		loadForm();
	}
}

$(function() {
	$("#_btnAdd_").click(_funcAdd_);
	$("#_btnPre_").click(_funcPre_);
	$("#_btnNext_").click(_funcNext_);
	$("#_btnFirst_").click(_funcFirst_);
	$("#_btnLast_").click(_funcLast_);
	$("#_btnDelete_").click(_funcDelete_);
});
</script>