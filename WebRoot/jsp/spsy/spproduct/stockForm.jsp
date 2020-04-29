<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_qledgerstockid = StringHelper.showNull2Empty(request.getParameter("qledgerstockid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>台账信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);
//生产单位代码
var v_scdwdm = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>;

$(function() {

	$('#jhsldw').combobox({
    	data : v_scdwdm,
        valueField : 'id',
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto',
        onSelect: function(data){
        	$("#lgprojydwmc").val(data.text); // 交易商品单位名称
        }
    });
	if ($('#qledgerstockid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/spsy/spproduct/queryStockDTO', {
			qledgerstockid : $('#qledgerstockid').val()
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('form').form('load', mydata);			
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
               }	
			parent.$.messager.progress('close');
		}, 'json');

		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
			$('.Wdate').attr('disabled',true);	
			$("#submitFormButton").hide();
		}
	}
	$("#jhsldwtd").hide(); // 进货数量单位   
	$("#jhsldwmc").show(); 
		
});

	// 保存 
	var submitForm = function() {
		var scrq = $("#lgproscrq").val();
		if (scrq == '' || scrq == null || scrq.length == 0) {
			alert("请输入产品生产日期！");
			return;
		}
		var url = basePath + '/spsy/spproduct/saveStock';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#stockAddDlgfm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 sy.setWinRet(s);
						 closeWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

// 选择批发商
function myselectcom(){
    var url = basePath + 'spsy/spproduct/selectcomIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择批发商',
			param : {
				comgxlx : "1", // 公司供销类型. 1:供货商；2:销货商
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},closeModalDialogCallback);
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var v_retStr = sy.getWinRet(dialogID);
	if (v_retStr != null && v_retStr.length > 0) {
	    for (var k = 0;k <= v_retStr.length-1; k++){
	      var myrow = v_retStr[k];
	      $("#commc").val(myrow.commc); // 公司名称   
	      $("#comzzzmbh").val(myrow.comzzzmbh); // 资质证明编号   
	      $("#comdz").val(myrow.comdz); // 企业地址 
	      $("#comfrhyz").val(myrow.comfrhyz); // 法人/业主 
	      $("#lgfromcomid").val(myrow.csid); // 公司id 
	      $("#comyddh").val(myrow.comyddh); // 电话号码 
	      $("#lgcomfwnfww").val(myrow.comfwnfww); // 公司范围内范围外类型  jhsldw
	      var nwlx = myrow.comfwnfww; 
	      if (nwlx == 1) { // 如果是范围外企业，交易类型为范围外交易
		  	  $("#lgjylx").val(2);
	      	  $("#ghscsl").hide(); // 供货商生产数量隐藏
	      	  $("#jhsldwtd").show(); // 进货数量单位
	      	  $("#jhsldwmc").hide(); 
	      	  $("#lgpropc").removeAttr("class", "input_readonly");
	    	  $("#lgpropc").removeAttr("readonly", "readonly");
	      } else {
	    	  $("#lgjylx").val(1);
	    	  $("#ghscsl").show(); // 供货商生产数量隐藏
	    	  $("#jhsldwtd").hide(); // 进货数量单位
	    	  $("#jhsldwmc").show(); 
	    	  $("#lgpropc").attr("class", "input_readonly");
	    	  $("#lgpropc").attr("readonly", "readonly");
	      }
	    }      
    }
	sy.removeWinRet(dialogID);//不可缺少		
}
// 选择商品
function myselectpro(){
	var comid = $("#lgfromcomid").val();
	if (comid == "" || comid == null || comid.length == 0) {
		alert("请先选择进货商！！！");
		return;
	}
    var url = basePath + 'jsp/spsy/spproduct/selectProduct.jsp';
	var dialog = parent.sy.modalDialog({
			title : '选择商品',
			param : {
				comid : comid,
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},closeModalDialogCallback2);	
}
// 窗口关闭回掉函数
function closeModalDialogCallback2(dialogID){		
	var v_retStr = sy.getWinRet(dialogID);
	if (v_retStr != null && v_retStr.length > 0) {
    	for (var k=0;k<=v_retStr.length-1;k++){
	      	var myrow = v_retStr[k];
	      	$("#lgproid").val(myrow.proid); // 商品id   
	      	$("#lgproname").val(myrow.proname); // 商品名称
	      	$("#lgprosptm").val(myrow.prosptm); // 商品条码
	      	$("#lgproscrq").val(myrow.cppcscrq); // 生产日期
	      	$("#lgprobzq").val(myrow.probzq); // 保质期
	      	$("#lgprobzqdwcode").val(myrow.probzqdwcode); // 保质期单位id
	      	$("#lgprobzqdwmc").val(myrow.probzqdwmc); // 保质期单位名称
	      	$("#lgprogg").val(myrow.progg); // 商品规格
	      	$("#lgprobzgg").val(myrow.probzgg); // 商品包装规格
	      	$("#lgprosccj").val(myrow.prosccj); // 商品生产厂家
	      	$("#lgprocjdz").val(myrow.procdjd); // 产地/厂家地址 
	      	$("#lgpropc").val(myrow.cppcpch); // 商品批次号 proghsl
	      	$("#proghsl").val(myrow.cppcscsl); // 供货商生产数量
	      	$("#lgprojydwcode").val(myrow.cppcscdwdm); // 交易商品单位
	      	$("#lgprojydwmc").val(myrow.cppcscdwdmstr); // 交易商品单位名称
	      	$("#lgprojydwmc2").val(myrow.cppcscdwdmstr); // 供货商生产单位
	      	$("#sphyclid").val(myrow.cphyclid); // 商品或原材料id
    	}
    }
	sy.removeWinRet(dialogID);//不可缺少		
}
// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
}

