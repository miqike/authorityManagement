function formatPercentage(val, row) {
    return (val * 100).toFixed(2);
}

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnClear').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnClear').linkbutton('disable');
	}
}

function view(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		$.getJSON("../sys/cache/" + row.cacheName, {}, function (response) {
			$("#cacheGrid").datagrid({
				view: detailview,
				detailFormatter: function (index, row) {
					return '<div id="detailForm-' + index + '" class="ddv" style="padding:5px 0"></div>';
				},
				onExpandRow: function (index, _row) {
					var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
					ddv.panel({
						border: false,
						cache: false//
					});
					$.get('../sys/cache/' + row.cacheName + '/' + encodeURIComponent(_row.key), null, function (response) {
                        var text = "<pre>";
                        try {
                            JSON.parse(response)
                            eval("var objValue = " + response);
                            for (var key in objValue) {
                                text += (key + ":" + JSON.stringify(objValue[key]));
                                text += "\n";
                            }
                        } catch (e) {
                            text += response;
                            text += "\n";
                        }
						text += "<pre>";
						ddv.empty().append(text);
						$('#cacheGrid').datagrid('fixDetailRowHeight', index);
					}, "text");
                    $('#cacheGrid').datagrid('fixDetailRowHeight', index);
				}
			}).datagrid("loadData", response.keys);
			showModalDialog("popWindow");
		});
	}
}

function remove() {
	if(!$(this).linkbutton('options').disabled) {
		var cacheRow = $('#mainGrid').datagrid('getSelected');
		var cacheName = cacheRow.cacheName;
		var selectRowIndex = $('#mainGrid').datagrid('getRowIndex', cacheRow);
		var row = $('#cacheGrid').datagrid('getSelected');
		$.ajax({
			url: "../sys/cache/" + cacheName + "/" + encodeURIComponent(row.key),
			type: 'DELETE',
			success: function (response) {
				$.messager.show({
					title : '提示',
					msg : response.message
				});
				$.getJSON("../sys/cache/" + cacheName, {}, function (response) {
					$('#cacheGrid').datagrid("loadData", response.keys);
				});
				$('#mainGrid').datagrid({
					onLoadSuccess:function(){
						$('#mainGrid').datagrid("selectRow", selectRowIndex);
					}
				}).datagrid('load', null);
			}
		});
	}
}

//刷新缓存
function refresh1() {
	if(!$(this).linkbutton('options').disabled) {
		var cacheName = $('#mainGrid').datagrid('getSelected').cacheName;
		$.getJSON("../sys/cache/" + cacheName, {}, function (response) {
			$('#cacheGrid').datagrid("loadData", response.keys);
		});
	}
}

function clear() {
	if(!$(this).linkbutton('options').disabled) {
		var cacheName = $('#mainGrid').datagrid('getSelected').cacheName;
		$.ajax({
			url: "../sys/cache/" + cacheName,
			type: 'DELETE',
			success: function (response) {
				$.messager.show({
					title : '提示',
					msg : response.message
				});
				$('#mainGrid').datagrid('load', null);
			}
		});
	}
}

$(function() {
	$("#btnView").click(view);
	$("#btnDelete").click(remove);
	$("#btnRefresh1").click(refresh1);
	$("#btnClear").click(clear);
	$("#btnRefresh").click(function(){
		$('#mainGrid').datagrid('load',null);
	});
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
});
