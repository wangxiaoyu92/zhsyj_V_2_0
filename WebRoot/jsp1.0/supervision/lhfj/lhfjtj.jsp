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

	
%>
<!DOCTYPE html>
<html>
<head>

<title>量化分级统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
// 企业大类
var v_niandulist = <%=SysmanageUtil.getcheckyearlist()%>;
//量化分级年度评定等级
var v_LHFJNDPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;
	
var v_bndsfpddj=[{"id":"","text":"==请选择=="},{"id":0,"text":"否"},{"id":1,"text":"是"}];

$(function() {
	
		//年度列表
		$('#checkyear').combobox({
			data:v_niandulist,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		//年度是否评定等级
		$('#bndsfpddj').combobox({
			data:v_bndsfpddj,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});		
	
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			fit:true,
			toolbar: '#toolbar',
			//url: basePath + '/lhfj/queryLhfjtj',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 500,
			pageList : [ 500, 1000, 1500 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: '', //该列是一个唯一列
		    nowrap:false,	
		    onClickRow:function(rowIndex, rowData){
		    },
			columns : [ [
	        {
				width : '100',
				title : '企业ID',
				field : 'comid',
				hidden : false,
				checkbox:true
			},{
				width : '100',
				title : '年度',
				field : 'checkyear',
				hidden : false
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '100',
				title : '企业大类',
				field : 'comdaleistr',  
				hidden : false
			},{
				width : '110', 
				title : '上年度评定等级',
				field : 'sndpddj',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_LHFJNDPDDJ,value);  
				}					
			},{
				width : '110',
				title : '本年度评定等级',
				field : 'bndpddj',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_LHFJNDPDDJ,value);  
				}					
			},{
				width : '120',
				title : '本年度是否评定等级',
				field : 'bndsfpddj',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_bndsfpddj,value);  
				}					
			},{
				width : '150',
				title : '本年度评定等级预判',
				field : 'bndpddjyp',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_LHFJNDPDDJ,value);  
				}				
			},{
				width : '150',
				title : '检查完成的年度总分',
				field : 'checkoverndavgscoresum',
				hidden : false
			},{
				width : '150',
				title : '检查完成的年度平均分',
				field : 'checkoverndavgscore',
				hidden : false
			},{
				width : '80',
				title : '检查总次数',
				field : 'checkcountsum',
				hidden : false
			},{
				width : '80',
				title : '完成次数',
				field : 'checkovercount',
				hidden : false
			} ,{
				width : '80',
				title : '未完成次数',
				field : 'checknoovercount',
				hidden : false
			} ,{
				width : '80',
				title : '符合次数',
				field : 'checkfhcount',
				hidden : false
			},{
				width : '80',
				title : '不符合次数',
				field : 'checkbfhcount',
				hidden : false
			},{
				width : '120',
				title : '限期整改次数',
				field : 'checkxqzgcount',
				hidden : false
			},{
				width : '210',
				title : '根据年度等级判断本年度应检查次数',
				field : 'lhfjpdndyjccs',
				hidden : false
			},{
				width : '170',
				title : '根据等级判定还应检查次数',
				field : 'hyjccs',
				hidden : false
			} 
			] ],
			toolbar: '#toolbar'
		});
});
	
	function query() {
		var param = {
			'comid': $('#comid').val(),
			'commc': $('#commc').val(),
			'checkyear':$('#checkyear').combobox('getValue'),
			'checkcountsumstart':$('#checkcountsumstart').val(),
			'checkcountsumend':$('#checkcountsumend').val(),
			
			'checkovercountstart':$('#checkovercountstart').val(),
			'checkovercountend':$('#checkovercountend').val(),
			
			'checknoovercountstart':$('#checknoovercountstart').val(),
			'checknoovercountend':$('#checknoovercountend').val(),
			
			'checkfhcountstart':$('#checkfhcountstart').val(),
			'checkfhcountend':$('#checkfhcountend').val(),
			
			'checkbfhcountstart':$('#checkbfhcountstart').val(),
			'checkbfhcountend':$('#checkbfhcountend').val(),
			
			'checkxqzgcountstart':$('#checkxqzgcountstart').val(),
			'checkxqzgcountend':$('#checkxqzgcountend').val(),
			
			'lhfjpdndyjccsstart':$('#lhfjpdndyjccsstart').val(),
			'lhfjpdndyjccsend':$('#lhfjpdndyjccsend').val(),
			
			'hyjccsstart':$('#hyjccsstart').val(),
			'hyjccsend':$('#hyjccsend').val(),
			'bndsfpddj':$('#bndsfpddj').combobox('getValue')
			
		};
		mygrid.datagrid({
			url : basePath + '/lhfj/queryLhfjtj',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections'); 
	}

	//从单位信息表中读取
	function myselectcom(){
	    var url = basePath + 'pub/pub/selectcomIndex';
		var dialog = parent.sy.modalDialog({
				title : '选择企业',
				param : {
					singleSelect : "true"
				},
				width : 800,
				height : 600,
				url : url
		},function(dialogID) {
			var v_retStr = sy.getWinRet(dialogID);
			if (v_retStr!=null && v_retStr.length>0){
			    for (var k=0;k<=v_retStr.length-1;k++){
			      var myrow=v_retStr[k];
			      $("#commc").val(myrow.commc); //公司名称   
			      $("#comid").val(myrow.comid); //公司代码         
			    }
			}
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 	
	
	//查看结果明细
	var viewCheckDetail = function() {
	var row = $("#mygrid").datagrid('getSelected');
	var v_dokind="lhfjtj";
	if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				param : {
					dokind : v_dokind,
					checkyear : row.checkyear,
					comid : row.comid
				},
				width :1140,
			    height :560,
				url : basePath + 'jsp/supervision/lhfj/lhfjcx.jsp',
				buttons : [ 
				{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
		    $.messager.alert('提示','请先选择要查看的记录！','info');
		}
	};
	
	/**
	 * 自动生成年度等级
	 */
	function autoCreateNddj(prm_pdjgscfs){//评定结果生产方式0自动1手动
		$.messager.confirm("确认", "确定要生成所选单位的年度等级信息吗？", function (data){
			if (data){
				var v_mycheckedrow = $("#mygrid").datagrid("getChecked");
				if (!v_mycheckedrow){
					$.messager.alert("提示", "请先选择要处理的记录！", "info");
					return false;
				};
				var v_lhfjndpddj='';
			    var v_sfcxsc='';//0不重新生成1重新生成
				var v_url=basePath+"jsp/supervision/lhfj/lhfjqueren.jsp";
				var dialog = parent.sy.modalDialog({
						title : '选择结果',
						param : {
							caozuokind : prm_pdjgscfs,
							time : new Date().getMilliseconds()
						},
						width : 300,
						height : 250,
						url : v_url
				},function(dialogID) {
					var obj = sy.getWinRet(dialogID);
					if (obj != null) {
						v_lhfjndpddj = obj.lhfjndpddj;
						v_sfcxsc = obj.sfcxsc;
						$("#myLhfjtjGridchecked").val($.toJSON(v_mycheckedrow));
					    var url= basePath+"/lhfj/saveCreateNddj?pdjgscfs="+prm_pdjgscfs+
					    		"&lhfjndpddj="+v_lhfjndpddj+"&sfcxsc="+v_sfcxsc+
					    		"&time="+new Date().getMilliseconds();
						parent.$.messager.progress({text : '正在提交....'});	// 显示进度条
						
						$('#myqueryfm').form('submit',{
							url: url,
							onSubmit: function(){ 
								// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
								var isValid = $(this).form('validate'); 
								if(!isValid){
									// 如果表单是无效的则隐藏进度条
									parent.$.messager.progress('close');	 
								}					
								return isValid;
					        },
					        success: function(result){
					        	parent.$.messager.progress('close');// 隐藏进度条  
					        	result = $.parseJSON(result);  
							 	if (result.code=='0'){
							 		$('#mygrid').datagrid('reload');
							 		alert("生成成功！");
				              	} else {
				              		alert("生成失败：" + result.msg);
				                }
					        }    
						});
						sy.removeWinRet(dialogID);//不可缺少
					} else{
						return false;
					}
				});
			};
		});
	}
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true" style="border: none">  
        <div region="north"  style="height:120px;overflow: false;border: none">
        	<form id="myqueryfm" method="post" >
        	    <input type="hidden" id="myLhfjtjGridchecked" name="myLhfjtjGridchecked"> 
        		<table class="table" style="width: 99%;">
        		    <tr>
						<td style="text-align:right;"><nobr>年度</nobr></td>
						<td><input id="checkyear" name="checkyear" style="width: 100px" /></td>        		    
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td colspan="3">
						    <input type="hidden" id="comid" name="comid"/>
						    <input id="commc" name="commc" style="width:300px" />
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>	
						<td>本年度是否评定等级</td>
						<td><input id="bndsfpddj" name="bndsfpddj" style="width:100px" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>检查总次数</nobr></td>
						<td><input id="checkcountsumstart" name="checkcountsumstart" style="width:40px" class="easyui-validatebox"  data-options="validType:['integer']" />
						~<input id="checkcountsumend" name="checkcountsumend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td> 
						<td style="text-align:right;"><nobr>完成次数</nobr></td>
						<td><input id="checkovercountstart" name="checkovercountstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="checkovercountend" name="checkovercountend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td>
						<td style="text-align:right;"><nobr>未完成次数</nobr></td>
						<td><input id="checknoovercountstart" name="checknoovercountstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="checknoovercountend" name="checknoovercountend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td>
						<td style="text-align:right;"><nobr>符合次数</nobr></td>
						<td><input id="checkfhcountstart" name="checkfhcountstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="checkfhcountend" name="checkfhcountend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td> 							 						 
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>不符合次数</nobr></td>
						<td><input id="checkbfhcountstart" name="checkbfhcountstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="checkbfhcountend" name="checkbfhcountend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td> 
						<td style="text-align:right;"><nobr>限期整改次数</nobr></td>
						<td><input id="checkxqzgcountstart" name="checkxqzgcountstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="checkxqzgcountend" name="checkxqzgcountend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td>
						<td style="text-align:right;"><nobr>本年度应检查次数</nobr></td>
						<td><input id="lhfjpdndyjccsstart" name="lhfjpdndyjccsstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="lhfjpdndyjccsend" name="lhfjpdndyjccsend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td>
						<td style="text-align:right;"><nobr>还应检查次数</nobr></td>
						<td><input id="hyjccsstart" name="hyjccsstart" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						~<input id="hyjccsend" name="hyjccsend" style="width:40px"  class="easyui-validatebox"  data-options="validType:['integer']"/>
						</td> 							 						 
					</tr>					
					<tr>
						<td style="text-align:center;" colspan="8">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>													
					</tr>
				</table>
				</form> 
        </div>
        <div region="center" style="overflow: false;border: none">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_viewResult"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewCheckDetail()">查看明细</a> 
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveCreateNddj"
								iconCls="ext-icon-computer" plain="true" onclick="autoCreateNddj('0')">自动生成年度等级</a> 
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveCreateNddj"
								iconCls="ext-icon-folder_user" plain="true" onclick="autoCreateNddj('1')">手动生成年度等级</a> 
							</td>
						</tr>
					</table>
			</div>
			<div id="mygrid" ></div>
        </div>
                
    </div>   
</body>
</html>