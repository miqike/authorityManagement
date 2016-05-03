$(function () {

    $("#btnSuccess").click(function(){
        var data={};
        data.applyer=$("#applyer").val();
        data.context=$("#context").val();
        data.auditer=$("#auditer").val();
        data.auditFlag=1;

        $.post("./applyFor/messageApplyUpdate", data, function(response) {
            alert(response.message);
            if(response.status=="1"){
                var context="["+$("#applyer").val()+"]提出申请，申请内容["+$("#context").val()+"]，审核通过了！";
                $.getJSON(encodeURI("./weixin/sendMessage?openId="+$("#applyer").val()+"&context="+context),null,function(response){

                });
                WeixinJSBridge.call('closeWindow');
            }
        }, "json");
    });

    $("#btnFail").click(function(){
        var data={};
        data.applyer=$("#applyer").val();
        data.context=$("#context").val();
        data.auditer=$("#auditer").val();
        data.auditFlag=-1;

        $.post("./applyFor/messageApplyUpdate", data, function(response) {
            alert(response.message);
            if(response.status=="1"){
                var context="["+$("#applyer").val()+"]提出申请，申请内容["+$("#context").val()+"]，审核被拒绝了！";
                $.getJSON(encodeURI("./weixin/sendMessage?openId="+$("#applyer").val()+"&context="+context),null,function(response){

                });
                WeixinJSBridge.call('closeWindow');
            }
        }, "json");
    });

});