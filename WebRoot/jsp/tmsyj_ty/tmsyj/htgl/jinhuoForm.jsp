<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
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
    String v_hjhbid=StringHelper.showNull2Empty(request.getParameter("hjhbid")); //进出库表主键
	String v_title="进货 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="进货 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="进货 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="进货 查看";
	}
	
	//qykind 企业类型 因为进货 生产企业和其他企业可能不一样
	String v_qykind = StringHelper.showNull2Empty(request.getParameter("qykind"));  //
	if (null==v_qykind || "".equals(v_qykind)){
		v_qykind="no";
	}
	//querykind 查询数据类型 空或0 不加其他条件 为1 加只查本企业商品
	String v_querykind="0";
	String v_spsjlx="";//商品数据类型0商品1产品2原材料 生产企业只查原材料
	String v_selfwnfww="1";//默认选择范围内还是范围外 1范围内 2范围外
	if ("scqy".equals(v_qykind)){
		v_querykind="1";
		v_spsjlx="2";
		v_selfwnfww="2";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %>></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//食品计量单位
	var v_spjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	//检测方式
	var v_jcfs = <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	//进出库合格证明类型
	var v_jhhgzmlx = <%=SysmanageUtil.getAa10toJsonArray("JHHGZMLX")%>;	
	//生产检验结论
	var v_jhscjyjl = <%=SysmanageUtil.getAa10toJsonArray("JHSCJYJL")%>;	
	//企业查验结论
	var v_jhqycyjl = <%=SysmanageUtil.getAa10toJsonArray("JHQYCYJL")%>;	
	//进货确认标志
	var v_jhqrbz = <%=SysmanageUtil.getAa10toJsonArray("JHQRBZ")%>;	
	
	$(function() {
		// 进货确认标志
		 $('#jhqrbz').combobox({
			data:v_jhqrbz,
			valueField:'id',
			textField:'text',
			edittable:false,
			panelHeight : '200' 
		});		
		// 计量单位
		 $('#jhspjldw').combobox({
			data:v_spjldw,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		// 检测方式
		 $('#jcfs').combobox({
			data:v_jcfs,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});	
		 $('#jhhgzmlx').combobox({
			data:v_jhhgzmlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});		
		 $('#jhscjyjl').combobox({
			data:v_jhscjyjl,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});	
		 $('#jhqycyjl').combobox({
				data:v_jhqycyjl,
				valueField:'id',
				textField:'text',
				required:false,
				edittable:false,
				panelHeight : '200' 
			});		
		
		if ($('#hjhbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryJinhuoDTO', {
				hjhbid : $('#hjhbid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
 					//var v_jchgzmpath = $("#jchhgzmpath").val();
		            //if (v_jchgzmpath != "") {
		            //	$("#jchhgzmpic").attr("src", "<%=basePath%>"+v_jchgzmpath);
		            //};					
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		};	
		
		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
			$('.Wdate').attr('disabled',true);	
			$("#spjldw").combobox('disable',true);	
			$("#jcfs").combobox('disable',true);
			$("#jhscjyjl").combobox('disable',true);
			$("#jhqycyjl").combobox('disable',true);
			$("#jhhgzmlx").combobox('disable',true);
			$("#btnselectHgzmpic").css('display','none');
			$("#btnselectHgzmpic").linkbutton("disable");
			$("#jhscrq").datebox({disabled:true});
			$("a").each(function(index,object){
				object.removeAttribute("onclick");

			});
			$("#td[name='btntd']").hide();
		}		
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url='<%=basePath%>/tmsyjhtgl/saveJinhuo';
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
	
	// 上传图片附件
	function uploadFjViewCanNoId(prm_fjtype){
        var v_fjwid=$("#hjhbid").val();
        var v_fjtype="9";
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjwid="+v_fjwid+"&fjtype="+v_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";//yes 或 no
		var retVal = popwindow(url,obj,900,700); 
		if(retVal != null){
			if(retVal.type == 'ok'){
				if (prm_fjtype=="9"){//检测合格证明图片
				  $("#jchhgzmpath").val(retVal.fjpath);
				  $("#jchhgzmname").val(retVal.fjname);	
				  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+retVal.fjpath);
				}
			}
			if(retVal.type == 'deleteok'){
				var v_defaultpic="/images/default.jpg";
				if (prm_fjtype=="9"){//检测合格证明图片
				  $("#jchhgzmpath").val("");
				  $("#jchhgzmname").val("");	
				  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+v_defaultpic);
				}
			}		
		}

	};
	
	//从单位信息表中读取
	function myselectShangpin(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectShangpinIndex?spsjlx=<%=v_spsjlx%>&querykind=<%=v_querykind%>&a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#jcypid").val(myrow.jcypid); //公司名称   
		      $("#jcypmc").val(myrow.jcypmc); //公司代码 
		      
		    }      
	    }
	}	
	
	// 选择商品
	var myselectShangpinBase = function() {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '选择商品',
			width : 860,
			height : 460,
			url : basePath + 'pub/pub/selectShangpinIndex?singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
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
		      $("#jcypid").val(myrow.jcypid); //公司名称   
		      $("#jcypmc").val(myrow.jcypmc); //公司代码 	  
		      
		      //gu20170907 获取历史的该商品的进货记录 进行填充
		      //如果是新增进货 add
		      if ('add'=='<%=op%>'){
					if ($('#jcypid').val().length > 0) {
						parent.$.messager.progress({
							text : '数据加载中....'
						});
						$.post(basePath + '/tmsyjhtgl/queryJinhuoDTO', {
							jcypid : $('#jcypid').val(),
							querymaxjhjl : '1'
						}, 
						function(result) {
							if (result.code=='0') {
								var mydata = result.data;					
								$('form').form('load', mydata);	
								//进货数量,进货表主键 置为空 							
								$("#jhsl").val("");
								$("#hjhbid").val("");
								//生产日期默认为当天
								document.getElementById("jhscrq").value = g_formatterDate(new Date());//获取文本id并且传入当前日期
								//数量获取输入焦点
							} else {
								parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
				            }	
							parent.$.messager.progress('close');
						}, 'json');
					};		    	  
		      }
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少							
	};
	
	//从单位信息表中读取
	function myselectGongyingshang(prm_jgztkhgx){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectGongyingshangIndex?jgztkhgx="+prm_jgztkhgx+"&a="+new Date().getMilliseconds(),obj,
	        900,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      if (prm_jgztkhgx=='1'){//供应商
			      $("#jhgysid").val(myrow.hjgztkhgxid); //  
			      $("#jhgysmc").val(myrow.jgztkhmc); //	    	  
		      }else if (prm_jgztkhgx=='2'){//生产商
			      $("#jhscsid").val(myrow.hjgztkhgxid); //  
			      $("#jhscsmc").val(myrow.jgztkhmc); //		    	  
		      }
		    }      
	    }
	}	
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTi(prm_jgztlx){ 
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectJianGuanZhuTiIndex?selfwnfww=<%=v_selfwnfww%>&qykind=<%=v_qykind%>&jgztlx="+prm_jgztlx+"&a="+new Date().getMilliseconds(),obj,
		        1000,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];//监管主体表3供应商4生产商5经销商
		      if (prm_jgztlx=='3'){//供应商
			      $("#jhgysid").val(myrow.hviewjgztid); //  
			      $("#jhgysmc").val(myrow.jgztmc); //	    	  
		      }else if (prm_jgztlx=='4'){//生产商
			      $("#jhscsid").val(myrow.hviewjgztid); //  
			      $("#jhscsmc").val(myrow.jgztmc); //		    	  
		      }
		    }      
	    }
	}		
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTiBase(prm_jgztlx) {
		var v_singleSelect="true";
		var v_title='企业';
		if (prm_jgztlx=='2'){
			v_title='商户';
		}else if (prm_jgztlx=='3'){
			v_title='供应商';
		}else if (prm_jgztlx=='4'){
			v_title='生产商';
		}else if (prm_jgztlx=='5'){
			v_title='经销商';
		};
		
	    var dialog = parent.sy.modalDialog({
			title : v_title,
			width : 1060,
			height : 460,
			url : basePath + 'pub/pub/selectJianGuanZhuTiIndex?singleSelect='+v_singleSelect+'&selfwnfww=<%=v_selfwnfww%>&qykind=<%=v_qykind%>&jgztlx='+prm_jgztlx+'&a='+new Date().getMilliseconds(),
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
		},closeModalDialogCallbackZhuti);
	};
	
	function closeModalDialogCallbackZhuti(dialogID){
		var obj = sy.getWinRet(dialogID);
		var v_jgztlx = obj.jgztlx;
		var v_retValue = obj.retValue;
		//var v_retValue = sy.getWinRetObj("retValue");
		//var v_jgztlx = sy.getWinRet("jgztlx");
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
			      var myrow=v_retValue[k];//监管主体表3供应商4生产商5经销商
			      if (v_jgztlx=='3'){//供应商
				      $("#jhgysid").val(myrow.hviewjgztid); //  
				      $("#jhgysmc").val(myrow.jgztmc); //	    	  
			      }else if (v_jgztlx=='4'){//生产商
				      $("#jhscsid").val(myrow.hviewjgztid); //  
				      $("#jhscsmc").val(myrow.jgztmc); //		    	  
			      }    
		    }      
	    }
	    //sy.removeWinRet("retValue");	
	    //sy.removeWinRet("jgztlx");
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
	  <input type="hidden" id="hjhbid" name="hjhbid" value="<%=v_hjhbid %>">
	  <input type="hidden" id="jhsjfxid" name="jhsjfxid">
	  <input type="hidden" id="jhtotal" name="jhtotal">
	  <input type="hidden" id="hviewjgztid" name="hviewjgztid">
	  <input type="hidden" id="eptbh" name="eptbh">
	  <input type="hidden" id="aae011" name="aae011">
	  <input type="hidden" id="aae036" name="aae036">
	  <input type="hidden" id="jhkcl" name="jhkcl">
	  <input type="hidden" id="jhsjfxsztid" name="jhsjfxsztid">
	  
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>商品:</nobr>
           </td>
		  <td width="37%">
		  <input type="hidden" id="jcypid" name="jcypid">
		  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectShangpinBase()">选择 </a>	
			<%} %>				  
		  </td>   
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>数量:</nobr>
           </td>
		  <td width="37%">
		  <input id="jhsl" name="jhsl" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  </td>  		         
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>计量单位:</nobr>
			</td>
			<td>
			<input id="jhspjldw" name="jhspjldw" style="width: 200px" 
			class="easyui-validatebox" />
			</td>     
			<td style="text-align:right;">单价<nobr>:</nobr>
			</td>
			<td>
			<input id="jhprice" name="jhprice" style="width: 200px" 
			class="easyui-validatebox" />
			</td> 			
		   
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>生产地:</nobr>
			</td>
			<td>
			<input id="jhscd" name="jhscd" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'"/>
			</td> 	
			<td style="text-align:right;"><nobr>生产日期:</nobr>
			</td>
			<td>
			<input id="jhscrq" name="jhscrq" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			</td>  			 			      
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>供应商:</nobr>
			</td>
			<td>
			<input type="hidden" id="jhgysid" name="jhgysid"> 
			<input id="jhgysmc" name="jhgysmc" readonly="readonly" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectJianGuanZhuTiBase(3)">选择</a>	
				<%} %>				
			</td>  
			<td style="text-align:right;">生产商<nobr>:</nobr>
			</td>
			<td>
			<input type="hidden" id="jhscsid" name="jhscsid">
			<input id="jhscsmc" name="jhscsmc" readonly="readonly" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectJianGuanZhuTiBase(4)">选择 </a>	
				<%} %>				
			</td>  			      
        </tr>         
        <tr>
			<td style="text-align:right;"><nobr>商品条码:</nobr>
			</td>
			<td>
			<input id="jhsptm" name="jhsptm" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td> 
			<td style="text-align:right;"><nobr>生产批次码:</nobr>
			</td>
			<td>
			<input id="jhscpcm" name="jhscpcm" style="width: 200px" 
			class="easyui-validatebox" />
			</td> 			 
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>检测方式:</nobr>
			</td>
			<td colspan="3">
			<input id="jcfs" name="jcfs" style="width: 200px" 
			class="easyui-validatebox"/>
			</td>  
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>生产检验结论:</nobr>
			</td>
			<td>
			<input id="jhscjyjl" name="jhscjyjl" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  
			<td style="text-align:right;">企业查验结论<nobr>:</nobr>
			</td>
			<td>
			<input id="jhqycyjl" name="jhqycyjl" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  			      
        </tr>  
        <tr>
			<td style="text-align:right;"><nobr>合格证明类型:</nobr>
			</td>
			<td>
			<input id="jhhgzmlx" name="jhhgzmlx" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  
			<td style="text-align:right;"><nobr>进货确认标志:</nobr>
			</td>
			<td>
			<input id="jhqrbz" name="jhqrbz" style="width: 200px" 
			class="easyui-validatebox"  />
			</td> 				
<%-- 			<td colspan="2" rowspan="4" style="text-align: center;">
			    <div style="width:130;height:160;text-align: center;" id="ryzhaopian_div" >
			    	<img src="<%=contextPath%>/images/default.jpg" name="jchhgzmpic" id="jchhgzmpic" height="140" width="120"
			    	onclick="g_showBigPic(this.src);"/>
			   	</div>
			   	<a id="btnselectHgzmpic" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-search"
				onclick="uploadFjViewCanNoId(9)">选择合格证明图片</a> 
				<input type="hidden" id="jchhgzmpath" name="jchhgzmpath">	
				<input type="hidden" id="jchhgzmname" name="jchhgzmname">	
    		</td>	 --%>	      
        </tr>   
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>