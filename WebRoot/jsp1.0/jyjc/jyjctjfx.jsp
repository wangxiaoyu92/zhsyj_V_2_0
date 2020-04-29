<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
  <head>
   <title>检验检测统计分析</title>
   <jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
     <script type="text/javascript">
     var grid;
             
     //查询
     var query=function () {
	     if($('#kssj').val() > $('#jssj').val()){
	        $.messager.alert('提示','开始日期不能大于结束日期！');
	        return;
	     }
		 var param = {
			'comdm': $('#comdm').val(),
			'jcjylb':$('#jcjylb').val(), 
			'kssj':$('#kssj').val() ,
			'jssj':$('#jssj').val() 
		 }; 	
		 if($('#jcjylb').val()=='jcypmc'){
	        grid=$("#grid").datagrid({
				//title: '检验检测项目',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				url: basePath + 'jyjc/queryJyjctjfx',
				queryParams : param,
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,			
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度			
			    idField: 'jcjgid', //该列是一个唯一列
			    sortOrder: 'asc',
			     frozenColumns :[[ {
					width : '100',
					title : '样品名称',
					field : 'ypmc',
					hidden : false
				},{
					width : '150',
					title : '检查次数',
					field : 'jccs',
					hidden : false
				},{
					width : '150',
					title : '合格次数',
					field : 'hgcs',
					hidden : false
				},{
					width : '150',
					title : '超标次数',
					field : 'cbcs',
					hidden : false
				},{
					width : '150',
					title : '合格率',
					field : 'hgl',
					hidden : false
				},{
					width : '150',
					title : '超标率',
					field : 'cbl',
					hidden : false
				}] ]
			    
			 })
		  }else if($('#jcjylb').val()=='jcxmmc'){
		       grid=$("#grid").datagrid({
				//title: '检验检测项目',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				url: basePath + 'jyjc/queryJyjctjfx',
				queryParams : param,
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,			
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度			
			    idField: 'jcjgid', //该列是一个唯一列
			    sortOrder: 'asc',
			     frozenColumns :[[{
					width : '100',
					title : '项目名称',
					field : 'jcxmmc',
					hidden : false
				},{
					width : '150',
					title : '检查次数',
					field : 'jccs',
					hidden : false
				},{
					width : '150',
					title : '合格次数',
					field : 'hgcs',
					hidden : false
				},{
					width : '150',
					title : '超标次数',
					field : 'cbcs',
					hidden : false
				},{
					width : '150',
					title : '合格率',
					field : 'hgl',
					hidden : false
				},{
					width : '150',
					title : '超标率',
					field : 'cbl',
					hidden : false
				}] ]
			    
			 })
		  }
	};
     //重置
     var refresh=function(){
         parent.window.refresh();
     } 
     //从单位信息表中读取
	function myselectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		comjyjcbz : "1"
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		 var myrow=obj[k];
	      $("#commc").val(myrow.commc); //公司名称   
	      $("#comid").val(myrow.comid); //公司代码     
	 }
	}
	sy.removeWinRet(dialogID);//不可缺少	
	})
	}
     </script>
  </head>
  <body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
					    <td style="text-align:right;"><nobr>选择类别</nobr></td>
						<td> 
						    <select style="width: 200px;height:25px" id="jcjylb">
                               <option value ="jcypmc">样品种类</option>
                               <option value ="jcxmmc">项目种类</option> 
                            </select>
						</td>					
					    <td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comid" name="comid" style="width: 200px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td> 					
					</tr>
					<tr>  
					 <td colspan="2">
					       从<input id="kssj" name="kssj"  value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'kssj\')}'})" class="Wdate bbinput" readonly="readonly"/>
					       到<input id="jssj" name="jssj"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'jssj\')}'})" class="Wdate bbinput" readonly="readonly"/>
					  </td>	
					    <td colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr> 
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检测结果信息">
	        	 
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div> 
  </body>
</html>