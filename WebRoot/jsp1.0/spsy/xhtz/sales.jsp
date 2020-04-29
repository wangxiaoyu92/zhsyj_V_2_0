<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String qylb = StringHelper.showNull2Empty(request.getParameter("qylb"));
	String qledgerstockid = StringHelper.showNull2Empty(request.getParameter("qledgerstockid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>台账信息录入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var url = "";
	if ('<%=qylb%>' == 1) {
 		url = basePath + 'spsy/productin/querysckcDTO';//生产
	} else if ('<%=qylb%>' == 2) {
 		url = basePath + 'spsy/productin/querykcsyDTO';//流通
	}
 	if ($('#qledgerstockid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(url, {
			qledgerstockid : $('#qledgerstockid').val()
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('#fm').form('load', mydata);
				$('#lgprojyrq').val("");	
				$('#lgprojysl').val("");	
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
		}, 'json'); 
	} 
});
function selectcom(){
    var url = basePath + 'spsy/spproduct/selectcomIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择企业',
			param : {
				comgxlx : "2",
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
	},closeModalDialogCallback);	
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var v_retStr = sy.getWinRet(dialogID);
	if (v_retStr != null && v_retStr.length > 0) {
	    for (var k = 0;k <= v_retStr.length-1; k++){	    	
	      var myrow = v_retStr[k];
	      $("#lgtocommc").val(myrow.commc); // 公司名称   
	      $("#lgtocomzjhm").val(myrow.comzzzmbh); // 资质证明编号   
	      $("#lgprocjdz").val(myrow.comdz); // 企业地址  
	      $("#comfrhyz").val(myrow.comfrhyz); // 法人/业主 
	      $("#lgtocomid").val(myrow.csid); // 公司id 
	      $("#comyddh").val(myrow.comyddh); // 电话号码 
	    }      
    }
	sy.removeWinRet(dialogID);//不可缺少		
}
//保存
 var submitForm = function($dialog, $grid, $pjq) {
	$pjq.messager.progress();	// 显示进度条
	$('#fm').form('submit',{
		url:basePath + '/spsy/productin/savesales',
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
        },
        success: function(result){
        	$pjq.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$pjq.messager.alert('提示','保存成功！','info',function(){
        			$grid.datagrid('load');
        			$dialog.dialog('destroy');  
        		}); 	                        	                     
           	} else {
           		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
};
	 
// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
}

</script>
</head>
<body>
	<form id="fm" name="fm" method="post">
	  <input id="qledgerstockid" name="qledgerstockid" value="<%=qledgerstockid%>" type="hidden" />
       		<table class="table" style="width: 600px;"> 
				<tr>
					<td style="text-align:right;" ><nobr>商品名称:</nobr></td>
					<td><input id="lgproname" name="lgproname" style="width: 250px" 
						class="input_readonly" readonly="readonly"/>
					<input id="lgproid" name="lgproid" type="hidden" style="width: 250px"/></td>
					<td> 					
					</td>		
				</tr>	
				<tr>
					<td style="text-align:right;" ><nobr>商品条码:</nobr></td>
					<td><input id="lgprosptm" name="lgprosptm" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>	
					<td></td>		
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>生产日期:</nobr></td>
					<td><input name="lgproscrq" id="lgproscrq"
						class="input_readonly" readonly="readonly"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						style="width: 250px;"></td>		
					<td></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>保质期:</nobr></td>
					<td><input name="lgprobzq" id="lgprobzq" style="width: 250px;"
						class="input_readonly" readonly="readonly">
						<input id="lgprobzqdwcode" name="lgprobzqdwcode" type="hidden" /></td>
					<td><input id="lgprobzqdwmc" name="lgprobzqdwmc" style="border-style:none"/></td>			
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>规格:</nobr></td>
					<td><input name="lgprogg" id="lgprogg" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td><nobr>如260g</nobr></td>		
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>包装规格:</nobr></td>
					<td><input name="lgprobzgg" id="lgprobzgg" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>	
					<td><nobr>如1*20</nobr></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>生产厂家:</nobr></td>
					<td><input name="lgprosccj" id="lgprosccj" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td></td>			
				</tr>
				<!-- <tr>
					<td style="text-align:right;" ><nobr>产地/厂家地址:</nobr></td>
					<td><input name="lgprocjdz" id="lgprocjdz" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>	
					<td></td>		
				</tr> -->
				<tr>
					<td style="text-align:right;" ><nobr>商品批号批次:</nobr></td>
					<td><input name="lgpropc" id="lgpropc" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td></td>			
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>库存数量:</nobr></td>
					<td><input name=lgprosysl id="lgprosysl" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td><input id="lgprojydwmc2" name="lgprojydwmc2" style="border-style:none"/></td>		
				</tr>
				<!-- <tr>
					<td style="text-align:right;" ><nobr>供货商库存数量:</nobr></td>
					<td><input name="projysl" id="projysl" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>	
					<td style="text-align:left;" ></td>	
				</tr> -->
				<tr>
					<td width="25%" style="text-align:right;"><nobr>企业名称:</nobr></td>
					<td width="50%"><input id="lgtocommc" name="lgtocommc" style="width: 250px;" 
						class="input_readonly" readonly="readonly" data-options="required:true"/>
						<input id="lgtocomid" name="lgtocomid"  type="hidden"  /> </td>
					<td width="25%"> <a id="btnselectpro" href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="selectcom()">选择企业 </a>					
					</td>						
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>企业资质证明编号:</nobr></td>
					<td><input id="lgtocomzjhm" name="lgtocomzjhm" style="width: 250px"
						 class="input_readonly" readonly="readonly"/></td>	
					 <td></td>						
				</tr>
				 <tr>
					<td style="text-align:right;"><nobr>企业法定代表人:</nobr></td>
					<td><input id="comfrhyz" name="comfrhyz" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>企业电话:</nobr></td>
					<td><input id="comyddh" name="comyddh" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>企业地址:</nobr></td>
					<td><input id="lgprocjdz" name="lgprocjdz" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr> 
				<tr>
					<td style="text-align:right;" ><nobr>销货日期:</nobr></td>
					<td><input name="lgprojyrq" id="lgprojyrq"  class="Wdate easyui-validatebox"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 250px;" data-options="required:true" ></td>	
					<td></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>销货数量:</nobr></td>
					<td><input name="lgprojysl" id="lgprojysl" style="width: 250px;" 
						class="easyui-validatebox" data-options="required:true" >
						<input id="lgprojydwcode" name="lgprojydwcode" type="hidden"/></td>	
					<td><input id="lgprojydwmc" name="lgprojydwmc" style="border-style:none"/></td>	
				</tr>
				<tr>						
					<td style="text-align:right;">商品溯源码:</td>
					<td>
						<textarea id="lgprocode" name="lgprocode" style="width: 250px;" 
						 rows="5"></textarea>
					</td>
					<td style="text-align:left;">如有多个，请以逗号隔开</td>			
				</tr> 								
			</table>
   </form>
</body>
</html>