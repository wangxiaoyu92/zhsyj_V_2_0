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
<%
	//商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	String v_spsjlx = StringHelper.showNull2Empty(request.getParameter("spsjlx"));//商品数据类型
	if (v_spsjlx==null || "".equals(v_spsjlx)){
		v_spsjlx="0";
	}	
	String v_spsjlxmc="商品";
	if ("1".equals(v_spsjlx)){
		v_spsjlxmc="产品";
	}else if ("2".equals(v_spsjlx)){
		v_spsjlxmc="原材料";
	}

	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
	String v_title=v_spsjlxmc+"管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 查看";
	}	
	

%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        var v_jcyplb= <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
        var v_jcypgl= <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;
        var v_spfenlei= <%=SysmanageUtil.getAa10toJsonArray("SPFENLEI")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function() {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false ; //进来后，立马把锁锁住
                    $.post(basePath + 'jyjc/saveJyjcyp', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                if(''==('<%=op%>')){
                                    obj.type = "saveOk";
                                }else {
                                    obj.type="ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });

                //将数据加载到编辑页面的表单中
                var jcypid = '<%=jcypid%>';
                if (jcypid != null && jcypid.length > 0) {
                    $.post(basePath + 'jyjc/queryJyjcypDTO', {
                            jcypid: jcypid   //(将数据库中值通过此id传给前段页面)
                        },
                        function (result) {
                            if (result.code == '0') {
                                $('form').form('load', result.data);
                                form.render();
                                var sppicpath = $("#sppicpath").val();
                                if (sppicpath != "") {
                                    $("#sppic").attr("src", "<%=contextPath%>"+sppicpath);
                                };
//								$("#jcxmbh").val();
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查询失败：" + result.msg //这里content是一个普通的String
                                });
                                /*					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');*/
                            }

                        }, 'json');
                    if('<%=op%>' == 'view'){
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly','readonly');
                        $('form :selected').attr('disabled',true);
                        $('.Wdate').attr('disabled',true);
                        $("#btnselectcom").attr("readonly",'readonly');
                        $("#comxkyxqz").datebox({
                            disabled:true
                        });
                        $('#jcypgl').attr('disabled',true);
                        $('#jcyplb').attr('disabled',true);
                        $('#spfenlei').attr('disabled',true);
                        $("a[id='btnselectcom']").hide()
                        $("td[name='btntd']").hide();
                    }
                } else {

                }


            });
            intSelectData('jcyplb',v_jcyplb);
            intSelectData('jcypgl',v_jcypgl);
            intSelectData('spfenlei',v_spfenlei);
        })
        function submitForm() {
            $("#saveRoleBtn").click();
        }
        // 关闭窗口
        function closeWindow(){
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        //获取上传的图片
        function showUploadFj(jcypid){
            if(jcypid!='' && jcypid!=null){
                $.post(basePath + '/jyjc/queryFjViewList', {
                        'jcypid':jcypid
                    },
                    function(result) {
                        var mydata = result.data;
                        if(mydata!=null){
                            var playerHtml = '';
                            for(var i=0;i<mydata.length;i++){
                                var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + mydata[i].fjpath;
                                playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl +"')\"><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  mydata[i].fjpath + "\"/></a></div>";
                            }
                            $('#picbox').append(playerHtml);
                        }else{
                            $('#picbox').append("暂未上传图片！");
                        }
                    },'json');
            }
        }
        // 上传图片附件
        function uploadFjViewCanNoId(prm_fjtype){
            var v_fjwid=$("#jcypid").val();
//            obj.uploadOne="yes";//yes 或 no
            parent.sy.modalDialog({
                type : 2,
                title : '上传图片附件'
                ,param :{
                    folderName :"shangpin",
                    fjwid :v_fjwid,
                    fjtype :prm_fjtype,
                    uploadOne : "yes"
				},
                area : ['100%', '100%']
                ,content : basePath + "pub/pub/uploadFjViewIndex"
                ,btn:['关闭']
            },function(dialogID){
                var retVal = parent.sy.getWinRet(dialogID);
                parent.sy.removeWinRet(dialogID);//不可缺少
                if(retVal != null){
                    if(retVal.type == 'ok'){
                        if (prm_fjtype=="8"){//商品图片
                            $("#sppicpath").val(retVal.fjpath);
                            $("#sppicname").val(retVal.fjname);
                            $("#sppic").attr("src", "<%=contextPath%>"+retVal.fjpath);
                        }
                    }
                    if(retVal.type == 'deleteok'){
                        var v_defaultpic="/images/default.jpg";
                        if (prm_fjtype=="8"){//商品图片
                            $("#sppicpath").val("");
                            $("#sppicname").val("");
                            $("#spfenlei").attr("src", "<%=contextPath%>"+v_defaultpic);
                        }
                    }
                }
            });
        };
        //预览图片
        function showPic(imgUrl){
            var dialog = parent.sy.modalDialog({
                title : '图片预览',
                width : 800,
                height : 600,
                url : imgUrl
            });
        }
	</script>
</head>

<body>
<form class="layui-form" action="" id="jyjcyp">
		<input type="hidden" id="jcypid" name="jcypid">
		<input type="hidden" id="userid" name="userid" >
		<input type="hidden" id="hviewjgztid" name="hviewjgztid" >
		<input type="hidden" id="jcypczy" name="jcypczy" >
		<input type="hidden" id="jcypczsj" name="jcypczsj" >
		<input type="hidden" id="spsjlx" name="spsjlx" value="<%=v_spsjlx%>">
		<table class="layui-table" lay-skin="nob">
			<tr>
				<td style="text-align:right;width: 141px"><font class="myred">*</font>类别:</td>
				<td>
					<select id="jcyplb" name="jcyplb" lay-verify="required">
					</select>
				</td>
				<td rowspan="3" colspan="1" style="text-align: center;width: 279px">
					<div style="text-align: center;" id="qymtzzhaopian_div" >
						<img src="<%=contextPath%>/images/default.jpg" name="sppic" id="sppic" height="130" width="150"
							 onclick="g_showBigPic(this.src);" />
					</div>
					<a id="btnselectcom" href="javascript:void(0)"
					   class="layui-btn" iconCls="icon-upload"
					   onclick="uploadFjViewCanNoId(8)">选择商品图片</a>
					<input type="hidden" id="sppicpath" name="sppicpath">
					<input type="hidden" id="sppicname" name="sppicname">
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>名称:</td>
				<td >
					<input type="text" id="jcypmc" name="jcypmc" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>归类:</td>
				<td>
					<select id="jcypgl" name="jcypgl"  lay-verify="required">

					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;width: 110px"><font class="myred">*</font>分类:</td>
				<td colspan="2">
					<select id="spfenlei" name="spfenlei"  lay-verify="required">

					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>所属品牌:</td>
				<td colspan="2">
					<input type="text" id="jcypsspp" name="jcypsspp" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr style="text-align:right">
				<td>规格:</td>
				<td colspan="2">
					<input type="text" id="impcpgg" name="impcpgg"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>商标:</td>
				<td colspan="2">
					<input type="text" id="spsb" name="spsb" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right">规格型号:</td>
				<td colspan="2">
					<input type="text" id="spggxh" name="spggxh"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>计量单位:</td>
				<td colspan="2">
					<input type="text" id="spjldw" name="spjldw" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>执行标准号:</td>
				<td colspan="2">
					<input type="text" id="spzxbzh" name="spzxbzh" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
			<tr>
				<td style="text-align:right"><font class="myred">*</font>保质期:</td>
				<td colspan="2">
					<input type="text" id="spbzq" name="spbzq" lay-verify="required"
						   autocomplete="off" class="layui-input" >
				</td>
			</tr>
		</table>
		<div class="layui-form-item" style="display: none">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="saveRole"
						id="saveRoleBtn">保存</button>
			</div>
		</div>

</form>
</body>

</html>