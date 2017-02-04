
$(function(){
    $('#tt').tree({
        onClick:function(node){
            if(node.id!='interfaceQuery'){
                $("#main").panel({
                    fit:true,
                    href: './'+node.id+'.jsp',
                    onLoad: function () {

                    }
                });
            }
        }
    });


});


 