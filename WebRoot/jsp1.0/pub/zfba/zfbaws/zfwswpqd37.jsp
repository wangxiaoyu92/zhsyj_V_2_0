<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%@ page import="com.askj.zfba.dto.Zfwswpqd37DTO" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 		+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书编号
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//物品清单
	Zfwswpqd37DTO dto = new Zfwswpqd37DTO();
	if(request.getAttribute("mybean")!=null){
		dto = (Zfwswpqd37DTO) request.getAttribute("mybean");
	}
	String v_fjcszfwstitle = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcszfwstitle")),"UTF-8");	
		String sjws=null;
	if (request.getAttribute("sjws") != null) {
		sjws= (String) request.getAttribute("sjws");
	}
	String v_userid=StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-right:-0.60694444in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;margin-bottom:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-left:-0.0013888889in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:-0.34583333in;margin-left:-0.050694443in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.8020833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.td1{width:0.8090278in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td2{width:1.5569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td3{width:0.5in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td4{width:1.1340277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td5{width:0.6159722in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.625in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td7{width:0.57916665in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-top:thin solid black;}
.td8{width:5.5111113in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-top:thin solid black;}
.r1{keep-together:always;}
.r2{height:0.090277776in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;}
</style>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 
$(function(){
      if(<%=sjws%>=='2'){
		$("#lcwmbBtn").eq(0).hide();
		$("#lcwBtn").eq(0).hide();
		$("#BtnFanhui").eq(0).hide(); 
        } 
	//未保存不允许打印，不予许另存为模板
	var v_wpqdid = $("#wpqdid").val();
	if(v_wpqdid==""||v_wpqdid==null||v_wpqdid.length==0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	
	//物品清单明细
	var v_wpqdmx_table=$("#wpqdmx_table");
	v_wpqdmx_table.datagrid({
		//title :' 物品清单明细',
		//iconCls : 'icon-tip',
		url : basePath+'/pub/wsgldy/queryZfwswpqdmx?ajdjid=<%=v_ajdjid%>&zfwsdmz=<%=v_zfwsdmz%>&wpqdid='+$("#wpqdid").val(),
		striped : true, //奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : false, //底部显示分页栏
		//pageSize : 10,  //每页显示的页数
		//pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'wpqdmxid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '物品清单明细ID',
				field : 'wpqdmxid',
				hidden : true
			},{
				title : '品名',
				field : 'wpmxpm',
				align : 'center',
				width : 100,
				editor : 'textarea'
			},{
				title : '标识生产企业或经营单位',
				field : 'wpmxbsscqy',
				align : 'center',
				width : 150,
				editor : 'textarea'
			},{
				title : '规格',
				field : 'wpmxgg',
				align : 'center',
				width : 80,
				editor : 'textarea'
			},{
				title : '生产批号或生产日期',
				field : 'wpmxscpc',
				align : 'center',
				width : 150,
				editor : 'textarea'
			},{
				title : '数量',
				field : 'wpmxsl',
				align : 'center',
				width : 60,
				editor : 'textarea'
			},{
				title : '单价',
				field : 'wpmxdj',
				align : 'center',
				width : 60,
				editor : 'textarea'
			},{
				title : '包装',
				field : 'wpmxbz',
				align : 'center',
				width : 80,
				editor : 'textarea'
			},{
				title : '备注',
				field : 'wpmxbeiz',
				align : 'center',
				width : 100,
				editor : 'textarea'
			}
		]],
		//双击事件：查看 修改等
		onDblClickRow : function(){
		var selected = v_wpqdmx_table.datagrid('getSelected');
		if(selected){
			mydatagrid_edit(v_wpqdmx_table);
		}
	},
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '增加',
			handler : function(){
				mydatagrid_append(v_wpqdmx_table);
			}
		},'-',
			{
			iconCls : 'icon-edit',
			text : '修改',
			handler : function(){
				mydatagrid_edit(v_wpqdmx_table);
			}
		},'-',
			{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_wpqdmx_table);
				}
			}, '-',
			{
				iconCls: 'icon-undo',
				text: '取消',
				handler: function () {
					mydatagrid_reject(v_wpqdmx_table);
				}
			}, '-',
			{
				iconCls: 'icon-save',
				text: '保存',
				handler: function () {
					mydatagrid_accept(v_wpqdmx_table);
				}
			}]
	});
});

