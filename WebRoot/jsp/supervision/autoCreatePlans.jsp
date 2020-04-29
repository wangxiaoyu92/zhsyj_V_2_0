<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>自动生成检查计划</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
    var obj = new Object();

    var v_planTypeParam=<%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
    var v_orgPropParam=<%=SysmanageUtil.getAa10toJsonArray("ORGPROP")%>;

    var form;
    $(function () {

        layui.use(['form', 'table', 'element', 'laydate'], function () {
            form = layui.form;
            var layer = layui.layer
                , table = layui.table
                , element = layui.element
                , laydate = layui.laydate;

            element.init();
            queryOnePlanDTO();
            //监听提交
            form.on('submit(btnquery)', function (data) {
                mygetgriddata();
                return false;
            });
            //下拉列表选择事件
            form.on('select(sel_enableflag_filter)', function (data) {
                v_sel_enableflag = data.value;
                //categoryName = data.elem[data.elem.selectedIndex].text;
                //form.render('select');
            });

            //年选择器
            laydate.render({
                elem: '#planYear'
                , type: 'year'
            });

            form.on('select(oneType)', function (data) {
                queryTwoPlanDTO('');
            });
            form.on('select(twoType)', function (data) {
                queryThreePlanDTO('');
            });

            intSelectData("sel_plantype",v_planTypeParam);
            intSelectData("sel_orgprop",v_orgPropParam);
            //createCheckGroup();

            form.render();//重新渲染，否则select不出来

        })
    });//////////////////////////

    //获得一级分类
    function queryOnePlanDTO() {
        $.post(basePath + 'supervision/queryOnePlanDTO', {
                itempid: '0000000000000000000000000'
            },
            function (result) {
                if (result.code == '0') {
                    var mydata = result.data;
                    $('#oneType').append("<option   value=''>--请选择--</option>");
                    for (var i = 0; i < mydata.length; i++) {
                        $('#oneType').append("<option   value='" + mydata[i].itemid + "'>" + mydata[i].itemname + "</option>");
                    }
                    form.render('select');
                    //有数值
/*                    if (str != null && str != "") {
                        getitemsByid(str);
                    }*/
                }
            }, 'json');
    }
    //二级类别
    function queryTwoPlanDTO(str) {
        var v_plantype=$("#sel_plantype").val();
        if (v_plantype==null || v_plantype.length==0){
            alert("请选择 检查计划类别");
            return false;
		}
        var checkValue = $("#oneType").val();


        if (checkValue == "" || checkValue == null) {
            var oldvalue = $('#selecttext').val();
            $('#twoType').empty();
            $('#twoTypeselect').css('display', 'none');
            if (oldvalue != null && oldvalue != "") {
                $('.' + oldvalue).css('display', 'none');
            }
            allitems = "";
        } else {
            $('#oneitempid').val(checkValue);
            $('#twoTypeselect').css('display', '');
//隐藏
            var oldvalue = $('#selecttext').val();
            if (oldvalue != null && oldvalue != "") {
                $('.' + oldvalue).css('display', 'none');
            }
            $.post(basePath + 'supervision/queryOnePlanDTO', {
                    itempid: checkValue
				    //itemtype:v_plantype //gu20180328
                },
                function (result) {
                    if (result.code == '0') {
                        //var mydata = result.data;
                        b_twotypedata=result.data;//gu20180324
                        if (b_twotypedata.length > 0) {
                            $('#twoType').empty();
                            $('#twoType').append("<option   value=''>--请选择--</option>");
                            for (var i = 0; i < b_twotypedata.length; i++) {
                                $('#twoType').append("<option   value='" + b_twotypedata[i].itemid + "'>" + b_twotypedata[i].itemname + "</option>");
                            }
                            form.render('select');
                            //有数值
                            if (str != null && str != "") {
                                $("#twoType").val(str[0].itempid);
                                //queryThreePlanDTO(str);
                            }
                        } else {
                            $('#twoType').empty();
                            $('#twoTypeselect').css('display', 'none');
                        }
                    }
                }, 'json');

        }
    }

    //获取检查类型check
    function createCheckGroup() {
        $("#plantypediv").empty();
        if (v_planType.length > 0) {
            for (var i = 0; i < v_planType.length; i++) {
                var v_id=v_planType[i].id;
                if (v_id != null && v_id != ""){
                    $("#plantypediv").append("<input type='checkbox' name='plantype' id='"
                        + v_planType[i].id + "' value='" + v_planType[i].id + "' title='" + v_planType[i].text + " '/>");
                }
            }
            layui.form.render('checkbox');
        }
    };

	// 创建检查计划
    function autoCreatePlans () {
        var v_planYear=$("#planYear").val();
        if (v_planYear==null || v_planYear.length==0){
            alert("请选择 检查计划年度");
            return false;
        };
        //var v_plantype = getPlantypeValues();
        var v_orgprop=$("#sel_orgprop").val();
        if (v_orgprop==null || v_orgprop.length==0){
            alert("请选择 科室属性");
            return false;
        };
		 var v_plantype=$("#sel_plantype").val();
        if (v_plantype==null || v_plantype.length==0){
            alert("请选择 计划类别");
            return false;
		};
        var v_itemid=$("#twoType").val();
        if (v_itemid==null || v_itemid.length==0){
            alert("请选择 执行范围");
            return false;
        };
		var url = basePath + 'supervision/autoCreatePlansTwo';
//		return;
		//提交一个有效并且避免重复提交的表单
		//$pjq.messager.progress();	// 显示进度条
		$.ajax({
			type : "POST",
			url : url,
			data : {
			    planYear : v_planYear,
				planType : v_plantype,
				itemid:v_itemid,
		        orgprop:v_orgprop
			},
			traditional : true,
			success : function(result){
				//$pjq.messager.progress('close');// 隐藏进度条
				result = $.parseJSON(result);
                if (result.code == '0') {
                    layer.msg('保存成功', {time: 500}, function () {
                        obj.type = "ok";
                        sy.setWinRet(obj);
                        closeWindow();
                    });
                } else {
                    layer.open({
                        title: '提示'
                        , content: '保存失败' + result.msg
                    });
                }
			}
		});
	};

    // 关闭窗口
    function closeWindow() {
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    }

	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}

    //复选框取值
    function getPlantypeValues() {
        var obj = document.getElementsByName("plantype");
        var check_val = '';
        var check = 0;
        for (k in obj) {
            if (obj[k].checked) {
                check += 1;
                check_val += obj[k].value + ',';
            }
        }
        if (check == 0) {
            return null;
        }
        return check_val;
    }


