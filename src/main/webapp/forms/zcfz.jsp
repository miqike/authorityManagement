	 <%@ page contentType="text/html; charset=UTF-8" %>
 	
 
	<table id="zcfz111" width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">资产负债表</caption>
		<tr>
                <td>信用代码</td>
                <td colspan="2"><input id="p_xydm" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td>年度</td>
                <td colspan="2"><input id="p_nd" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td >填报日期</td>
                <td ><input id="p_tbrq" class="easyui-textbox"  style="width:100%;height:100%;"></td>
            </tr>
		<tr>
			<th align="center">资产</th>
			<th align="center">项目</th>
			<th align="center">期初数</th>
			<th align="center">期末数</th>
			<th align="center">负债及所有者权益</th>
			<th align="center">项目</th>
			<th align="center">期初数</th>
			<th align="center">期末数</th>
		</tr>
		<tr>
			<td>流动资产：</td>
			<td id="xm">1</td>
			<td width="20"><input class="easyui-textbox"  id="p_item1Qcs" 
                style="width:100%;height:100%;border: none;"></td>
			<td width="20"><input class="easyui-textbox"  id="p_item1Qms" 
                style="width:100%;height:100%;"></td>
			<td>流动负债：</td>
			<td>44</td>
			<td style="width: 200px;"><input class="easyui-textbox"  id="p_item44Qcs" 
                style="width:100%;height:100%;"></td>
			<td style="width: 200px;"><input class="easyui-textbox"  id="p_item44Qms" 
                style="width:100%;height:100%;"></td>
		</tr>
		<tr>
			<td>货币资金</td>
			<td id="xm">2</td>
			<td width="200px"><input class="easyui-textbox" id="p_item2Qcs" 
                style="width:100%;height:100%;"></td>
			<td width="200px"><input class="easyui-textbox"  id="p_item2Qms" 
                style="width:100%;height:100%;"></td>
			<td>短期借款</td>
			<td>45</td>
			<td width="20"><input class="easyui-textbox" id="p_item45Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item45Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>以公允价值计量且其变动计入当期损益的金融资产</td>
			<td id="xm">3</td>
			<td width="20"><input class="easyui-textbox" id="p_item3Qcs"
				style=" width: 100%;height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item3Qms"
				style="width:100%; height:100%;"></td>
			<td>以公允价值计量且其变动计入当期损益的金融负债</td>
			<td>46</td>
			<td width="20"><input class="easyui-textbox" id="p_item46Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item46Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>衍生金融资产</td>
			<td id="xm">4</td>
			<td width="20"><input class="easyui-textbox" id="p_item4Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item4Qms"
				style="width:100%; height:100%;"></td>
			<td>衍生金融负债</td>
			<td>47</td>
			<td width="20"><input class="easyui-textbox" id="p_item47Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item47Qms"
				style="width:100%; height:100%;"></td>
		</tr>
		<tr>
			<td>应收票据</td>
			<td id="xm">5</td>
			<td width="20"><input class="easyui-textbox" id="p_item5Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item5Qms"
				style="width:100%; height:100%;"></td>
			<td>应付票据</td>
			<td>48</td>
			<td width="20"><input class="easyui-textbox" id="p_item48Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item48Qms"
				style="width:100%; height:100%;"></td>
		</tr>
		<tr>
			<td>应收账款</td>
			<td id="xm">6</td>
			<td width="20"><input class="easyui-textbox" id="p_item6Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item6Qms"
				style="width:100%; height:100%;"></td>
			<td>应付账款</td>
			<td>49</td>
			<td width="20"><input class="easyui-textbox" id="p_item49Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item49Qms"
				style="width:100%; height:100%;"></td>
		</tr>
		<tr>
			<td>预付款项</td>
			<td id="xm">7</td>
			<td width="20"><input class="easyui-textbox" id="p_item7Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item7Qms"
				style="width:100%; height:100%;" ></td>
			<td>预收款项</td>
			<td>50</td>
			<td width="20"><input class="easyui-textbox" id="p_item50Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item50Qms"
				style="width:100%; height:100%;"></td>
		</tr>
		<tr>
			<td>应收利息</td>
			<td id="xm">8</td>
			<td width="20"><input class="easyui-textbox" id="p_item8Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item8Qms"
				style="width:100%; height:100%;"></td>
			<td>应付职工薪酬</td>
			<td>51</td>
			<td width="20"><input class="easyui-textbox" id="p_item51Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item51Qms"
				style="width:100%; height:100%;"></td>
		</tr>
		<tr>
			<td>应收股利</td>
			<td id="xm">9</td>
			<td width="20"><input class="easyui-textbox" id="p_item9Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item9Qms"
				style="width:100%; height:100%;" ></td>
			<td>应交税费</td>
			<td>52</td>
			<td width="20"><input class="easyui-textbox" id="p_item52Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item52Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>其他应收款</td>
			<td id="xm">10</td>
			<td width="20"><input class="easyui-textbox" id="p_item10Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item10Qms"
				style="width:100%; height:100%;" ></td>
			<td>应付利息</td>
			<td>53</td>
			<td width="20"><input class="easyui-textbox" id="p_item53Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item53Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>存货</td>
			<td id="xm">11</td>
			<td width="20"><input class="easyui-textbox" id="p_item11Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item11Qms"
				style="width:100%; height:100%;" ></td>
			<td>应付股利</td>
			<td>54</td>
			<td width="20"><input class="easyui-textbox" id="p_item54Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item54Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>划分为持有待售的资产</td>
			<td id="xm">12</td>
			<td width="20"><input class="easyui-textbox" id="p_item12Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item12Qms"
				style="width:100%; height:100%;" ></td>
			<td>其他应付款</td>
			<td>55</td>
			<td width="20"><input class="easyui-textbox" id="p_item55Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item55Qms"
				style="width:100%; height:100%;" ></td>
		</tr>




		<tr>
			<td>一年内到期的非流动资产</td>
			<td id="xm">13</td>
			<td width="20"><input class="easyui-textbox" id="p_item13Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item13Qms"
				style="width:100%; height:100%;" ></td>
			<td>划分为持有待售的负债</td>
			<td>56</td>
			<td width="20"><input class="easyui-textbox" id="p_item56Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item56Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>其他流动资产</td>
			<td id="xm">14</td>
			<td width="20"><input class="easyui-textbox" id="p_item14Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item14Qms"
				style="width:100%; height:100%;" ></td>
			<td>一年内到期的非流动负债</td>
			<td>57</td>
			<td width="20"><input class="easyui-textbox" id="p_item57Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item57Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>流动资产合计</td>
			<td id="xm">15</td>
			<td style="background-color:cyan" id="aaa"><input class="easyui-textbox" id="p_item15Qcs"
				style="width:100%;height:100%;"></td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item15Qms"
				style="width:100%;height:100%;"
				></td>
			<td>其他流动负债</td>
			<td>58</td>
			<td width="20"><input class="easyui-textbox" id="p_item58Qcs"
				style="width:100%; height:100%;"></td>
			<td width="20"><input class="easyui-textbox" id="p_item58Qms"
				style="width:100%;  height:100%;"></td>
		</tr>
		<tr>
			<td>非流动资产：</td>
			<td id="xm">16</td>
			<td width="20"><input class="easyui-textbox" id="p_item16Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item16Qms"
				style="width:100%; height:100%;" ></td>
			<td>流动负债合计</td>
			<td>59</td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item59Qcs"
				style="width:100%; height:100%;"
				></td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item59Qms"
				style="width:100%; height:100%;"
				></td>
		</tr>
		<tr>
			<td>可供出售金融资产</td>
			<td id="xm">17</td>
			<td width="20"><input class="easyui-textbox" id="p_item17Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item17Qms"
				style="width:100%; height:100%;" ></td>
			<td>非流动负债：</td>
			<td>60</td>
			<td width="20"><input class="easyui-textbox" id="p_item60Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item60Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>持有至到期投资</td>
			<td id="xm">18</td>
			<td width="20"><input class="easyui-textbox" id="p_item18Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item18Qms"
				style="width:100%; height:100%;" ></td>
			<td>长期借款</td>
			<td>61</td>
			<td width="20"><input class="easyui-textbox" id="p_item61Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item61Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>长期应收款</td>
			<td id="xm">19</td>
			<td width="20"><input class="easyui-textbox" id="p_item19Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item19Qms"
				style="width:100%; height:100%;" ></td>
			<td>应付债券</td>
			<td>62</td>
			<td width="20"><input class="easyui-textbox" id="p_item62Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item62Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>长期股权投资</td>
			<td id="xm">20</td>
			<td width="20px"><input class="easyui-textbox" id="p_item20Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item20Qms"
				style="width:100%; height:100%;" ></td>
			<td>其中：优先股</td>
			<td>63</td>
			<td width="20"><input class="easyui-textbox" id="p_item63Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item63Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>投资性房地产</td>
			<td id="xm">21</td>
			<td width="20"><input   class="easyui-textbox" id="p_item21Qcs"
				style="width:100%; height:100%;;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item21Qms"
				style="width:100%; height:100%;" ></td>
			<td>永续债</td>
			<td>64</td>
			<td width="20"><input   class="easyui-textbox" id="p_item64Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item64Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>固定资产</td>
			<td id="xm">22</td>
			<td width="20"><input   class="easyui-textbox" id="p_item22Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item22Qms"
				style="width:100%; height:100%;" ></td>
			<td>长期应付款</td>
			<td>65</td>
			<td width="20"><input   class="easyui-textbox" id="p_item65Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item65Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>在建工程</td>
			<td id="xm">23</td>
			<td width="20"><input   class="easyui-textbox" id="p_item23Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item23Qms"
				style="width:100%; height:100%;" ></td>
			<td>长期应付职工薪酬</td>
			<td>66</td>
			<td width="20"><input   class="easyui-textbox" id="p_item66Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item66Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>工程物资</td>
			<td id="xm">24</td>
			<td width="20"><input   class="easyui-textbox" id="p_item24Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item24Qms"
				style="width:100%; height:100%;" ></td>
			<td>专项应付款</td>
			<td>67</td>
			<td width="20"><input   class="easyui-textbox" id="p_item67Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item67Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>固定资产清理</td>
			<td id="xm">25</td>
			<td width="20"><input   class="easyui-textbox" id="p_item25Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item25Qms"
				style="width:100%; height:100%;" ></td>
			<td>预计负债</td>
			<td>68</td>
			<td width="20"><input   class="easyui-textbox" id="p_item68Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item68Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>生产性生物资产</td>
			<td id="xm">26</td>
			<td width="20"><input   class="easyui-textbox" id="p_item26Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item26Qms"
				style="width:100%; height:100%;" ></td>
			<td>递延收益</td>
			<td>69</td>
			<td width="20"><input   class="easyui-textbox" id="p_item69Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item69Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>油气资产</td>
			<td id="xm">27</td>
			<td width="20"><input   class="easyui-textbox" id="p_item27Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item27Qms"
				style="width:100%; height:100%;" ></td>
			<td>递延所得税负债</td>
			<td>70</td>
			<td width="20"><input   class="easyui-textbox" id="p_item70Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item70Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>无形资产</td>
			<td id="xm">28</td>
			<td width="20"><input class="easyui-textbox" id="p_item28Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input class="easyui-textbox" id="p_item28Qms"
				style="width:100%; height:100%;" ></td>
			<td>其他非流动负债</td>
			<td>71</td>
			<td width="20"><input  class="easyui-textbox" id="p_item71Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input  class="easyui-textbox" id="p_item71Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>开发支出</td>
			<td id="xm">29</td>
			<td width="20"><input  class="easyui-textbox" id="p_item29Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item29Qms"
				style="width:100%; height:100%;" ></td>
			<td>非流动负债合计</td>
			<td>72</td>
			<td style="background-color:cyan"><input   class="easyui-textbox" id="p_item72Qcs"
				style="width:100%;height:100%;"
				 ></td>
			<td style="background-color:cyan"><input   class="easyui-textbox" id="p_item72Qms"
				style="width:100%; height:100%;"
				></td>
		</tr>
		<tr>
			<td>商誉</td>
			<td id="xm">30</td>
			<td width="20"><input   class="easyui-textbox" id="p_item30Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item30Qms"
				style="width:100%; height:100%;" ></td>
			<td>负债合计</td>
			<td>73</td>
			<td style="background-color:cyan"><input   class="easyui-textbox" id="p_item73Qcs"
				style="width:100%;height:100%;"
				 ></td>
			<td style="background-color:cyan"><input   class="easyui-textbox" id="p_item73Qms"
				style="width:100%;  height:100%;"
				 ></td>
		</tr>
		<tr>
			<td>长期待摊费用</td>
			<td id="xm">31</td>
			<td width="20"><input   class="easyui-textbox" id="p_item31Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item31Qms"
				style="width:100%; height:100%;" ></td>
			<td>所有者权益(或股东权益)：</td>
			<td>74</td>
			<td width="20"><input   class="easyui-textbox" id="p_item74Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item74Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>递延所得税资产</td>
			<td id="xm">32</td>
			<td width="20"><input   class="easyui-textbox" id="p_item32Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item32Qms"
				style="width:100%; height:100%;" ></td>
			<td>实收资本(或股本)</td>
			<td>75</td>
			<td width="20"><input   class="easyui-textbox" id="p_item75Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item75Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>其他非流动资产</td>
			<td id="xm">33</td>
			<td width="20"><input   class="easyui-textbox" id="p_item33Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item33Qms"
				style="width:100%; height:100%;" ></td>
			<td>其他权益工具</td>
			<td>76</td>
			<td width="20"><input   class="easyui-textbox" id="p_item76Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item76Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td>非流动资产合计</td>
			<td id="xm">34</td>
			<td style=" background-color: cyan;"><input   class="easyui-textbox" id="p_item34Qcs"
				style="width:100%; height:100%;"
				></td>
			<td style="background-color: cyan;"><input   class="easyui-textbox" id="p_item34Qms"
				style="width:100%;  height:100%;"
				 ></td>
			<td>其中：优先股</td>
			<td>77</td>
			<td width="20"><input   class="easyui-textbox" id="p_item77Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item77Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td />
			<td id="xm">35</td>
			<td width="20"><input   class="easyui-textbox" id="p_item35Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item35Qms"
				style="width:100%; height:100%;" ></td>
			<td>永续债</td>
			<td>78</td>
			<td width="20"><input   class="easyui-textbox" id="p_item78Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item78Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td />
			<td id="xm">36</td>
			<td width="20"><input   class="easyui-textbox" id="p_item36Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item36Qms"
				style="width:100%; height:100%;" ></td>
			<td>资本公积</td>
			<td>79</td>
			<td width="20"><input   class="easyui-textbox" id="p_item79Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item79Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td />
			<td id="xm">37</td>
			<td width="20"><input   class="easyui-textbox" id="p_item37Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item37Qms"
				style="width:100%; height:100%;" ></td>
			<td>减：库存股</td>
			<td>80</td>
			<td width="20"><input   class="easyui-textbox" id="p_item80Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item80Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td></td>
			<td id="xm">38</td>
			<td width="20"><input   class="easyui-textbox" id="p_item38Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item38Qms"
				style="width:100%; height:100%;" ></td>
			<td>其他综合收益</td>
			<td>81</td>
			<td width="20"><input   class="easyui-textbox" id="p_item81Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item81Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td></td>
			<td id="xm">39</td>
			<td width="20"><input   class="easyui-textbox" id="p_item39Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item39Qms"
				style="width:100%; height:100%;" ></td>
			<td>专项储备</td>
			<td>82</td>
			<td width="20"><input   class="easyui-textbox" id="p_item82Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item82Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td></td>
			<td id="xm">40</td>
			<td width="20"><input   class="easyui-textbox" id="p_item40Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item40Qms"
				style="width:100%; height:100%;" ></td>
			<td>盈余公积</td>
			<td>83</td>
			<td width="20"><input   class="easyui-textbox" id="p_item83Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item83Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td></td>
			<td id="xm">41</td>
			<td width="20"><input   class="easyui-textbox" id="p_item41Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item41Qms"
				style="width:100%; height:100%;" ></td>
			<td>未分配利润</td>
			<td>84</td>
			<td width="20"><input   class="easyui-textbox" id="p_item84Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item84Qms"
				style="width:100%; height:100%;" ></td>
		</tr>
		<tr>
			<td></td>
			<td id="xm">42</td>
			<td width="20"><input   class="easyui-textbox" id="p_item42Qcs"
				style="width:100%; height:100%;" ></td>
			<td width="20"><input   class="easyui-textbox" id="p_item42Qms"
				style="width:100%; height:100%;" ></td>
			<td>所有者权益(或股东权益)合计</td>
			<td>85</td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item85Qcs"
				style="width:100%;height:100%;" ></td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item85Qms"
				style="width:100%;height:100%;"
				></td>
		</tr>
		<tr>
			<td>资产总计</td>
			<td id="xm">43</td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item43Qcs"
				style="width:100%;height:100%;"
				 ></td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item43Qms"
				style="width:100%; height:100%;"
				></td>
			<td>负债和所有者权益(或股东权益)总计</td>
			<td>86</td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item86Qcs"
				style="width:100%;height:100%;"  ></td>
			<td style="background-color:cyan"><input class="easyui-textbox" id="p_item86Qms"
				style="width:100%;height:100%;"></td>
		</tr>
		
	</table>
	<div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	</div>
	<script type="text/javascript" src="./zcfz.js"></script>  