//单击某行进行编辑
function mydatagrid_edit(v_datagrid){
	var index = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	if(index == -1){
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('selectRow',index)
			  .datagrid('beginEdit',index);
}

//添加一行
function mydatagrid_append(v_datagrid){
	var editIndex = -1;
	if(mydatagrid_endEditing(v_datagrid)){
		v_datagrid.datagrid('appendRow',{});  //在最后追加一行
		editIndex = v_datagrid.datagrid('getRows').length-1;
		v_datagrid.datagrid('selectRow',editIndex)
				  .datagrid('beginEdit',editIndex);
	}
	return editIndex;
}

//编辑状态
function mydatagrid_endEditing(v_datagrid){
	var editIndex = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	//如果某一行处于校验状态，那么这一行处于编辑状态
	if(v_datagrid.datagrid('validateRow',editIndex)){
		var ed = v_datagrid.datagrid('getEditor',{index:editIndex});  //根据行索引得到编辑器
		v_datagrid.datagrid('endEdit',editIndex);
		return true;
	}else{
		return false;
	}
}

//删除一行
function mydatagrid_remove(v_datagrid){
	var index = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	if(index == -1){
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('cancelEdit',index)
			.datagrid('deleteRow',index);
	if(index-1>=0){
		v_datagrid.datagrid('selectRow',index-1);
	}
}
    
//撤销编辑
function mydatagrid_reject(v_datagrid) {
    var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
    if (index == -1) {
        alert("请先选择行");
        return false;
    }
    v_datagrid.datagrid('rejectChanges');
}

//保存
function mydatagrid_accept(v_datagrid){
	if(mydatagrid_endEditing(v_datagrid)){
		v_datagrid.datagrid('acceptChagnes');
	}
}

/**
 * 保存
 */
function mysave(){
		var url= basePath+'/pub/wsgldy/saveZfwswpqd?sjordn=<%=sjws%>';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
          mydatagrid_endEditing($('#wpqdmx_table'));
          var v_wpqdmx_rows = $('#wpqdmx_table').datagrid('getRows');
          $('#wpqdmx_table_rows').val($.toJSON(v_wpqdmx_rows));
		
		$('#myform').form('submit',{
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
			 		$("#wpqdid").val(result.wpqdid);
			 		$("#saveBtn").linkbutton('disable');			 		
			 		$("#lcwmbBtn").linkbutton('enable');	
			 		$("#printBtn").linkbutton('enable');
			 		alert("保存成功！");
              	} else {
              		alert("保存失败：" + result.msg);
                }
	        }    
		});
}
/**
 * 打印
 */	
function myprint(){
    var obj = new Object();
    // 案件登记id
    var v_ajdjid=$("#ajdjid").val();
    // 物品清单id
    var v_wpqdid = $("#wpqdid").val();
      if(<%=sjws%>=='2'){
      	 var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
		 	+v_ajdjid+"&wpqdid="+v_wpqdid+"&fjcszfwstitle=<%=v_fjcszfwstitle%>&type=1&time="+new Date().getMilliseconds();
      	self.location=url; 
     }else{ 
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwswpqdPrintIndex?ajdjid="
		+v_ajdjid+"&wpqdid="+v_wpqdid+"&fjcszfwstitle=<%=v_fjcszfwstitle%>&time="+new Date().getMilliseconds()));
   		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});
     } 
      
}

//保存为模板
function saveAsMoban(){
	var obj = new Object();
	var v_ajdjid = $("#ajdjid").val();
	var v_zfwsdmz = $("#zfwsdmz").val();
	var v_wpqdid = $("#wpqdid").val();
	if(v_wpqdid==null||v_wpqdid==""||v_wpqdid.length==0){
		alert("请先保存文书后再进行打印！");
		return false;
	}
	var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}

