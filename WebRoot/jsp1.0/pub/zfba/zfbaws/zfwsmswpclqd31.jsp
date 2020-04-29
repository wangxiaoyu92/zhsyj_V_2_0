<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsmswpclqd31DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
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
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 没收物品处理清单
	Zfwsmswpclqd31DTO dto = new Zfwsmswpclqd31DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsmswpclqd31DTO) request.getAttribute("mybean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.5416667in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{margin-top:0.21666667in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{margin-top:0.108333334in;text-align:center;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p7{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.td1{width:1.0354167in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-right:thin solid black;
		border-top:thin solid black;}
.td2{width:0.66736114in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td3{width:0.5159722in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td4{width:0.7395833in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td5{width:0.84791666in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.76944447in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td7{width:0.72986114in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-top:thin solid black;}
.r1{keep-together:always;}
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

	var v_mswpclqdid = $("#mswpclqdid").val();
	if (v_mswpclqdid==null || v_mswpclqdid=="" || v_mswpclqdid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	
    //没收物品处理清单
    var v_mswpclqkmxb_table=$("#mswpclqkmxb_table");
    v_mswpclqkmxb_table.datagrid({
        //title: '没收物品处理清单',
		//title: '用户列表',
		//iconCls: 'icon-tip',
		url:basePath+'/pub/wsgldy/queryZfwsmswpclqdmx?ajdjid=<%=v_ajdjid%>',
		striped : true,// 奇偶行使用不同背景色
		singleSelect : true,// True只允许选中一行
		checkOnSelect : false,
		selectOnCheck : false,			
		//pagination : true,// 底部显示分页栏
		//pageSize : 10,
		//pageList : [ 10, 20, 30 ],
		rownumbers : true,// 是否显示行号
		fitColumns : false,// 列自适应宽度			
	    idField: 'mswpmxbid', //该列是一个唯一列
	    sortOrder: 'asc',	
        columns: [[
        	{title: '物品名称', 
        	 field: 'mswpmxbid', 
        	 hidden:true
        	 },
            {title: '物品名称', 
        	 field: 'msmxwpmc', 
             align: 'center', 
        	 width: 150, 
        	 editor: "textarea"
        	},
            {title: '文本编号', 
        	 field: 'msmxgg', 
        	 align: 'center', 
        	 width: 80, 
        	 editor: "textarea"
        	},
            {title: '单位', 
        	 field: 'msmxdw', 
        	 align: 'center', 
        	 width: 60, 
        	 editor: "textarea"
        	 },
            {title: '数量', 
        	 field: 'msmxsl', 
        	 align: 'center', 
        	 width: 60, 
        	 editor: "textarea"
        	 },
            {title: '处理方式', 
        	 field: 'msmxclfs', 
        	 align: 'center', 
        	 width: 80, 
        	 editor: "textarea"
        	 },
            {title: '地点', 
        	 field: 'msmxdd', 
        	 align: 'center', 
        	 width: 150, 
        	 editor: "textarea"
        	 },
            {title: '经办人', 
        	 field: 'msmxjbr', 
        	 align: 'center', 
        	 width: 60, 
        	 editor: "textarea"
        	 },
            {title: '备注', 
        	 field: 'msmxbz', 
        	 align: 'center', 
        	 width: 80, 
        	 editor: "textarea"
        	 }  
        ]],
            onDblClickRow: function () {//双击事件 查看、修改等操作
                var selected = v_mswpclqkmxb_table.datagrid('getSelected');
                if (selected) {
                    mydatagrid_edit(v_mswpclqkmxb_table);
                }
            },
            //工具栏
            toolbar: [{
                iconCls: 'icon-add',
                text: '增加',
                handler: function () {
                    mydatagrid_append(v_mswpclqkmxb_table);
                }
            }, '-',
                {
                    iconCls: 'icon-edit',
                    text: '修改',
                    handler: function () {
                        mydatagrid_edit(v_mswpclqkmxb_table);
                    }
                }, '-',
                {
                    iconCls: 'icon-remove',
                    text: '删除',
                    handler: function () {
                        mydatagrid_remove(v_mswpclqkmxb_table);
                    }
                }, '-',
                {
                    iconCls: 'icon-undo',
                    text: '取消',
                    handler: function () {
                        mydatagrid_reject(v_mswpclqkmxb_table);
                    }
                }
                , '-',
                {
                    iconCls: 'icon-save',
                    text: '保存',
                    handler: function () {
                        mydatagrid_accept(v_mswpclqkmxb_table);
                    }
                }
            ]
    });      
});

//单击某行进行编辑
function mydatagrid_edit(v_datagrid) {
    var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
    if (index == -1) {
        alert("请先选择行");
        return false;
    }
    v_datagrid.datagrid('selectRow', index)
            .datagrid('beginEdit', index);
}

//增加一行
function mydatagrid_append(v_datagrid) {
    var editIndex = -1;
    if (mydatagrid_endEditing(v_datagrid)) {
        v_datagrid.datagrid('appendRow', {});
        editIndex = v_datagrid.datagrid('getRows').length - 1;
        v_datagrid.datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
    return editIndex;
}
    
//编辑状态
function mydatagrid_endEditing(v_datagrid) {
    var editIndex = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));

    //if (editIndex==undefined){return true}
    if (v_datagrid.datagrid('validateRow', editIndex)) {
        var ed = v_datagrid.datagrid('getEditor', {index: editIndex});
        v_datagrid.datagrid('endEdit', editIndex);
        //editIndex=undefined;
        return true;
    } else {
        return false;
    }
}
    
//删除一行
function mydatagrid_remove(v_datagrid) {
    var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
    if (index == -1) {
        alert("请先选择行");
        return false;
    }

    v_datagrid.datagrid('cancelEdit', index)
            .datagrid('deleteRow', index);
    if (index - 1 >= 0) {
        v_datagrid.datagrid('selectRow', index - 1);
    }
}
    
//撤销编辑
function mydatagrid_reject(v_datagrid) {
    var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
    if (index == -1) {
        alert("请先选择行");
        return false;
    }
    //v_datagrid.datagrid('cancelEdit',index);
    v_datagrid.datagrid('rejectChanges');
    // editIndex=undefined;
}
    
//保存
function mydatagrid_accept(v_datagrid) {
    if (mydatagrid_endEditing(v_datagrid)) {
        v_datagrid.datagrid('acceptChagnes');
    }
}

/**
 * 保存
 */
function mysave(){
		var url='<%=basePath%>pub/wsgldy/saveZfwsmswpclqd';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
          mydatagrid_endEditing($('#mswpclqkmxb_table'));
          var v_mswpclqkmxb_rows = $('#mswpclqkmxb_table').datagrid('getRows');
          $('#mswpclqkmxb_table_rows').val($.toJSON(v_mswpclqkmxb_rows));
		
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
			 		$("#mswpclqdid").val(result.mswpclqdid);			 		
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
    var v_mswpclqdid=$("#mswpclqdid").val(); 
	var url="<%=basePath%>pub/wsgldy/zfwsmswpclqdPrintIndex?ajdjid="+v_ajdjid+"&zfwsqtbid="
		+v_mswpclqdid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		}); 
}
/**
 * 另存为模板
 */
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
    var v_mswpclqdid = $("#mswpclqdid").val();
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    if (v_mswpclqdid==null || v_mswpclqdid=="" || v_mswpclqdid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
    	return false;
    }
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
		
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}
/**
 * 从模板提取
 */
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
		if (v_retStr!=null && v_retStr.length>0){
	   	var myrow = v_retStr[0];
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		var v_zfwsmbid = myrow.zfwsmbid;
		var v_zfwsqtbid = myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			laspid: $("#laspid").val(),
			ajdjid : $("#ajdjid").val()
		}, 
		function(result) {
			if (result.code == '0') {			
				var retdata = result.data;
				GloballoadData(retdata);
			} else {
				parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
		    }	
			parent.$.messager.progress('close');
		}, 'json');
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
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="mswpclqdid" name="mswpclqdid" type="hidden" value="${mybean.mswpclqdid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />	
		<input type="hidden" id="mswpclqkmxb_table_rows" name="mswpclqkmxb_table_rows" value="没收物品处理清单"/>
		<p class="p1">
			<span class="s1"><input type="text" id="xzjgmc" name="xzjgmc" 
				style="width: 300px;" value="${mybean.xzjgmc}"/></span>
		</p>
		<p class="p2"><span class="s1">没收物品处理清单</span></p>
		<div align="right">
			<p class="p3"><span class="s2">                               
				<input type="text" id="msclwsbh" name="msclwsbh" 
				style="width: 260px;text-align: right;" value="${mybean.msclwsbh}"/>
				</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">根据<input type="text" style="width: 240px; text-align: left;" 
			name="msclxzcfjdsbh" id="msclxzcfjdsbh" value="${mybean.msclxzcfjdsbh}">《行政处罚决定书》</span>
		</p>
		<p class="p5">
			<span class="s2">当事人：<input type="text" style="width: 175px; text-align: left;" 
			name="mscldsr" id="mscldsr" value="${mybean.mscldsr}">            
			地 址：<input type="text" style="width: 290px; text-align: left;" 
			name="mscldsrdz" id="mscldsrdz" value="${mybean.mscldsrdz}">                     
			电话：<input type="text" style="width: 150px; text-align: left;" 
			name="mscldsrdh" id="mscldsrdh"value="${mybean.mscldsrdh}">
			</span>
		</p>
		<p class="p5">
			<span class="s2">执行处置单位：<input type="text" style="width: 150px; text-align: left;" 
			name="msclzxczdw" id="msclzxczdw" value="${mybean.msclzxczdw}">       
			地 址：<input type="text" style="width: 300px; text-align: left;" 
			name="msclczdwdz" id="msclczdwdz" value="${mybean.msclczdwdz}">                       
			电话：<input type="text" style="width: 150px; text-align: left;" 
			name="msclczdwdh" id="msclczdwdh" value="${mybean.msclczdwdh}">
			</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6">
			<span class="s1">没收物品处理情况明细表</span>
		</p>
		<div id="mswpclqkmxb_table" style="height:350px;overflow:auto;"></div>
		<p class="p5"></p>
		<p class="p5">
			<span class="s2">特邀参加人：<input type="text" style="width: 200px; text-align:left;" 
			name="mscltycjr" id="mscltycjr" value="${mybean.mscltycjr}"> （签字）     
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			承办人：<input type="text" style="width: 150px; text-align:left;" 
			name="msclcbr" id="msclcbr" value="${mybean.msclcbr}">  
			 <input type="text" style="width: 150px; text-align:left;" 
			name="msclcbr2" id="msclcbr2" value="${mybean.msclcbr2}"> （签字）  </span>
		</p>
		<p class="p7">
			<span class="s2">&times;年&times;月&times;日<input name="mscltycjrrq" id="mscltycjrrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			style="width: 175px;" value="${mybean.mscltycjrrq}" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&times;年&times;月&times;日<input name="msclcbrrq" id="msclcbrrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			style="width: 175px;" value="${mybean.msclcbrrq}" >
			</span>
		</p>
		<p class="p8"></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<table>
		   <tr align="right" style="height: 60px;">
		       <td  align="right">
		       <% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
		       		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
		              data-options="iconCls:'icon-save'">保存</a>
               <%} %>
		           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		           <a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
		              data-options="iconCls:'icon-print'">打印</a>
	           <% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>   
	           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
	           		<a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
	             	 data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
	           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	           		<a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
	              	data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
	            <%} %>
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
