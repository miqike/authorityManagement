<%@ page contentType="text/html; charset=UTF-8" %>
<table id="gsxxzcb111" width="80%" border="1" cellspacing="0" align="center">
	<caption align="top" style="font-size: 30px;">企业公示信息自查表</caption>
	<tr>
	<th colspan="2" style="height: 20px;">企业名称</th>
	<th ><input class="easyui-textbox" id="p_qymc"style="border: none; width: 100%;height: 100%" /></th>
	<th colspan="2">年度</th>
	<th ><input class="easyui-textbox" id="p_nd"style="border: none; width: 100%;height: 100%" data-options="required:true"/></th>
	<th colspan="2">填报日期</th>
	<th ><input class="easyui-textbox" id="p_tbrq"style="border: none; width: 100%;height: 100%" /></th>
	
	</tr>
	<tr>
	<td colspan="2">统一社会信用代码</td>
	<td colspan="2"><input class="easyui-textbox" id="p_xydm"style="border: none; width: 100%;" data-options="required:true" /></td>
	<td colspan="2">法定代表人</td>
	<td colspan="3"><input class="easyui-textbox" id="p_fddbr"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td colspan="2">工商联络员</td>
	<td colspan="2"><input class="easyui-textbox" id="p_gslly"style="border: none; width: 100%;" /></td>
	<td colspan="2">联系电话</td>
	<td colspan="3"><input class="easyui-textbox" id="p_lxdh"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td colspan="2">实际经营地址</td>
	<td colspan="2"><input class="easyui-textbox" id="p_sjjydz"style="border: none; width: 100%;" /></td>
	<td colspan="2">电子邮箱</td>
	<td colspan="3"><input class="easyui-textbox" id="p_dzyx"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td colspan="2">网站/网店名称</td>
	<td colspan="2"><input class="easyui-textbox" id="p_wzwd"style="border: none; width: 100%;" /></td>
	<td colspan="2">从业人数</td>
	<td colspan="3"><input class="easyui-textbox" id="p_cyrs"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td colspan="2">经营状态</td>
	<td colspan="2"><input class="easyui-textbox" id="p_jyzt"style="border: none; width: 100%;" /></td>
	<td colspan="2">邮政编码</td>
	<td colspan="3"><input class="easyui-textbox" id="p_yzbm"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td colspan="2">全年工资总额（万元）</td>
	<td colspan="2" ><input class="easyui-textbox" id="p_qngzze"style="border: none; width: 100%;" /></td>
	<td colspan="2">全年纳税总额（万元）</td>
	<td colspan="3"><input class="easyui-textbox" id="p_qnnsze"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td rowspan="8" colspan="2" align="center">企业公示信息</td>
	<td colspan="7" align="center">是否存在应当公示的信息</td>
	<tr>
	<td>是否有股东或发起人认缴和实缴的出资额、出资时间、出资方式等信息</td>
	<td>
	<input id="p_sfyGdcz"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="gdjczxx.jsp">股东及出资信息表</a></td>
	</tr>
	<tr><td>是否有有限公司股东股权转让等股权变更信息</td>
	<td>
	<input id="p_sfyGqbg"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="gqbgxxb.jsp">股权转让等股权变更信息</a></td>
	</tr>
	<tr><td>是否有企业投资设立企业、购买股权信息</td>
	<td>
	<input id="p_sfyDwtz"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	<td colspan="5"><a href="qytzslqygmgqxxb.jsp">企业投资设立企业、购买股权信息</a></td>
	</tr>
	<tr><td>是否有对外提供保证担保信息</td>
	<td>
	<input id="p_sfyDwdb"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="dwdbxxb.jsp">对外担保信息</a></td>
	</tr>
	<tr><td>是否有行政许可取得、变更、延续信息</td>
	<td>
	<input id="p_sfyXzxk"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="xzxkxxb.jsp">行政许可取得、变更、延续信息</a></td>
	</tr>
	<tr><td>是否有知识产权出质登记信息</td>
	<td>
	<input id="p_sfyZscq"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="zscqczdjxxb.jsp">知识产权出质登记信息</a></td>
	</tr>
	<tr><td>是否有受到行政处罚信息</td>
	<td>
	<input id="p_sfyXzcf"  class="easyui-combobox" data-options="valueField:'id',textField:'value',data:[{id:'1',value:'是'},{id:'0',value:'否'}]"/>
	</td>
	<td colspan="5"><a href="xzcfxxb.jsp">受到行政处罚信息</a></td>
	</tr>
	</tr>
	<tr>
	<td colspan="9" align="center">本企业郑重承诺：上述自查内容属实，如有隐瞒真实情况、弄虚作假，愿承担由此产生的法律责任。</td>
	</tr>
</table>
    <div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btnSaveGsxx" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	</div>
	<script type="text/javascript"  src="./gsxx.js">
