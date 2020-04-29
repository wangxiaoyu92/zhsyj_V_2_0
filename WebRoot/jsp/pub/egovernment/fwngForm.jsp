<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
	String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String v_transfrom=StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_nodename=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
	String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
	String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	
	//获取分支节点流向值
	WorkflowService v_WorkflowService=new WorkflowService();
	List<Wf_node_trans> v_listWf_node_trans=(List<Wf_node_trans>)v_WorkflowService.queryWfnodeTransList(v_psbh,v_transfrom);
	String areaName=SysmanageUtil.getAreaName();
	String v_nextchecked="";
	int v_transCount=0;
	if (v_listWf_node_trans!=null){
	   v_transCount=v_listWf_node_trans.size();
	   if (v_transCount==1){
		   v_nextchecked="checked='checked'";
	   }
	   
	}	
%>
<!DOCTYPE html>
<html>
<head>
	<!--拟文编辑或者核搞编辑-->
<title>公文流程办理：<%=v_nodename %></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        $(function () {
            gongwen();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;

                $.post(basePath + '/workflow/queryYwlclog', {
                    ywbh: '<%=v_ywbh%>'
                }, function (result) {
//                    alert(result.size);
                    if (result.code == '0') {
                        var data = result.rows;
                        for(var i=0;i<data.length;i++) {
                            if (data[i].nodeid == 25) {
                                $("#createUser").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 28) {
                                $("#manuscript").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 37) {
                                $("#issue").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 37) {
                                $("#issue").html(data[0].aae011)
                            }
                            console.log(data);


                        }

                    }
                }, 'json')
            })

            var text;
            $.ajax({
                type:'POST',
                url:basePath + '/egovernment/archive/queryArchiveDTO',
                dataType:'json',
                data:{ archiveid:'<%=v_ajdjid%>'},
                async:false,
                success:function(result){
                    var mydata = result.data;
                    text=mydata.archivetitle;
                    $("#orgid2").val(result.orgid);
                    $("#orgname2").val(result.orgname);
                }
            });
            $.ajax({
                type:'POST',
                url:basePath + '/sysmanager/sysorg/queryS',
                dataType:'json',
                data:{ },
                async:false,
                success:function(result){
                   var fz=result.fz;
                    $("#kz2").val(fz);
                }
            });
            $("#biaoti").html(text);
            $("#transyy").val("同意");
        })

	</script>
	<style>
		.layui-table td {
			border-color: #ff0000;
		}
		.font_main {
			color: #ff0000;
			font-size: 15pt;
		}
		.font_main_title {
			color: #ff0000;
			font-size: 25pt;
		}

		.margin_main_line {
			margin-left: 10%;
		}
		.margin_main_line_1 {
			margin-left: 35%;
		}
	</style>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
var layer;
function gongwen(){

	layui.use([ 'layer'], function () {
				layer = layui.layer;}
	);
	document.getElementById("ajslcommonframe").src='<%=basePath%>egovernment/archive/archiveayFormIndex?op=view&archiveid=' + '<%=v_ajdjid%>';
    var text;
    var huigao;
    var  miji;
    var  qixian;
    var  dmyj;
    var  zhusong;
    var   chaosong;
    var   dazhi;
    var   xiaodui;
    var   fenshu;
    var  fawen;
    var   fawen1;
    var  fawen2;
    var shijian;
    var nian;
    var yue;
    var ri;
    var ztci;
    var newDate;


    $.ajax({
        type:'POST',
        url:basePath + '/egovernment/archive/queryArchiveDTO',
        dataType:'json',
        data:{ archiveid:'<%=v_ajdjid%>'},
        async:false,
        success:function(result){
            var mydata = result.data;
            text=mydata.archivetitle;

            huigao=mydata.huigao;
            miji=mydata.rank;
            qixian=mydata.term;
            dmyj=mydata.fixedbasis;
            zhusong=mydata.maindelivery;
            chaosong=mydata.copy;
            dazhi=mydata.typing;
            xiaodui=mydata.proofreading;
            fenshu=mydata.number;
            fawen=mydata.writing1;
            fawen1=mydata.writing2;
            fawen2=mydata.writing3;
            shijian=mydata.sealtime;
            var val = Date.parse(shijian);
            newDate = new Date(val);
            ztci=mydata.thematicwords;
        }
    });
    $("#biaoti").html(text);
    $("#huigao").html(huigao);
    $("#miji").html(miji);
    $("#qixian").html(qixian);
    $("#dmyj").html(dmyj);
    $("#zhusong").html(zhusong);
    $("#chaosong").html(chaosong);
    $("#dazhi").html(dazhi);
    $("#xiaodui").html(xiaodui);
    $("#fenshu").html(fenshu);
    $("#fawen3").html(fawen);
    $("#fawen1").html(fawen1);
    $("#fawen2").html(fawen2);
    $("#nian").html(newDate.getFullYear());
    $("#yue").html(newDate.getMonth()+1);
    $("#ri").html(newDate.getDate());
    $("#ztci").html(ztci);
    fj();
    fjqt();
};

