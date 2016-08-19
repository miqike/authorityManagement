<%@ page contentType="text/html; charset=UTF-8"%>

<div id="zfryWindow">
    <div id="baseInfo" title="基本信息" style="padding:5px;" selected="true">
        <table width="100%" id="zfryTable">
            <tr>
                <td>检查机关</td>
                <td>
		            <input id="p_dwId" type="hidden" />
                	<input class="easyui-validatebox add" id="p_dwName" 
                           data-options="required:true" style="width:200px;"/>
                </td>
                <td>管辖单位</td>
                <td>
		            <input id="p_gxdwId" type="hidden" />
                	<input class="easyui-validatebox add" id="p_gxdwName" 
                           data-options="required:true" style="width:170px;"/>
					<a href="#" id="btnSelectOrgDialog" class="easyui-linkbutton" iconCls="icon2 r17_c20" plain="true"></a>
                </td>
                
            </tr>
            <tr>
                <td>人员编码</td>
                <td><input class="easyui-validatebox add" id="p_code" 
                           data-options="required:true" style="width:200px;"/>
                </td>
                <td>操作员编码</td>
                <td>
                    <input class="easyui-validatebox" id="p_userId"  style="width:200px;" />
                </td>
            </tr>
            <tr>
                <td>人员名称</td>
                <td><input class="easyui-validatebox add update"  id="p_name" data-options="required:true"
                           style="width:200px;"/>
                </td>
                <td>性别</td>
                <td>
                    <input class="easyui-combobox add update" id="p_gender"  style="width:208px;" data-options="panelHeight:70"
                           codeName="gender"/>
                </td>
            </tr>
            <tr>
                <td>职务</td>
                <td><input class="easyui-validatebox add update"  id="p_zw" data-options=""
                           style="width:200px;"/></td>
                <td>联系电话</td>
                <td><input class="easyui-validatebox add update"  id="p_mobile" data-options=""
                           style="width:200px;"/></td>
            </tr>
            <tr>
                <td>电子邮件</td>
                <td><input class="easyui-validatebox add update"  id="p_mail" data-options=""
                           style="width:200px;"/></td>
                <td>执法证号</td>
                <td><input class="easyui-validatebox add update"  id="p_zfzh" data-options="required:true"
                           style="width:200px;"/></td>
            </tr>
            <tr>
                <td>身份证号</td>
                <td><input class="easyui-validatebox add update"  id="p_sfzh" data-options=""
                           style="width:200px;"/></td>
                <td>执法类型</td>
                <td><input class="easyui-combobox add update"  id="p_zflx" data-options="panelHeight:70"
                           style="width:208px;" codeName="zfjdlx"/></td>
            </tr>
            <tr>
                <td>文化程度</td>
                <td><input class="easyui-combobox add update"  id="p_whcd" data-options="panelHeight:100"
                           style="width:208px;" codeName="whcd"/></td>
                <td>状态</td>
                <td><input class="easyui-combobox add update"  id="p_zt" data-options="panelHeight:70"
                           style="width:208px;" codeName="userStatus"/></td>
            </tr>
        </table>
    </div>
</div>