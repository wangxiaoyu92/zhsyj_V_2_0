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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	// 任务id
	String v_taskid = StringHelper.showNull2Empty(request.getParameter("taskid"));
	// 计划id
	String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>任务信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		if ($('#taskid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'supervision/queryTaskObj', {
				taskid : $('#taskid').val()
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
				loadSupervisionCompany($('#taskid').val()); // 加载检查企业
				loadSupervisionPerson($('#taskid').val()); // 加载检查人员
			}
		}
	});

	// 保存 
	var submitForm = function() {
		// 判断任务开始时间与结束时间是否填写正确
		var startDate = $("#tasktimest").val();
		var endDate = $("#tasktimeed").val();
		if(startDate.length > 0 && endDate.length > 0){   
        	var startDateTemp = startDate.split(" ");   
      		var endDateTemp = endDate.split(" ");   
      		var arrStartDate = startDateTemp[0].split("-");   
      		var arrEndDate = endDateTemp[0].split("-");   
      		var arrStartTime = startDateTemp[1].split(":");   
      		var arrEndTime = endDateTemp[1].split(":");   
      		var allStartDate = new Date(arrStartDate[0],arrStartDate[1],arrStartDate[2],
      				arrStartTime[0],arrStartTime[1],arrStartTime[2]);   
      		var allEndDate = new Date(arrEndDate[0],arrEndDate[1],arrEndDate[2],arrEndTime[0],
      				arrEndTime[1],arrEndTime[2]);   
      		if(allStartDate.getTime() > allEndDate.getTime()){   
      			alert("请正确填写任务日期");
       			return;   
      		}
      	}
		var url = basePath + 'supervision/saveTask';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#taskfm').form('submit',{
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
						var obj = new Object();
						obj.type = "ok";   //设为空不刷新父页面
						sy.setWinRet(obj);
						parent.$("#"+sy.getDialogId()).dialog("close");
	        		});
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};
	// 加载检查企业
	function loadSupervisionCompany(v_taskid) {
		$("#comgrid").datagrid({
			title :'检查公司',
			url : basePath+'supervision/querySupervisionCompany',
			queryParams: {
				taskid : v_taskid
			},
			striped : true, //奇偶行使用不同的颜色
			singleSelect : true, // 只允许选择一行
			checkOnSelect : false, //当用户点击行的时候就选中
			selectOnCheck : false,  //单击复选框将选择行
			pagination : false, //底部显示分页栏
			pageSize : 10,  //每页显示的页数
			pageList : [10,20,30],  //每页显示的页数（供选择）
			rownumbers : true,  //是否显示行号
			fitColumns :false,  //列自适应宽度  防止滚动
			idField : 'taskdetailid',  //该列是一个唯一列 也是数据库中的表的主键
			sortOrder : 'asc',  //按升序排序
			columns :[[
				{
					title : '任务明细ID',
					field : 'taskdetailid',
					width : 50,
					hidden : true
				},{
					title : '任务id',
					field : 'taskid',
					width : 50,
					editor : 'textarea',
					hidden:true
				},{
					title : '公司id',
					field : 'comid',
					width : 50,
					hidden:true
				},{
					title : '公司名称',
					field : 'commc',
					width : 150,
					hidden: false
				},{
					title : '公司地址',
					field : 'comdz',
					width : 250,
					hidden: false
				}
			]]
		});
	}
	// 加载检查人员
	function loadSupervisionPerson(v_taskid) {
		$("#rygrid").datagrid({
			title :'检查人员',
			url : basePath+'supervision/querySupervisionPerson',
			queryParams: {
				taskid : v_taskid
			},
			striped : true, // 奇偶行使用不同的颜色
			singleSelect : true, // 只允许选择一行
			checkOnSelect : false, // 当用户点击行的时候就选中
			selectOnCheck : false,  // 单击复选框将选择行
			pagination : false, // 底部显示分页栏
			pageSize : 10,  // 每页显示的页数
			pageList : [10,20,30],  // 每页显示的页数（供选择）
			rownumbers : true,  // 是否显示行号
			fitColumns :false,  // 列自适应宽度  防止滚动
			idField : 'id',  // 该列是一个唯一列 也是数据库中的表的主键
			sortOrder : 'asc',  // 按升序排序
			columns :[[
				{
					title : '检查任务人员表ID',
					field : 'id ',
					width : 50,
					hidden : true
				},{
					title : '任务id',
					field : 'taskid',
					width : 50,
					editor : 'textarea',
					hidden: true
				},{
					title : '人员ID',
					field : 'userid',
					width : 50,
					hidden:true
				},{
					title : '姓名',
					field : 'description',
					align : 'center',
					width : 130,
					hidden: false
				},{
					title : '所属机构id',
					field : 'orgid',
					align : 'center',
					width : 150,
					hidden: true
				},{
					title : '所属部门',
					field : 'bmmc',
					align : 'center',
					width : 280,
					hidden:false
				}
			]]
		});		
	}

	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
    <div region="center" style="overflow: true;" border="false" >
		<form id="taskfm" name="taskfm" method="post">
		  <input id="taskid" name="taskid" type="hidden" value="<%=v_taskid%>"/>
		  <input id="planid" name="planid" type="hidden" value="<%=v_planid%>"/>
	       		<table class="table" style="width: 600px;">
	       		   <tr>
	       		     <td width="30%"></td>
	       		     <td width="70%"></td>
	       		   </tr>
					<tr>
						<td style="text-align:right;"><nobr>任务名称:</nobr></td>
						<td ><input id="taskname" name="taskname" style="width: 400px;"/></td>						
					</tr>
					
					<tr>
						<td style="text-align:right;"><nobr>任务描述:</nobr></td>
						<td >
							<textarea class="easyui-validatebox" id="taskremark" name="taskremark" style="width: 400px;" 
						 	 rows="5" data-options="required:false,validType:'length[0,400]'"></textarea>
						</td>		
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>任务开始时间:</nobr></td>
						<td><input id="tasktimest" name="tasktimest" class="Wdate" style="width: 400px;"
								onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>任务结束时间:</nobr></td>
						<td><input id="tasktimeed" name="tasktimeed" class="Wdate" style="width: 400px;"
								onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
					</tr>
					<% if("view".equalsIgnoreCase(op)){%>
					<tr>		
						<td style="text-align:right;"><nobr>经办人:</nobr></td>
						<td><input id="aaa011" name="aaa011" style="width: 400px"/></td>						
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>经办时间:</nobr></td>
						<td><input id="aae036" name="aae036" style="width: 400px"/></td>			
					</tr>
					<%} %>
				</table>
	   </form>
   </div>
   <% if("view".equalsIgnoreCase(op)){%>
   	<table>
		<tr>
			<td>
				<table id="comgrid" style="height:300px;width:400px;"></table>
			</td>
			<td>
				<table id="rygrid" style="height:300px;width:400px;"></table>
			</td>
		</tr>
	</table>
   <%} %>
	<div region="center" style="overflow: true;" border="false" >
	  	<div style="height:30px;float:right;" >
           	<% if(!"view".equalsIgnoreCase(op)){%>
				<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-save" onclick="javascript:submitForm()"> 保存 </a>	
						&nbsp;&nbsp;&nbsp;&nbsp;
			<%} %>
            <a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-back" onclick="closeWindow()">关闭</a>
	    </div>
	</div>
</body>
</html>