/**
 * Created by Tommy on 12/10/2015.
 */

//功能按钮矩阵
var buttons = [
    'btnAdd',
    'btnSplit',
    'btnView',

    'btnPropose',
    'btnApprove',

    'btnStart',
    'btnPause',
    'btnStop',
        'btnProgress',
        'btnComplete',
    'btnVerify',
    'btnEstimate',
    'btnDelete'];

//功能按钮状态矩阵
var buttonStatus = [
    [1,1,1,1,0,1,0,0,0,0,0,0,1], // 1 草稿
    [1,0,0,0,1,0,1,0,0,0,0,0,0], // 2 已提交审批
    [1,0,1,0,0,1,0,1,0,0,0,0,0], // 3 已审批
    [1,1,1,0,0,0,1,1,1,1,0,0,0], // 4 已开始执行中
    [1,1,1,0,0,1,0,1,0,1,0,0,0], // 5 暂停
    [1,1,1,0,0,0,0,0,0,1,1,1,1], // 6 终止
    [1,1,1,0,0,0,0,0,0,0,1,1,1], // 7 待核实
    [1,1,1,0,0,0,0,0,0,0,0,1,1], // 8 完成/已核实
    [1,0,1,0,0,0,0,0,0,0,0,0,0]  // 9 已删除
];


var roleStatus = [
    [1,0,1,1,0,1,1,1,1,1,0,0,1], // 1 负责人
    [1,1,1,1,0,1,1,1,1,1,0,1,1], // 2 执行人
    [1,0,1,1,0,0,0,0,0,0,0,0,0], // 3 协作人
    [1,0,1,1,0,0,0,0,0,0,1,0,0]  // 4 核实人
    [0,0,0,0,1,0,0,0,0,0,0,0,0]  // 4 审批人
];

var editableFields = [
    'sn', 'title', 'description', 'importance', 'instancy', 'start', 'end'
];


function getButtonStatusByRole(row) {
    var _buttonStatus = [0,0,0,0,0,0,0,0,0,0,0];
    var userId = userInfo.id;
    if(row.superintendentId == userId) {
        _buttonStatus = _or(_buttonStatus, roleStatus[0]);
    }
    if(row.ownerId == userId) {
        _buttonStatus = _or(_buttonStatus, roleStatus[1]);
    }
    if(row.coupler.contains(userId)) {
        _buttonStatus = _or(_buttonStatus, roleStatus[2]);
    }
    if(row.verifierId == userId) {
        _buttonStatus = _or(_buttonStatus, roleStatus[3]);
    }
    if(row.approverId == userId) {
        _buttonStatus = _or(_buttonStatus, roleStatus[4]);
    }
    return _buttonStatus;
}

function getButtonStatus(row) {
    var _buttonStatus = buttonStatus[row.status - 1];
    _buttonStatus = _and(_buttonStatus, getButtonStatusByRole(row));
    return _buttonStatus;
}

function _or(a1, a2) {
    var result = new Array(a1.length);
    for(var i=0; i<a1.length; i++) {
        result[i] = a1[i] + a2[i] > 0 ? 1: 0;
    }
    return result;
}

function _and(a1, a2) {
    var result = new Array(a1.length);
    for(var i=0; i<a1.length; i++) {
        result[i] = a1[i] * a2[i] > 0 ? 1: 0;
    }
    return result;
}