</script>
</head>
<body>
	<form id="stockAddDlgfm" name="stockAddDlgfm" method="post">
		<input id="qledgerstockid" name="qledgerstockid" type="hidden" value="<%=v_qledgerstockid%>"/>
       	<table class="table" style="width: 600px;">
       		<tr>
       			<td width="25%"></td>
       		    <td width="50%"></td>
       		    <td width="25%"></td>
		   	</tr>
			<tr>
				<td style="text-align:right;"><nobr>批发商名称:</nobr></td>
				<td><input id="commc" name="commc" style="width: 250px;"
						class="input_readonly" readonly="readonly"/>
					<input id="lgfromcomid" name="lgfromcomid" type="hidden"/></td>
				<td><% if(!"view".equalsIgnoreCase(op)){ %>
					<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myselectcom()">选择批发商 </a>
					<%} %>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>批发商资质证明编号:</nobr></td>
				<td><input id="comzzzmbh" name="comzzzmbh" style="width: 250px"
						 class="input_readonly" readonly="readonly"/></td>	
			 	<td></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>批发商法定代表人:</nobr></td>
				<td><input id="comfrhyz" name="comfrhyz" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
				<td></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>批发商电话:</nobr></td>
				<td><input id="comyddh" name="comyddh" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
				<td></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>批发商地址:</nobr></td>
				<td><input id="comdz" name="comdz" style="width: 250px"
					class="input_readonly" readonly="readonly"/></td>
				<td><input id="lgcomfwnfww" name="lgcomfwnfww" type="hidden"/></td>
			</tr>
			<tr>
				<td style="text-align:right;" ><nobr>商品名称:</nobr></td>
				<td><input id="lgproname" name="lgproname" style="width: 250px"
						class="input_readonly" readonly="readonly"/>
					<input id="lgproid" name="lgproid" type="hidden"/></td>
				<td><% if(!"view".equalsIgnoreCase(op)){ %>
						<a id="btnselectpro" href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="myselectpro()">选择商品 </a>	
							<%} %>						
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
					class="easyui-validatebox" data-options="required:true"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 250px;"></td>
				<td></td>
			</tr>
			<tr>
				<td style="text-align:right;" ><nobr>保质期:</nobr></td>
				<td><input name="lgprobzq" id="lgprobzq" style="width: 250px;"
					class="input_readonly" readonly="readonly">
					<input id="lgprobzqdwcode" name="lgprobzqdwcode" type="hidden" /></td>
				<td><input id="lgprobzqdwmc" name="lgprobzqdwmc" style="border-style:none" readonly/></td>
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
			<tr>
				<td style="text-align:right;" ><nobr>产地/厂家地址:</nobr></td>
				<td><input name="lgprocjdz" id="lgprocjdz" style="width: 250px;"
					class="input_readonly" readonly="readonly"></td>
				<td><input id="lgjylx" name="lgjylx" type="hidden"/></td>
			</tr>
			<tr>
				<td style="text-align:right;" ><nobr>商品批号批次:</nobr></td>
				<td><input name="lgpropc" id="lgpropc" style="width: 250px;"
					class="input_readonly" readonly="readonly"/></td>
				<td></td>
			</tr>
			<tr id="ghscsl">
				<td style="text-align:right;" ><nobr>供货生产数量:</nobr></td>
				<td><input name="proghsl" id="proghsl" style="width: 250px;"
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
				<td style="text-align:right;" ><nobr>进货日期:</nobr></td>
				<td><input name="lgprojyrq" id="lgprojyrq"  class="Wdate easyui-validatebox"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 250px;" data-options="required:true" ></td>
				<td><input id="sphyclid" name="sphyclid" type="hidden"/></td>
			</tr>
			<tr>
				<td style="text-align:right;" ><nobr>进货数量:</nobr></td>
				<td><input name="lgprojysl" id="lgprojysl" style="width: 250px;"
					class="easyui-validatebox" data-options="required:true" validtype="number">
					<input id="lgprojydwcode" name="lgprojydwcode" type="hidden"/></td>
				<td id="jhsldwmc"><input id="lgprojydwmc" name="lgprojydwmc" style="border-style:none"/></td>
				<td id="jhsldwtd"><input id="jhsldw" name="jhsldw"
					class="easyui-combobox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td style="text-align:right;">商品溯源码:</td>
				<td>
					<textarea id="lgprocode" name="lgprocode" style="width: 250px;"
					 rows="5"></textarea>
				</td>
				<td style="text-align:left;">如有多个，请以逗号隔开</td>
			</tr>
			<tr>
			  <td colspan="3" style="height: 50px;" >
				<div align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton" id="submitFormButton"
							iconCls="icon-save" onclick="submitForm()"> 保存 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-back" onclick="closeWindow()"> 取消 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			  </td>
			</tr>
		</table>
   	</form>
</body>
</html>