</script>

</head>
<body>
   <form class="layui-form" action="">
	   <div class="layui-form-item">
		   <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>检查计划年度:</label>
		   <div class="layui-input-inline">
			   <input class="layui-input" name="planYear" id="planYear" lay-verify="planYear" placeholder="yyyy" readonly="readonly" type="text" >
		   </div>
	   </div>
	   <div class="layui-form-item">
		   <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>科室属性:</label>
		   <div class="layui-input-inline">
			   <select lay-filter="sel_orgprop_filter" id="sel_orgprop" name="sel_orgprop" style="width: 200px;">
			   </select>
		   </div>
	   </div>
	   <div class="layui-form-item">
		   <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>检查计划类别:</label>
		   <div class="layui-input-inline">
<%--			   <div id="plantypediv" style="width:100%"></div>--%>
			   <select lay-filter="sel_planType_filter" id="sel_plantype" name="sel_plantype" style="width: 200px;">
			   </select>
		   </div>
	   </div>

	   <div class="layui-form-item">
		   <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>执行范围:</label>
		   <div class="layui-input-inline">
			   <select id="oneType" name="oneType" lay-filter="oneType"></select>
		   </div>
		   <div id="twoTypeselect" class="layui-input-inline" style="display: none;width: 300px;" >
			   <select style="width: 300px;" name="twoType" id="twoType" lay-filter="twoType"></select>
		   </div>
	   </div>
   </form>

</body>
</html>