//提交流程
function tijiaoliucheng(){
	var v_transname ="";
	v_transname=$('#xuanzeliuxiang input[name="transname"]:checked ').val();
	if (v_transname==undefined){
		alert("请选择办理流向");
		return false;
	}
    var cyryid ="";
    var kz2=$("#kz2").val();
    var kz=$("#kz").val();
    if(kz2 != null&&kz2 != ""){
        if(kz != null&&kz != ""){
            cyryid=kz2+","+kz;
        }else{
            cyryid=kz2;
		}
	}else{
        if(kz != null&&kz != ""){
            cyryid=kz;
		}
	}
    var cuserid =$("#cyryid").val();
       var cfmMsg = "确定要提交流程吗?";
        var v_transyy = $("#transyy").val();

        var v_transval = "七日内做出决定";
        var v_shifouTongguo = "1";
        var v_url = encodeURI("<%=basePath%>/egovernment/archive/updateArchive?archiveid=<%=v_ajdjid%>&archivestate=1");
        var v_url2 = encodeURI(encodeURI("<%=basePath%>workflow/doWffwprocess?ywlcid=<%=v_ywlcid%>&transval=" + v_transval + "&shifouTongguo=" + v_shifouTongguo + "&cuserid=" + cuserid + "&ywlcuserid=" + cyryid+ "&transname=" + v_transname + "&transyy=" + v_transyy + "&time=" + new Date().getMilliseconds()));
        $.messager.confirm('确认', cfmMsg, function (r) {
            if (r) {

                $.ajax({
                    url: v_url,
                    type: 'post',
                    async: true,
                    cache: false,
                    timeout: 100000,
                    success: function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            $.ajax({
                                url: v_url2,
                                type: 'post',
                                async: true,
                                cache: false,
                                timeout: 100000,
                                //data:formData,
                                success: function (result) {
                                    result = $.parseJSON(result);
                                    if (result.code == '0') {
                                        layer.confirm('提示! 提交流程成功！', {
                                            btn: ['确定'] //按钮
                                        }, function () {
                                            window.parent.location.reload();
                                            var index = parent.layer.getFrameIndex(window.name);
                                            parent.layer.close(index);
                                        });
                                    } else {
                                        parent.$.messager.alert();
                                        layer.alert('提示!-提交流程失败：' + result.msg);
                                    }
                                }

                            });
                        } else {
                            parent.$.messager.alert('提示', '提交流程失败：' + result.msg, 'error');
                        }
                    }

                });


            }
        })

}
function fj() {
    var html="";
    $.ajax({
        type:'POST',
        url:basePath + '/workflow/FJ',
        dataType:'json',
        data:{ fjwid:'<%=v_ajdjid%>'},
        async:false,
        success:function(result){
            var mydata = result.data;
            for(var i=0;i<mydata.length;i++){
                var a=mydata[i].fjname;
                var b=mydata[i].fjpath;
                html+="<a href='javascript:;' onclick=check('"+b+"')>"+a+"</a></br>";

            }
        }
    });
    $("#ceshi").html(html);
}
var closeWindow = function(){
//	window.parent.location.reload();
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
};

