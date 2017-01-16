$(function() {
	var nodeId;

	$('#tt').tree({
		data: [{
			id: 'zcb',
			text: '自查表',
			children: [{
				id:'zcfz',
				text: '资产负债表'
				},{
				id:'lr',
				text: '利润表'
				},{
				id:'qygsxxzcb',
			    text: '企业公示信息自查表'
			    },{
		       id:'gdjczxx',
			   text: '股东及出资信息表'
			   },{
			   id:'gqbgxxb',
	           text: '股东股权转让等股权变更信息表'
	           },{
		      id:'dwtz',
	          text: '企业投资设立企业、购买股权信息表'},{
		      id:'dwdb',
	          text: '对外担保信息表'},{
		      id:'xzxkxxb',
	          text: '行政许可取得、变更、延续信息表'},{
		      id:'zscqczdjxxb',
	          text: '知识产权出质登记信息表'},{
		      id:'xzcfxxb',
	          text: '行政处罚信息表'},{
		      id:'xjll',
	          text: '现金流量表'}
	          ]
		}],
		onClick: function(node){
			if(node.id!='zcb'){
				  $("#main").panel({
			        	fit:true,
			            href: './'+node.id+'.jsp',
			            onLoad: function () {
			            }
			        });
			}
		}

	});
	
})