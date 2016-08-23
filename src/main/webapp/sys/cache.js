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
		$("#popWindow").window("open")
	});
}

function remove() {
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

//刷新缓存
function refresh1() {
	var cacheName = $('#mainGrid').datagrid('getSelected').cacheName;
	$.getJSON("../sys/cache/" + cacheName, {}, function (response) {
		$('#cacheGrid').datagrid("loadData", response.keys);
	});
}

function refresh(){
	$('#mainGrid').datagrid('load',null);
}

function clear() {
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