function myselectAjdjXgry_layui(prm_rykind) {
    var v_useridstr = $("#workTaskDutyPerson").val();
    var url = "<%=basePath%>jsp/pub/pub/selectuserMoregw.jsp?useridstr=" + v_useridstr + "&a=" + new Date().getMilliseconds();
    var v_comrcjdglryid = "";
    var v_comrcjdglryname = "";
    sy.modalDialog({
        title: '选择人员'
        , area: ['100%', '100%']
        , content: url
        , btn: ['保存']
        , btn1: function (index, layero) {
            window[layero.find('iframe')[0]['name']].queding();
        }
    }, function (dialogID) {
        var v_retStr = sy.getWinRet(dialogID);
        sy.removeWinRet(dialogID);//不可缺少

        if (v_retStr != null && v_retStr.length > 0) {
            for (var k = 0; k <= v_retStr.length - 1; k++) {
                var myrow = v_retStr[k];
                if ("" == v_comrcjdglryid) {
                    v_comrcjdglryid = myrow.userid;
                    v_comrcjdglryname = myrow.description;
                } else {
                    v_comrcjdglryid = v_comrcjdglryid + "," + myrow.userid;
                    v_comrcjdglryname = v_comrcjdglryname + "," + myrow.description;
                }
            }
            $("#cyry").val(v_comrcjdglryname);
            $("#cyryid").val(v_comrcjdglryid);
        }
    });
}
// 上传图片附件
function uploadFjView(type) {
    var id = "<%=v_ajdjid%>"
    var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
    parent.sy.modalDialog({
        area: ['100%', '100%'],
        title: '上传正文附件'
        , content: url
        , param: {
            folderName: "writing",
            fjwid: id,
            fjtype: type
        }
    }, function (dialogID) {
        var obj = sy.getWinRet(dialogID);
        if (obj == null || obj == '') {
            return;
        }
        if (obj.type == "ok") {
            var myrow = obj.data;
            /*$("#ceshi").html(myrow.fjpath);*/ //人员id
            var html = $("#ceshi").html();
            html = "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
            $("#ceshi").html(html);
        }
        sy.removeWinRet(dialogID);//不可缺少
        if (obj != null) {
            if (obj.type == 'ok') {
                //
            }
        }
    });
}


