<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
%>
<!DOCTYPE html>
<html>
<head>
<title>企业资质证明信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var table; // 数据表格
	var layer; // 弹出层
	// 资质证明
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	// 主体业态
	var zzzmztyt = <%=SysmanageUtil.getAa10toJsonArray("ZZZMZTYT")%>;
	var selectTableDataId = '';
	var mask;
	$(function() {
		if('<%=op%>' == 'view'){
			$("#addZzzm").css('display','none');
			$("#editZzzm").css('display','none');
			$("#delZzzm").css('display','none');
		}
		layui.use(['table', 'layer'],function(){
			table = layui.table;
			layer = layui.layer;
			mask = layer.load(1, {shade: [0.1, '#393D49']});
			table.render({
				elem : '#zzzmTable'
				,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				,url :basePath + 'pcompany/queryPcompanyXkzDTO'
				,where:{'comid' : '<%=v_comid%>'}
				,page : true // 展示分页
				,limit : 10 // 每页展示条数
				,limits : [ 10, 20, 30 ] // 每页条数选择项
				,request: {
					pageName: 'page' //页码的参数名称，默认：page
					,limitName: 'rows' //每页数据量的参数名，默认：limit
				}
				,response : {
					countName : 'total' //数据总数的字段名称，默认：count
					,dataName : 'rows' //数据列表的字段名称，默认：data
				}
				,cols: [[
					{ field : 'comxkzlx', width : 120, title: '资质证明类型' ,hidden : false
						,templet:function(d){
							return sy.formatGridCode(comzzzm, d.comxkzlx);
						}, event: 'trclick'}
					,{ field : 'comxkzbh', width : 140, title: '编号(注册号)' ,hidden : false,event: 'trclick'}
					,{ field : 'comxkyxqq', width : 120, title: '有效期起' ,hidden : false,event: 'trclick'}
					,{ field : 'comxkyxqz', width : 120, title: '有效期至' ,hidden : false,event: 'trclick'}
					,{ field : 'comxkzztyt', width : 100, title: '主体业态' ,hidden : true,
						templet:function(d){
							return sy.formatGridCode(zzzmztyt, d.comxkzztyt);
						}, event: 'trclick'}
					,{ field : 'comxkzjycs', width : 100, title: '经营场所' ,hidden : false,event: 'trclick'}
					,{ field : 'comxkzzcxs', width : 150, title: '组织形式' ,hidden : false,event: 'trclick'}
				]]
				,done:function (res, curr, count) {
					layer.close(mask);
				}
			});
			// 监听工具条
			table.on('tool(tableFilter)', function (obj) {
				var data = obj.data;
				if (obj.event === 'trclick') { // 选中行
					if (selectTableDataId != data.comxkzid) {
						// 清除所有行的样式
						$(".layui-table-body tr").each(function(k, v){
							$(v).removeAttr("style");
						});
						$(obj.tr.selector).css("background", selectTableBackGroundColor);
						table.singleData = data;
						selectTableDataId = data.comxkzid;
					} else { // 再次选中清除样式
						$(obj.tr.selector).attr("style","");
						table.singleData = '';
						selectTableDataId = '';
					}
				}
			});
			var $ = layui.$, active = {
				addZzzm: function(){ // 添加
					addZzzm();
				}
				,editZzzm: function(){ // 修改
					if (!table.singleData) {
						layer.alert('请先选择要修改的资质证明信息！');
					} else {
						editZzzm(table.singleData,table.singleData);
					}
				}
				,delZzzm: function(){ // 删除
					if (!table.singleData) {
						layer.alert('请先选择要删除的资质证明信息！');
					} else {
						delZzzm(table.singleData.comxkzid);
					}
				}
				,viewZzzm: function(){ // 显示
					if (!table.singleData) {
						layer.alert('请先选择要查看的资质证明信息！');
					} else {
						viewZzzm(table.singleData);
					}
				}
			};
			$('.demoTable .layui-btn').on('click', function(){
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
		});
	});

	// 关闭窗口
	var closeWindow = function(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	};

	// 新增
	function addZzzm() {
		parent.sy.modalDialog({
			title : '新增资质证明'
			,area : ['100%','100%']
			,content : basePath + '/pcompany/pcomZzzmFormIndex?comid=<%=v_comid%>'
			,btn : ['保存', '取消'] //可以无限个按钮
			,btn1: function(index, layero){
				parent.window[layero.find('iframe')[0]['name']].submitForm();
			}
		},closeModalDialogCallback);
	}

	function closeModalDialogCallback(dialogID){
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);
		if(obj == null || obj == ''){
			return;
		}
        if (obj.type == "ok") {
            //其他在本页刷新
            var curent=$(".layui-laypage-skip input[class='layui-input']").val();
            refresh('',curent);
        }else {
            //saveOk 在第一页刷新
            refresh('','');
        }

	}
	function refresh(param,cur) {
		table.singleData = '';
		selectTableDataId = '';
		mask = layer.load(1, {shade: [0.1, '#393D49']});
		//删除时 在本页面刷新
		if(cur==""){
			curr=1;
		}else{
			curr=cur;
		}
		table.reload('zzzmTable', {
				url :basePath + 'pcompany/queryPcompanyXkzDTO?comid=<%=v_comid%>'
			, page: {
				curr: curr //重新从第 1 页开始
			}
			, where: param //设定异步数据接口的额外参数
			,done:function () {
				layer.close(mask);
			}
		});
	}
	// 编辑
	function editZzzm(singleData) {
		var v_comid=singleData.comid;
		var v_comxkzid=singleData.comxkzid;
		parent.sy.modalDialog({
			title : '修改资质证明'
			,area : ['100%','100%']
			,content :basePath + '/pcompany/pcomZzzmFormIndex?op=edit&comid='+v_comid+'&comxkzid='+v_comxkzid
			,btn:['保存','取消']
			,btn1: function(index, layero){
				parent.window[layero.find('iframe')[0]['name']].submitForm();
			}
		},closeModalDialogCallback);
	}

	// 查看
	function viewZzzm(singleData) {
		var v_comid=singleData.comid;
		var v_comxkzid=singleData.comxkzid;
		parent.sy.modalDialog({
			title : '查看资质证明'
			,area : ['100%','100%']
			,content :basePath + '/pcompany/pcomZzzmFormIndex?op=view&comid='+v_comid+'&comxkzid='+v_comxkzid
			,btn:['关闭']
		});
	}

	// 删除
	function delZzzm(comxkzid) {
		layer.open({
			title: '警告'
			, content: '你确定要删除该项记录么？'
			, icon: 3
			, btn: ['确定', '取消'] //可以无限个按钮
			, btn1: function (index, layero) {
				$.post(basePath + 'pcompany/delPcompanyXkzDTO', {
							comxkzid: comxkzid
						},
						function (result) {
							if (result.code == '0') {
								table.singleData = '';
								selectTableDataId = '';
								//本页的值
								var curent = $(".layui-laypage-skip input[class='layui-input']").val();
								layer.msg('删除成功', {time: 1000}, function () {
									if (table.cache.zzzmTable.length == 1) {
										curent = curent - 1;
									}
									refresh('', curent);
								});
							} else {
								layer.open({
									title: "提示",
									content: "删除失败：" + result.msg //这里content是一个普通的String
								});
							}
						},
						'json');
			}
		});
	}
	</script>
</head>

<body>
<div class="layui-fluid">
	<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
		<div class="layui-btn-group demoTable">
			<ck:permission biz="addZzzm" >
				<button class="layui-btn" data-type="addZzzm" data="btn_addZzzm" id="addZzzm">增加</button>
			</ck:permission>
			<ck:permission biz="editZzzm" >
				<button class="layui-btn" data-type="editZzzm" data="btn_editZzzm" id="editZzzm">编辑</button>
			</ck:permission>
			<ck:permission biz="delZzzm" >
				<button class="layui-btn layui-btn-danger" data-type="delZzzm" data="btn_delZzzm" id="delZzzm">删除</button>
			</ck:permission>
			<ck:permission biz="viewZzzm" >
				<button class="layui-btn " data-type="viewZzzm" data="btn_viewZzzm">查看</button>
			</ck:permission>
		</div>
	</fieldset>
	<table class="layui-hide" id="zzzmTable" lay-filter="tableFilter"></table>
</div>
</body>
</html>