//从模板中提取
function tqMoban(){
	var obj = new Object();
	var v_zfwsdmz = $("#zfwsdmz").val();
	var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
		+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		param :obj,
		width : 900,
		height : 500,
		url : url
	},function (dialogID){
		var v_retStr = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少
		if(v_retStr!=null && v_retStr.length>0){
			var myrow = v_retStr[0];
			parent.$.messager.progress({
			"text":"数据加载中..."
		});
		var v_zfwsmbid = myrow.zfwsmbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(),{
			'zfwsmbid':v_zfwsmbid
		},function(result){
			if(result.code=='0'){
				var retdata = result.data;
				GloballoadData(retdata);
			}else{
				parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
			}
			parent.$.messager.progress('close');
		},'json');
	}
	})
}

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
			s.type = "ok";       
			sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");   
	}
</script>

</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
	    <input id="userid" name="userid" type="hidden" value="<%=v_userid%>"/>
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="wpqdid" name="wpqdid" type="hidden" value="${mybean.wpqdid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />	
		<input type="hidden" id="wpqdmx_table_rows" name="wpqdmx_table_rows" value="物品清单"/>
		<p class="p1">
			<span class="s1"><input type="text" id="xzjgmc" name="xzjgmc" value="${mybean.xzjgmc}" 
			 			style="width: 200px;"></span>
		</p> 
		<p class="p2">
			<span class="s1">（<%=v_fjcszfwstitle %>）物品清单</span>
		</p>
		<p class="p3">
			<span class="s2">
			<div>
				<div style="display: inline;">文书文号：
				<input type="text" id="wpqdwsbh" name="wpqdwsbh" value="${mybean.wpqdwsbh }" 
			 			style="width: 200px;">
	 			</div>
	 			<div style="display: inline;float:right">第    页，共    页</div>
		 	</div>
		 </span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">当事人：</span>
			<span class="s3"><input type="text" style="width: 175px; text-align: left;"
			name="wppddsr" id="wppddsr" value="${mybean.wppddsr}"></span>
			<span class="s2">地 址：</span>
			<span class="s3"><input type="text" style="width: 290px; text-align: left;"
			name="wppddz" id="wppddz" value="${mybean.wppddz}"></span>
		</p>
		<div id="wpqdmx_table" style="height:450px;overflow:auto;"></div>
		<p class="p5">
			<span class="s2">其它物品：<input type="text" style="width: 700px; text-align:left;"
		name="wpqdqtwp" id="wpqdqtwp" value="${mybean.wpqdqtwp}" /></span>
		</p>
		<p class="p7">
			<span class="s2">上述物品品种、数量经核对无误。</span>
		</p>
		<p class="p5">
			<span class="s2">当事人签字：</span>
			<span class="s3"><input type="text" style="width: 200px; text-align:left;"
			name="wpqddsrqz" id="wpqddsrqz" value="${mybean.wpqddsrqz}" /></span>
			<span class="s2">（签字）</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<span class="s2">执法人员签字：</span>
		<span class="s3"><input type="text" style="width: 100px; text-align:left;"
		name="wpqdzfry1qz" id="wpqdzfry1qz" value="${mybean.wpqdzfry1qz}" /></span>
		<span class="s2">、</span>
		<span class="s3"><input type="text" style="width: 100px; text-align:left;"
		name="wpqdzfry2qz" id="wpqdzfry2qz" value="${mybean.wpqdzfry2qz}" /></span>
		<span class="s2">（签字）</span>
		</p>
		<p class="p7">
			<span class="s2">&times;年&times;月&times;日<input name="wpqddsrqzrq" id="wpqddsrqzrq"
		class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
		style="width: 175px;" value="${mybean.wpqddsrqzrq}" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&times;年&times;月&times;日<input name="wpqdzfryqzrq" id="wpqdzfryqzrq"
		class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
		style="width: 175px;" value="${mybean.wpqdzfryqzrq}" /> </span>
		</p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
<table>
   		<tr align="right" style="height: 60px;">
       <td  align="right">
       		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
              data-options="iconCls:'icon-save'">保存</a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
              data-options="iconCls:'icon-print'">打印</a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
           <a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
              data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
           <a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
              data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		           	           	                
           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
              data-options="iconCls:'icon-back'">关闭</a>
       </td>
   </tr>
</table>
    </form>
</body>
</div>
</html>