function uploadFjViewqt(type) {

    var id = "<%=v_ajdjid%>"
    var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
    parent.sy.modalDialog({
        area: ['100%', '100%'],
        title: '上传其它附件'
        , content: url
        , param: {
            folderName: "writing",
            fjwid: id,
            fjtype: type
        }
    }, function (dialogID) {
        var obj = sy.getWinRet(dialogID);
        if (obj == null || obj == '') {
            return;
        }
        if (obj.type == "ok") {
            var myrow = obj.data;
            /*$("#ceshi").html(myrow.fjpath);*/ //人员id
            var html = $("#ceshinew").html();
            html += "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
            $("#ceshinew").html(html);
        }
        sy.removeWinRet(dialogID);//不可缺少
        if (obj != null) {
            if (obj.type == 'ok') {
                //
            }
        }
    });
}
function fj() {
    var html = "";
    $.ajax({
        type: 'POST',
        url: basePath + '/workflow/FJ',
        dataType: 'json',
        data: {fjwid: '<%=v_ajdjid%>', fjtype:'GWZWFJ'},
        async: false,
        success: function (result) {
            var mydata = result.data;
            for (var i = 0; i < mydata.length; i++) {
                var a = mydata[i].fjname;
                var b = mydata[i].fjpath;
                html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

            }
        }
    });
    $("#ceshi").html(html);
}
function fjqt() {
    var html = "";
    $.ajax({
        type: 'POST',
        url: basePath + '/workflow/FJ',
        dataType: 'json',
        data: {fjwid: '<%=v_ajdjid%>',
            fjtype:'GWQTFJ'
        },
        async: false,
        success: function (result) {
            var mydata = result.data;
            for (var i = 0; i < mydata.length; i++) {
                var a = mydata[i].fjname;
                var b = mydata[i].fjpath;
                html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

            }
        }
    });
    $("#ceshinew").html(html);
}
function check(s) {
    window.open(s);

}
function showMenu_aaa027new() {
    layer.open({
        type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        ,
        area: ['300px', '400px']
        ,
        title: '选择分类'
        ,

        content: basePath + 'jsp/pub/pub/selectgworg.jsp'
        ,
        shade: [0.8, 'gray'] // 遮罩
        ,
        btn: ['确定', '退出']
        ,
        yes: function (index) {
            //当点击‘确定’按钮的时候，获取弹出层返回的值
            var v_retObj = window["layui-layer-iframe" + index].myqueding();
            //打印返回的值，看是否有我们想返回的值。
            if (v_retObj != null) {
                $("#orgid").val(v_retObj.orgid);
                $("#orgname").val(v_retObj.orgname);
                $("#kz").val(v_retObj.fz);
            }
            //最后关闭弹出层
            layer.close(index);
        },
        cancel: function () {
            //右上角关闭回调
        }
    });
}
function showMenu_aaa027new2() {
    layer.open({
        type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        ,
        area: ['300px', '400px']
        ,
        title: '选择分类'
        ,

        content: basePath + 'jsp/pub/pub/selectgworg.jsp'
        ,
        shade: [0.8, 'gray'] // 遮罩
        ,
        btn: ['确定', '退出']
        ,
        yes: function (index) {
            debugger
            //当点击‘确定’按钮的时候，获取弹出层返回的值
            var v_retObj = window["layui-layer-iframe" + index].myqueding();
            //打印返回的值，看是否有我们想返回的值。
            if (v_retObj != null) {
                $("#orgid2").val(v_retObj.orgid);
                $("#orgname2").val(v_retObj.orgname);
                $("#kz2").val(v_retObj.fz);
            }
            //最后关闭弹出层
            layer.close(index);
        },
        cancel: function () {
            //右上角关闭回调
        }
    });
}
</script>
</head>
<body>
<iframe name="ajslcommonframe" id="ajslcommonframe" src="" width="100%" height="800px;"  scrolling="no" frameborder="0" ></iframe>
	<div style="text-align: center;">
    <sicp3:groupbox title="">   
     <table width="100%" height="60px;">
      <tr>
        <td width="15%" align="right">请选择下一节点流向：</td>
        <td width="88%" align="left">
	     <div id="xuanzeliuxiang">
		      <%for (Wf_node_trans v_Wf_node_trans:v_listWf_node_trans){%>
		         <input type="radio" name="transname" <%=v_nextchecked%> id="transname"  value="<%=v_Wf_node_trans.getTransname() %>" style="cursor: pointer;"/><%=v_Wf_node_trans.getTransname() %>&nbsp;&nbsp;&nbsp;&nbsp;
		      <%} %>                      
	     </div>	         
        </td>
      </tr>

       <tr>
         <td align="right">
                             处理意见： 
         </td>
         <td align="left">
			 <textarea class="layui-textarea" id="transyy" name="transyy"></textarea>
         </td>
       </tr>
		 <tr></tr>
		 <tr>
			 <td align="right">
				 主科室：
			 </td>
			 <td align="left">
					 <%--<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;"
                               rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>--%>
				 <div class="layui-input-inline">
					 <input name="orgname2" id="orgname2" onclick="showMenu_aaa027new2();"
							readonly="readonly" class="layui-input layui-bg-gray" lay-verify="required" style="width: 800px"/>
					 <input name="orgid2" id="orgid2" type="hidden"/>
					 <input name="kz2" id="kz2" type="hidden"/>
				 </div>
				 <div id="menuContent_aaa027new2" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
					 <div class="layui-side-scroll" style="width:250px;">
						 <ul id="treeDemo_aaa027new2" class="ztree"></ul>
					 </div>
				 </div>
			 </td>
		 </tr>
		 <tr>
			 <td align="right">
				 其它科室：
			 </td>
			 <td align="left">
					 <%--<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;"
                               rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>--%>
				 <div class="layui-input-inline">
					 <input name="orgname" id="orgname" onclick="showMenu_aaa027new();"
							readonly="readonly" class="layui-input layui-bg-gray" lay-verify="required" style="width: 800px"/>
					 <input name="orgid" id="orgid" type="hidden"/>
					 <input name="kz" id="kz" type="hidden"/>
				 </div>
				 <div id="menuContent_aaa027new" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
					 <div class="layui-side-scroll" style="width:250px;">
						 <ul id="treeDemo_aaa027new" class="ztree"></ul>
					 </div>
				 </div>
			 </td>
		 </tr>
		 <tr>
			 <td align="right">主管领导:</td>
			 <td>
				 <div class="layui-form-item">
					 <div class="layui-input-inline">
						 <input type="hidden" id="fileid" name="fileid" value="<%=v_ajdjid%>"/>
						 <input type="text" id="cyry" name="cyry"
								autocomplete="off" class="layui-input" style="width: 300px;" readonly="readonly">
						 <input id="cyryid" name="cyryid" type="hidden"/>
					 </div>
					 <div class="layui-input-inline" style="padding-left:80px">
						 &nbsp;
						 <a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
							iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
						 &nbsp;&nbsp;
						 <a href="javascript:void(0)" class="layui-btn" id="remove"
							iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
					 </div>
				 </div>
			 </td>
		 </tr>
     </table>			

	</sicp3:groupbox>	
	</div>
	<div style="text-align: center;height: 100px">
	<br>
		<button class="layui-btn"  id="saveBtn" onclick="tijiaoliucheng()">提交流程</button>
		<button class="layui-btn" id="BtnFanhui" onclick="closeWindow()">关闭</button>
	</div>

