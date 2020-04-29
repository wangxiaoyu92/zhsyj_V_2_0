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
    String v_hxhbid=StringHelper.showNull2Empty(request.getParameter("hxhbid")); //进出库表主键
	String v_title="销货管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="销货 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="销货 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="销货 查看";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %></title>
<jsp:include page="${contextPath}/inc_easyui.jsp"></jsp:include>
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
	
	
	$(function() {
		// 计量单位
		 $('#jhspjldw').combobox({
			data:v_spjldw,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
			// 计量单位
		 $('#xhspjldw').combobox({
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
		//进出库合格证明类型
		 $('#jchhgzmlx').combobox({
			data:v_jhhgzmlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});		
		//生产检验结论
		 $('#jchscjyjl').combobox({
			data:v_jhscjyjl,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});
		//企业查验结论
		 $('#jchqycyjl').combobox({
				data:v_jhqycyjl,
				valueField:'id',
				textField:'text',
				required:false,
				edittable:false,
				panelHeight : '200' 
			});		
		
		 $("#tabjinhuoinfo :input").addClass('input_readonly');
			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				$("#xhspjldw").combobox('disable',true);	
				$("#btn_selgouhuoshang").css('display','none');
				$("#btn_selgouhuoshang").linkbutton("disable");
				$("#btn_selJinhuoxx").css('display','none');
				$("#btn_selJinhuoxx").linkbutton("disable");				
				$("#jhscrq").datebox({disabled:true});
				$("a").each(function(index,object){
					object.removeAttribute("onclick");

				});
			}			 
		
		if ($('#hxhbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryXiaohuoDTO', {
				hxhbid : $('#hxhbid').val()
			}, 
			function(result) {

				if (result.code=='0') {
					var mydata = result.data;
					for (var attr in mydata) {
						$("#" + attr).val(mydata[attr]);
					}
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		};	
		
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url='<%=basePath%>/tmsyjhtgl/saveXiaohuo';
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
	        			$grid.datagrid('load');
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
        var v_fjwid=$("#hjchid").val();
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
	function myselectJinhuo(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>tmsyjhtgl/selectJinhuoIndex?a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#hjhbid").val(myrow.hjhbid); //对应的进货表id
		      $("#eptbh").val(myrow.eptbh); //e票通编号
		      $("#jhsjfxid").val(myrow.hjhbid); //上级分销id 就是选择的进货信息的主键
		      $("#jcypid").val(myrow.jcypid); //商品id
		      $("#jcypmc").val(myrow.jcypmc); //商品名称
		      $("#jhkcl").val(myrow.jhkcl); //库存量
		      $("#jhspjldw").combobox('setValue',myrow.jhspjldw); //计量单位
		      
		      $("#jhprice").val(myrow.jhprice); //商品价格
		      $("#jhscd").val(myrow.jhscd); //生产地
		      $("#jhscrq").datebox('setValue',myrow.jhscrq); //生产日期
		      $("#jhgysid").val(myrow.jhgysid); //供应商
		      $("#jhgysmc").val(myrow.jhgysmc); //供应商
		      $("#jhscsid").val(myrow.jhscsid); //生产商
		      $("#jhscsmc").val(myrow.jhscsmc); //生产商
		      $("#jhsptm").val(myrow.jhsptm); //商品条码
		      $("#jhscpcm").val(myrow.jhscpcm); //生产批次码
		    }      
	    }
	}	
	
	// 选择商品
	var myselectJinhuoBase = function() {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '选择进货信息',
			width : 900,
			height : 460,
			url : basePath + 'tmsyjhtgl/selectJinhuoIndex?singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
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
		      $("#hjhbid").val(myrow.hjhbid); //对应的进货表id
		      $("#eptbh").val(myrow.eptbh); //e票通编号
		      $("#jhsjfxid").val(myrow.hjhbid); //上级分销id 就是选择的进货信息的主键
		      $("#jcypid").val(myrow.jcypid); //商品id
		      $("#jcypmc").val(myrow.jcypmc); //商品名称
		      $("#jhkcl").val(myrow.jhkcl); //库存量
		      $("#jhspjldw").combobox('setValue',myrow.jhspjldw); //计量单位
		      
		      $("#jhprice").val(myrow.jhprice); //商品价格
		      $("#jhscd").val(myrow.jhscd); //生产地
		      $("#jhscrq").datebox('setValue',myrow.jhscrq); //生产日期
		      $("#jhgysid").val(myrow.jhgysid); //供应商
		      $("#jhgysmc").val(myrow.jhgysmc); //供应商
		      $("#jhscsid").val(myrow.jhscsid); //生产商
		      $("#jhscsmc").val(myrow.jhscsmc); //生产商
		      $("#jhsptm").val(myrow.jhsptm); //商品条码
		      $("#jhscpcm").val(myrow.jhscpcm); //生产批次码    
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少						
	}	
	
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
			      $("#jchgysid").val(myrow.hjgztkhgxid); //  
			      $("#jchgysmc").val(myrow.jgztkhmc); //	    	  
		      }else if (prm_jgztkhgx=='2'){//生产商
			      $("#jchscsid").val(myrow.hjgztkhgxid); //  
			      $("#jchscsmc").val(myrow.jgztkhmc); //		    	  
		      }
		    }      
	    }
	}	
	
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
	
	//选择监管主体
	function myselectJianGuanZhuTi(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectJianGuanZhuTiIndex?a="+new Date().getMilliseconds(),obj,
	        1000,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#hviewjgztid").val(myrow.hviewjgztid); //  
		      $("#jgztmc").val(myrow.jgztmc); //	    	  
		    }      
	    }
	}		
	
	// 选择监管主体
	var myselectJianGuanZhuTiBase = function() {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '选择购货商',
			width : 1000,
			height : 460,
			url : basePath + 'pub/pub/selectJianGuanZhuTiIndex?singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
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
		var v_obj = sy.getWinRet(dialogID);
		var v_retValue=v_obj.retValue;
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
		      var myrow = v_retValue[k];
		      $("#hviewjgztid").val(myrow.hviewjgztid); //  
		      $("#jgztmc").val(myrow.jgztmc); //      
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少					
	}
	
	
	function myKcslOnblur(){
		var v_jhkcl=$("#jhkcl").val();
		var v_xhsl=$("#xhsl").val();
		if (v_jhkcl==null || ""==v_jhkcl){
			v_jhkcl=0;
		}
		if (v_xhsl==null || ""==v_xhsl){
			v_xhsl=0;
		}
		v_xhsl=parseInt(v_xhsl);
		v_jhkcl=parseInt(v_jhkcl);
		if (v_xhsl>v_jhkcl){
			alert("销货数量 不能大于 进货库存量");
			$("#xhsl").focus();			
		}
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
	  <input type="hidden" id="hxhbid" name="hxhbid" value="<%=v_hxhbid %>">
	  <input type="hidden" id="hjhbid" name="hjhbid">
	  <input type="hidden" id="hjhbidnew" name="hjhbidnew">
	  <input type="hidden" id="eptbh" name="eptbh">
	  <input type="hidden" id="aae011" name="aae011">
	  <input type="hidden" id="aae036" name="aae036">
	  <input type="hidden" id="jhsjfxid" name="jhsjfxid">
	  
	  
      <sicp3:groupbox title="进货信息">
	      <table id="tabjinhuoinfo" class="table" style="width:100%;height: 99%">
	        <tr>
	          <td width="13%" style="text-align:right;"><nobr><font class="myred">
	           *</font>商品名:</nobr>
	           </td>
			  <td width="45%">
			  <input type="hidden" id="jcypid" name="jcypid">
			  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 200px" 
				  class="easyui-validatebox" data-options="required:true" />
				<a id="btn_selJinhuoxx" href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-search" onclick="myselectJinhuoBase()">选择进货信息 </a>	
			  </td>   
	          <td width="13%" style="text-align:right;"><nobr><font class="myred">
	           *</font>库存量:</nobr>
	           </td>
			  <td width="29%">
			  <input id="jhkcl" name="jhkcl" style="width: 200px" readonly="readonly" 
				  class="easyui-validatebox" data-options="required:false" />
			  </td>  		         
	        </tr>
	        <tr>
				<td style="text-align:right;"><nobr>计量单位:</nobr>
				</td>
				<td>
				<input id="jhspjldw" name="jhspjldw" style="width: 200px" 
				readonly="readonly"  class="easyui-validatebox" />
				</td>     
				<td style="text-align:right;">单价<nobr>:</nobr>
				</td>
				<td>
				<input id="jhprice" name="jhprice" style="width: 200px" 
				readonly="readonly"  class="easyui-validatebox" data-options="required:false"/>
				</td> 			
			   
	        </tr>
	        <tr>
				<td style="text-align:right;"><nobr>生产地:</nobr>
				</td>
				<td>
				<input id="jhscd" name="jhscd" style="width: 200px" readonly="readonly" 
				class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'"/>
				</td> 	
				<td style="text-align:right;"><nobr>生产日期:</nobr>
				</td>
				<td>
				<input id="jhscrq" name="jhscrq" style="width: 200px" 
				readonly="readonly"  class="easyui-datebox" data-options="required:false"/>
				</td>  			 			      
	        </tr>
	        <tr>
				<td style="text-align:right;"><nobr>供应商:</nobr>
				</td>
				<td>
				<input type="hidden" id="jhgysid" name="jhgysid"> 
				<input id="jhgysmc" name="jhgysmc" readonly="readonly" style="width: 200px" 
				readonly="readonly"  class="easyui-validatebox" data-options="required:false"/>
				</td>  
				<td style="text-align:right;">生产商<nobr>:</nobr>
				</td>
				<td>
				<input type="hidden" id="jhscsid" name="jhscsid">  
				<input id="jhscsmc" name="jhscsmc" readonly="readonly" style="width: 200px" 
				readonly="readonly" class="easyui-validatebox" data-options="required:false"/>
				</td>  			      
	        </tr>         
	        <tr>
				<td style="text-align:right;"><nobr>商品条码:</nobr>
				</td>
				<td >
				<input id="jhsptm" name="jhsptm" style="width: 200px" 
				readonly="readonly"  class="easyui-validatebox" data-options="required:false"/>
				</td>  
				<td style="text-align:right;"><nobr>生产批次码:</nobr>
				</td>
				<td>
				<input id="jhscpcm" name="jhscpcm" style="width: 200px" 
				readonly="readonly"  class="easyui-validatebox" data-options="required:false"/>
				</td>  				
	        </tr>
	      </table>          
      </sicp3:groupbox>  
      <sicp3:groupbox title="出货信息">   
	      <table class="table" style="width:100%;height: 99%">
	        <tr>
	          <td width="13%" style="text-align:right;"><nobr><font class="myred">
	           *</font>购货商:</nobr>
	           </td>
			  <td width="87%" colspan="3">
			  <input type="hidden" id="hviewjgztid" name="hviewjgztid">
			  <input id="jgztmc" name="jgztmc" readonly="readonly" style="width: 200px" 
				  class="easyui-validatebox" data-options="required:true" />
				<a id="btn_selgouhuoshang" href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-search" onclick="myselectJianGuanZhuTiBase()">选择购货商 </a>	
			  </td>   
		         
	        </tr>
	        <tr>
	          <td width="13%" style="text-align:right;"><nobr><font class="myred">
	           *</font>数量:</nobr>
	           </td>
			  <td width="45%">
			  <input id="xhsl" name="xhsl" style="width: 200px" 
				  class="easyui-validatebox" data-options="required:true" 
				  onblur="myKcslOnblur();"/>
			  </td > 
				<td style="text-align:right;"><nobr>计量单位:</nobr>
				</td>
				<td>
				<input id="xhspjldw" name="xhspjldw" style="width: 200px" 
				  class="easyui-validatebox" />
				</td> 
	        </tr>
	        <tr>
				<td width="13%" style="text-align:right;">单价<nobr>:</nobr>
				</td>
				<td width="29%" colspan="3">
				<input id="xhprice" name="xhprice" style="width: 200px" 
				class="easyui-validatebox" data-options="required:false"/>
				</td> 		        
	        </tr>
	      </table>          
      </sicp3:groupbox>        
     
      </form>
    </div>
    
</div>
</body>
</html>