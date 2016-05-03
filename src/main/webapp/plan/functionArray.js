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
    [1,0,0,0,0,0,0,0,0,0,0,0,0], // 0 新增时使用
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

var buttonRoleStatus = [
    [1,1,1,1,0,0,0,0,0,0,0,0,1], // 1 创建人
    [1,0,1,1,0,1,1,1,1,1,0,0,1], // 2 负责人
    [1,1,1,1,0,1,1,1,1,1,0,1,1], // 3 执行人
    [0,0,1,0,0,0,0,0,0,0,0,0,0], // 4 协作人
    [1,0,1,1,0,0,0,0,0,0,1,0,0], // 5 核实人
    [0,0,0,0,1,0,0,0,0,0,0,0,0]  // 6 审批人
];


//输入栏矩阵
var fields = [
    'sn',
    'title',
    'description',
    'importance',
    'instancy',
    'status',
    'progress',
    'superintendentName',
    'ownerName',
    'coupler',
    'weight',
    'superintendDeptName',
    'coupleDept',
    'level',
    'needVerify',
    'verifierName',
    'start',
    'end',
    'startAct',
    'endAct',
    'authorName',
    'createTime',
    'approverName',
    'approveTime',
    'selfQualityEstimate',
    'selfEffectiveEstimate',
    'qualityEstimate',
    'effectiveEstimate'];

//输入栏状态矩阵
var fieldStatus = [
    [0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0, 1,1, 0,0,0,0, 1, 0,0,0,0,0], // 1 草稿
    [0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0, 1,1, 0,0,0,0, 1, 0,0,0,0,0], // 2 已提交审批
    [0,0,1,0,0,0,0,1,0,0,1,0,0,1,0,0, 1,0, 0,0,0,0, 0, 0,0,0,0,0], // 3 已审批
    [0,1,1,0,0,0,0,1,1,1,1,0,1,1,0,0, 0,1, 0,0,0,0, 0, 0,0,0,0,0], // 4 已开始执行中
    [0,1,1,0,0,0,0,1,0,1,1,0,1,1,0,0, 1,0, 0,0,0,0, 0, 0,0,0,0,0], // 5 暂停
    [0,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0, 0,0, 0,0,0,0, 1, 0,0,0,0,0], // 6 终止
    [0,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0, 0,0, 0,0,0,0, 1, 0,0,0,0,0], // 7 待核实
    [0,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0, 0,0, 0,0,0,0, 1, 0,0,0,0,0], // 8 完成/已核实
    [0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0, 0,0, 0,0,0,0, 0, 0,0,0,0,0]  // 9 已删除
];

var fieldRoleStatus = [
    [0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1, 1,1, 0,0,0,0, 1, 0,0,0,0,0], // 1 创建人
    [0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1, 1,1, 0,0,0,0, 1, 0,0,0,0,0], // 2 负责人
    [0,0,1,1,1,0,0,0,1,0,1,1,1,1,1,1, 1,1, 0,0,0,0, 1, 0,0,0,0,0], // 3 执行人
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0, 0,0,0,0, 0, 0,0,0,0,0], // 4 协作人
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0, 0,0,0,0, 0, 0,0,0,0,0], // 5 核实人
    [0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1, 1,1, 0,0,0,0, 1, 0,0,0,0,0]  // 6 审批人
];

var editableFields = [
    'sn', 'title', 'description', 'importance', 'instancy', 'start', 'end'
];

function getButtonStatusByRole(row) {
    var _buttonStatus = [1,1,1,0,0,0,0,0,0,0,0,0,0];
    var userId = userInfo.id;
    if(row.authorId == userId) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[0]);
    }
    if(row.superintendentId == userId) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[1]);
    }
    if(row.ownerId == userId) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[2]);
    }
    if(row.coupler.contains(userId)) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[3]);
    }
    if(row.verifierId == userId) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[4]);
    }
    if(row.approverId == userId) {
        _buttonStatus = _or(_buttonStatus, buttonRoleStatus[5]);
    }
    return _buttonStatus;
}
function getFieldStatusByRole(row) {
    var _fieldStatus = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0, 0,0,0,0, 0, 0,0,0,0,0];

    var userId = userInfo.id;
    if(row.authorId == userId) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[0]);
    }
    if(row.superintendentId == userId) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[1]);
    }
    if(row.ownerId == userId) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[2]);
    }
    if(row.coupler.contains(userId)) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[3]);
    }
    if(row.verifierId == userId) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[4]);
    }
    if(row.approverId == userId) {
        _fieldStatus = _or(_fieldStatus, fieldRoleStatus[5]);
    }
    return _fieldStatus;
}

function getButtonStatus(row) {
    var _buttonStatus = buttonStatus[row.status];
    _buttonStatus = _and(_buttonStatus, getButtonStatusByRole(row));
    return _buttonStatus;
}

function getFieldStatus(row) {
    var _fieldStatus = fieldStatus[row.status - 1];
    _fieldStatus = _and(_fieldStatus, getFieldStatusByRole(row));
    return _fieldStatus;
}


function _or(a1, a2) {
    var result = new Array(a1.length);
    for(var i=0; i<a1.length; i++) {
        if( a1[i] == -1 ||a2[i] == -1) {
            result[i] = -1
        } else {
            result[i] = a1[i] + a2[i] > 0 ? 1: 0;
        }
    }
    return result;
}

function _and(a1, a2) {
    var result = new Array(a1.length);
    for(var i=0; i<a1.length; i++) {
        if( a1[i] == -1 ||a2[i] == -1) {
            result[i] = -1
        } else {
            result[i] = a1[i] * a2[i] > 0 ? 1 : 0;
        }
    }
    return result;
}

function buttonStatusHandler(row) {
    var _buttonStatus= getButtonStatus(row);
    for(var i=0; i<buttons.length; i++ ) {
        if(_buttonStatus[i] == -1) {
            $("#" + buttons[i]).hide();
            $("#" + buttons[i] + "1").hide();
        } else {
            $("#" + buttons[i]).show();
            $("#" + buttons[i] + "1").show();
            $("#" + buttons[i]).linkbutton(getButtonStatusStatement(_buttonStatus[i]));
            $("#" + buttons[i] + "1").linkbutton(getButtonStatusStatement(_buttonStatus[i]));
        }
    }
}