<%if (areaName.contains("安阳")) {%>
<center><span class="font_main_title">安阳市食品药品监督管理局拟稿稿纸</span></center>
<%}%>
<%if (areaName.contains("中牟")) {%>
<center><span class="font_main_title">中牟市食品药品监督管理局拟稿稿纸</span></center>
<%}%>
<form class="layui-form" action="" id="fawen">
	<table class="layui-table">
		<tr>
			<td colspan="2" style="text-align:left;width: 60%">
				<span class="font_main">拟稿人:</span><span id="createUser"></span><br/>
				<span class="font_main">核稿人:</span><span id="manuscript"></span>

			</td>
			<td  rowspan="3" colspan="2" style="text-align: left">
				<span class="font_main" style="padding-top: 50px">签发:</span><span id="issue"></span>

			</td>
		</tr>
		</tr>
		<tr>
			<td  colspan="2" style="text-align:left;width: 60%">
				<span class="font_main">合法性审查:</span><br/>
				<br/>
				<br/>

			</td>
		</tr>
		<tr>
			<td  colspan="2" style="text-align:left;width: 60%"><span class="font_main">办公室审核:</span></td>

		</tr>
		<tr>
			<td colspan="2" rowspan="2" style="text-align:left;"><span class="font_main">会稿:</span><span id="huigao"></span></td>

			<td ><span class="font_main">密级:<span id="miji"></span></span>
			</td>
			<td ><span class="font_main">期限:</span><span id="qixian"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2"><span class="font_main">定密依据:</span><span id="dmyj"></span>
			</td>

		</tr>
		<tr>
			<td rowspan="2" style="text-align:right;width:5%"><span class="font_main">发<br/>送<br/>机<br/>关</span></td>
			<td  colspan="3"><span class="font_main">主送</span><span id="zhusong"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="3"><span class="font_main">抄送</span><span id="chaosong"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">打字:</span><span id="dazhi"></span>
				<span class="font_main margin_main_line_1">核对:</span><span id="xiaodui"></span>
				<span class="font_main margin_main_line_1">份数:</span><span id="fenshu"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<%if (areaName.contains("安阳")) {%>
				<span class="font_main">发文: </span><span class="font_main margin_main_line">安</span><span id="fawen3"></span>
				<%}%>
				<%if (areaName.contains("中牟")) {%>
				<span class="font_main">发文: </span><span class="font_main margin_main_line">中</span><span id="fawen3"></span>
				<%}%>
                <span class="font_main margin_main_line">(</span><span id="fawen1"></span>
                <span class="font_main margin_main_line">) </span><span id="fawen2"></span>
                <span class="font_main margin_main_line">号 </span></span><span id="nian"></span>
                <span class="font_main margin_main_line">年 </span><span id="yue"></span>
                <span class="font_main margin_main_line">月  </span><span id="ri"></span>
                <span class="font_main margin_main_line">日
				<span class="font_main margin_main_line">封发</span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">标题:</span><br/><br/>
				<span  id="biaoti"></span>
			</td>
		</tr>
		<tr>
			<td  colspan="2">
				<span class="font_main">正文附件:</span><br/><br/>
                <a id="btnselectcom" href="javascript:void(0)"
                   class="layui-btn" iconCls="icon-upload"
				   onclick="uploadFjView('GWZWFJ')">上传正文附件</a><br/>


                <span id="ceshi"></span>
			</td>
			<td  colspan="2">
				<span class="font_main">其它附件:</span><br/><br/>
				<a id="btnselectcom2" href="javascript:void(0)"
				   class="layui-btn" iconCls="icon-upload"
				   onclick="uploadFjViewqt('GWQTFJ')">上传其它附件</a><br/>
				<span id="ceshinew"></span>
			</td>
		</tr>
		<tr>
			<td  colspan="4">
                <span class="font_main">主题词:</span><span id="ztci"></span><br/><br/>

			</td>
		</tr>
	</table>
</form>
</body>
</html>