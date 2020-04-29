<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    String v_hjyjczbid=StringHelper.showNull2Empty(request.getParameter("hjyjczbid")); //进出库表主键
    String v_hjhbid=StringHelper.showNull2Empty(request.getParameter("hjhbid")); //进货表主键
	String v_title="检测信息管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="检测信息 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="检测信息 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="检测信息 查看";
	}
	Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
	String v_aaz001=vSysUser.getAaz001();	
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %>></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//检验检测项目
	var v_jyjcxm = <%=SysmanageUtil.getComboJyjcxm()%>;
	//检测值数值单位
	var v_szdw = <%=SysmanageUtil.getAa10toJsonArray("SZDW")%>;
	
	//检验检测结论
	var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;	
	//检验检测限量标准
	var v_xlbz = <%=SysmanageUtil.getAa10toJsonArray("XLBZ")%>;		
	//jcjylb 检验检测类别
	var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
	
	var v_local_hjhbid="<%=v_hjhbid%>";
    var v_jcmx_grid;
	$(function() {	
		// 检验检测类别
		 $('#jcjylb').combobox({
			data:v_jcjylb,
			valueField:'id',
			textField:'text',
			edittable:false,
			panelHeight : '200' 
		});			
		//如果是新增，加载监管主体和进货信息
		if ("add"=="<%=op%>"){ //add begin
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryJinhuoDTO', {
				hjhbid : v_local_hjhbid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					//$('form').form('load', mydata);
					$('#hviewjgztid').val(mydata.hviewjgztid);//监管主体id
					$('#hviewjgztmc').val(mydata.jgztmc);//监管主体名称
					$('#eptbh').val(mydata.eptbh);//eptbh
					$('#jcypid').val(mydata.jcypid);//eptbh
					$('#jcypmc').val(mydata.jcypmc);//eptbh
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');	
			
			//加载检测人员信息
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/pcomry/queryPcomryDTO', {
				ryid : '<%=v_aaz001%>'
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					//$('form').form('load', mydata);
					////$('#jcorgid').val(mydata.comid);//检测机构id
					$('#jcorgmc').val(mydata.commc);//检测机构名称
					$('#jcryid').val(mydata.ryid);//检查人员id
					$('#jcrymc').val(mydata.ryxm);//检测人员名称
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');	
			
		};/////////////////////////////////////add end
		
		if ("edit"=="<%=op%>" || "view"=="<%=op%>"){ //no add begin
			if ($('#jcztbzjid').val().length > 0) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
				$.post(basePath + 'tmsyjhtgl/queryJiancezbDTO', {
					jcztbzjid : $('#jcztbzjid').val()
				}, 
				function(result) {
					if (result.code=='0') {
						var mydata = result.data;					
						$('form').form('load', mydata);
						myqueryJiancemx();						
					} else {
						parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
		            }	
					parent.$.messager.progress('close');
				}, 'json');
			};	
		};// no add end
		
		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
			$('.Wdate').attr('disabled',true);	
			$("#jcjylb").combobox('disable',true);	
			$("div.datagrid-toolbar [id ='add']").eq(0).hide(); 
			$("#jyjcrq").datetimebox({disabled:true});
			$("a").each(function(index,object){
				object.removeAttribute("onclick");

			});
		}
		
		//物品清单明细
		v_jcmx_grid=$("#jcmx_grid");
		v_jcmx_grid.datagrid({
			//title :' 物品清单明细',
			//iconCls : 'icon-tip',
			//url : basePath+'/tmsyjhtgl/queryJiancemx?hjyjczbid=<%=v_hjyjczbid%>',
			striped : true, //奇偶行使用不同的颜色
			singleSelect : true, // 只允许选择一行
			checkOnSelect : true, //当用户点击行的时候就选中
			selectOnCheck : true,  //单击复选框将选择行
			pagination : false, //底部显示分页栏
			//pageSize : 10,  //每页显示的页数
			//pageList : [10,20,30],  //每页显示的页数（供选择）
			rownumbers : true,  //是否显示行号
			fitColumns :false,  //列自适应宽度  防止滚动
			idField : 'hjyjcmxbid',  //该列是一个唯一列 也是数据库中的表的主键
			sortOrder : '',  //按升序排序
			columns :[[
				{
					title : '检验检测明细表id',
					field : 'hjyjcmxbid',
					hidden : true
				},{
					title : '检验检测主表id',
					field : 'hjyjczbid',
					hidden : true
				},{
					title : '检测项目',
					field : 'jcxmmc',
					align : 'center',
					width : 150,
					formatter : function(value, row) {
						return sy.formatGridCode(v_jyjcxm,value);
				    },
					editor : {
						type : 'combobox',
						options:{
							data:v_jyjcxm,
							valueField:'id',
							textField:'text',
							required:true
						}
					}
					    
				},{
					title : '检测值',
					field : 'jcz',
					align : 'center',
					width : 100,
					editor : 'textarea'
				},{
					title : '数值单位',
					field : 'szdw',
					align : 'center',
					width : 100,
					formatter : function(value, row) {
						return sy.formatGridCode(v_szdw,value);
				    },
					editor : {
						type : 'combobox',
						options:{
							data:v_szdw,
							valueField:'id',
							textField:'text',
							required:true
						}
					}
				},{
					title : '检验检测结论',
					field : 'jyjcjl',
					align : 'center',
					width : 120,
					formatter : function(value, row) {
						return sy.formatGridCode(v_jyjcjl,value);
				    },
					editor : {
						type : 'combobox',
						options:{
							data:v_jyjcjl,
							valueField:'id',
							textField:'text',
							required:true
						}
					}					
				},{
					title : '限量标准',
					field : 'xlbz',
					align : 'center',
					width : 150,
					formatter : function(value, row) {
						return sy.formatGridCode(v_xlbz,value);
				    },
					editor : {
						type : 'combobox',
						options:{
							data:v_xlbz,
							valueField:'id',
							textField:'text',
							required:true
						}
					}	
				},{
					title : '标准值',
					field : 'bzz',
					align : 'center',
					width : 120,
					editor : 'textarea'
				}
			]]
		});		
		
		if ("edit"=="<%=op%>" || "add"=="<%=op%>"){ //toolbar begin
			v_jcmx_grid.datagrid({
				//双击事件：查看 修改等
				onDblClickRow : function(){
					var selected = v_jcmx_grid.datagrid('getSelected');
					if(selected){
						mydatagrid_edit(v_jcmx_grid);
					}
				},				
				toolbar: [{
					id:'add',
					iconCls : 'icon-add',
					text : '增加',
					handler : function(){
						mydatagrid_append(v_jcmx_grid);
					}
				},'-',
					{
					iconCls : 'icon-edit',
					text : '修改',
					handler : function(){
						mydatagrid_edit(v_jcmx_grid);
					}
				},'-',
					{
						iconCls: 'icon-remove',
						text: '删除',
						handler: function () {
							mydatagrid_remove(v_jcmx_grid);
						}
					}, '-',
					{
						iconCls: 'icon-undo',
						text: '取消',
						handler: function () {
							mydatagrid_reject(v_jcmx_grid);
						}
					}, '-',
					{
						iconCls: 'icon-save',
						text: '本地提交',
						handler: function () {
							mydatagrid_accept(v_jcmx_grid);
						}
					},'-',
					{
						iconCls: 'icon-modify',
						text: '数值单位维护',
						handler: function () {
							aa10manage('SZDW');
						}
					},'-',
					{
						iconCls: 'icon-modify',
						text: '限量标准维护',
						handler: function () {
							aa10manage('XLBZ');
						}
					}]
			});			
		}///toolbar end

		
	});/////////////////////////////////////////
	
	function g_getAa10FromAaa100ByPost(prm_aaa100){
		$.post(basePath + 'sysmanager/sysparam/getAa10MapOneKey', {
			aaa100:prm_aaa100
		}, 
		function(result) {
			if ('SZDW'==prm_aaa100){
				v_jcmx_grid.datagrid('removeEditor','szdw');
				v_jcmx_grid.datagrid('addEditor',[ 
					            {field:'szdw',
									editor : {
										type : 'combobox',
										options:{
											data:result,
											valueField:'id',
											textField:'text',
											required:true
										}
									}
					}]); 	
		    }else if ('XLBZ'==prm_aaa100){
				v_jcmx_grid.datagrid('removeEditor','xlbz');
				v_jcmx_grid.datagrid('addEditor',[ 
					            {field:'xlbz',
									editor : {
										type : 'combobox',
										options:{
											data:result,
											valueField:'id',
											textField:'text',
											required:true
										}
									}
					}]); 			    	
		    }
		}, 'json');	
	};
	
	
	function aa10manage(prm_aaa100){
		var obj = new Object();
		obj.singleSelect="true";	//
		var url = "<%=basePath%>jsp/sysmanager/aa10.jsp";
	   <%--  var v_ret=mySahowModalDialog("<%=basePath%>jsp/sysmanager/aa10.jsp?aaa100="+prm_aaa100+"&a="+new Date().getMilliseconds(),obj,
	        860,460); --%>
	    var dialog = parent.sy.modalDialog({ 
				title : ' ',
				width : 860,
				height : 460,
				param : {
					aaa100 : prm_aaa100
				},  
				url : url
			},function(dialogID){
				var obj = sy.getWinRet(dialogID); 
				if (!shiFouWeiKong(v_ret) && v_ret){
					if (prm_aaa100=='SZDW'){
						g_getAa10FromAaa100ByPost('SZDW');
					}else if (prm_aaa100=='XLBZ'){
						g_getAa10FromAaa100ByPost('XLBZ');
					};			
				};	 
				sy.removeWinRet(dialogID);
			}); 
	};  
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	
	var submitForm = function($dialog, $grid, $pjq) {
        mydatagrid_endEditing($('#jcmx_grid'));
        var v_jcmxbgriddata = $('#jcmx_grid').datagrid('getRows');
        $('#jcmxbgriddata').val($.toJSON(v_jcmxbgriddata));
		var url='<%=basePath%>/tmsyjhtgl/saveJiance';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#myform').form('submit',{
			url: url,
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
	        			$grid.datagrid('reload');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};
	
	//选择检测机构检测仪器
	function myselectJianceyiqi(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>tmsyjhtgl/selectJianceyiqiIndex?a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#sbxh").val(myrow.jcyqxh); //检测仪器型号
		      $("#sbxlh").val(myrow.jcyqxlh); //检测仪器序列号
		      
		    }      
	    }
	}	
	
	function myqueryJiancemx(){
		var param = {
				'hjyjczbid': $('#hjyjczbid').val()
			};
		v_jcmx_grid.datagrid({
				url : basePath + 'tmsyjhtgl/queryJiancemx',			
				queryParams : param
			});
		v_jcmx_grid.datagrid('clearSelections');
		}	
		
	// 修改
	var selectJianceyiqi = function() {
	    var dialog = parent.sy.modalDialog({
			title : '选择检测仪器',
			width : 700,
			height : 350,
			url : basePath + 'tmsyjhtgl/selectJianceyiqiIndex?a='+new Date().getMilliseconds(),
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.queding(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallback);
	};
	
	function closeModalDialogCallback(dialogID){	
		var v_retValue = sy.getWinRet(dialogID);
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
		      var myrow = v_retValue[k];
		      $("#sbxh").val(myrow.jcyqxh); //检测仪器型号
		      $("#sbxlh").val(myrow.jcyqxlh); //检测仪器序列号		      
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少						
	}
			
</script>
</head>
<body>
<div id="cc" class="easyui-layout" fit=true>
    <div data-options="region:'north'"
         style="height:40px;text-align:center;"  >
         <font style="font-size:200%;text-align:right;color: green;"><%=v_title%></font>
    </div>
    
    <div data-options="region:'center'"  fit=true>   
    <form  id="myform" method="post">    
      <input type="hidden" id="hjyjczbid" name="hjyjczbid">
	  <input type="hidden" id="jcztbzjid" name="jcztbzjid" value="<%=v_hjhbid%>">
	  <input type="hidden" id="jcmxbgriddata" name="jcmxbgriddata"/>
	  <input type="hidden" id="aae011" name="aae011" />
	  <input type="hidden" id="aae036" name="aae036" />
	  <input type="hidden" id="sjcsfs" name="sjcsfs" />
	  <input type="hidden" id="jcjyshbz" name="jcjyshbz" />
	  <input type="hidden" id="fjjg" name="fjjg" />
	  
      <sicp3:groupbox title="被检主体和商品信息">
        <table class="table" style="width:100%;height: 99%">
	        <tr>
				<td style="width:17%;text-align:right;"><nobr>检测主体名称:</nobr>
				</td>
				<td colspan="3">
				<input type="hidden" id="hviewjgztid" name="hviewjgztid">
				<input id="hviewjgztmc" name="hviewjgztmc" style="width: 500px" 
				class="easyui-validatebox input_readonly" readonly="readonly"/>
				</td>     			
	        </tr>  
	        <tr>
				<td style="width:17%;text-align:right;">e票通编号<nobr>:</nobr>
				</td>
				<td style="width:40%;">
				<input id="eptbh" name="eptbh" style="width: 200px" readonly="readonly"
				class="easyui-validatebox input_readonly" data-options="required:false"/>
				</td> 	   
				<td style="width:15%;text-align:right;">商品名称<nobr>:</nobr>
				</td>
				<td style="width:28%;">
				<input type="hidden" id="jcypid" name="jcypid">
				<input id="jcypmc" name="jcypmc" style="width: 200px" readonly="readonly"
				class="easyui-validatebox input_readonly" data-options="required:false"/>
				</td> 			
	        </tr>  
	        	              
        </table>
      </sicp3:groupbox>
      <sicp3:groupbox title="检测主信息">
      <table class="table" style="width:100%;height: 99%">
        <tr>
			<td style="width:17%;text-align:right;">检测机构名称<nobr>:</nobr>
			</td>
			<td style="width:40%;">
			<input type="hidden" id="jcorgid" name="jcorgid">
			<input id="jcorgmc" name="jcorgmc" style="width: 200px" readonly="readonly"
			class="easyui-validatebox input_readonly" data-options="required:false"/>
			</td> 	   
			<td style="width:15%;text-align:right;">检测人员名称<nobr>:</nobr>
			</td>
			<td style="width:28%;">
			<input type="hidden" id="jcryid" name="jcryid">
			<input id="jcrymc" name="jcrymc" style="width: 200px" readonly="readonly"
			class="easyui-validatebox input_readonly" data-options="required:false"/>
			</td> 			
        </tr>        
        <tr>
			<td style="text-align:right;">检验检测日期<nobr>:</nobr>
			</td>
			<td>
			<input id="jyjcrq" name="jyjcrq" style="width: 200px" 
			class="easyui-datetimebox" data-options="required:false"/>
			</td>         
			<td style="text-align:right;">检验检测报告编号<nobr>:</nobr>
			</td>
			<td>
			<input id="jyjcbgbh" name="jyjcbgbh" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td> 	   
        </tr> 
        <tr>
			<td style="text-align:right;">检测检验类别<nobr>:</nobr>
			</td>
			<td>
			<input id="jcjylb" name="jcjylb" style="width: 200px" 
			class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/>
			</td>             
        </tr> 
        <tr>
			<td style="text-align:right;">设备型号<nobr>:</nobr>
			</td>
			<td>
			<input id="sbxh" name="sbxh" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			<% if(!"view".equalsIgnoreCase(op)){%>
			 <a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="selectJianceyiqi()">选择 </a>
			<%} %>					
			</td>         
			<td style="text-align:right;">设备序列号<nobr>:</nobr>
			</td>
			<td>
			<input id="sbxlh" name="sbxlh" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td> 	   
        </tr>          

        </table>                              
      </sicp3:groupbox>    
      <sicp3:groupbox title="检测明细信息">
         <div id="jcmx_grid" style="height:300px;overflow:auto;"></div>
      </sicp3:groupbox>         
      </form>
    </div>
    
</div>
</body>
</html>