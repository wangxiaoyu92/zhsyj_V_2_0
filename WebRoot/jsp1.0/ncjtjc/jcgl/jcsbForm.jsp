<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jcsbid = StringHelper.showNull2Empty(request.getParameter("jcsbid"));
%>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
	String aaa027 = StringHelper.showNull2Empty(SysmanageUtil.getSysuser().getAaa027());
%> 
<!DOCTYPE html>
<html>
<head>
<title>聚餐申报编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<script language="javascript" type="text/javascript">         
	window.onload = function(){ 
		//mapInit("mapContainer", 114.357763,35.924515, 10);//汤阴县
		//mapInit("mapContainer", 114.024736,32.980169, 10);//驻马店市
		//mapInit("mapContainer", 115.650497,34.437054, 10);//商丘市
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 12);//根据中心点坐标定位地图
	    mapObj.on('complete', _mapOnload); 
	}	
    
	function _mapOnload(){
	    mapisLoad = true;
	} 
</script>
<script type="text/javascript"> 

	//地理编码	
	function geocoder(address) {
		mapObj.clearMap();  // 清除地图覆盖物
		var MGeocoder; 
		//加载服务
		AMap.service(["AMap.Geocoder"],function() {
			//地理编码插件
			MGeocoder = new AMap.Geocoder({
	            radius: 1000,
	            extensions: "all"
	        }); 
			MGeocoder.getLocation(address,function(status, result) {
				if (status === 'complete' && result.info === 'OK') {
					var geocode = result.geocodes;
					var lng = geocode[0].location.getLng();
					var lat = geocode[0].location.getLat();
					//设置定位坐标
					$('#jdzb').val(lng);
					$('#wdzb').val(lat);

					var title = "聚餐地点定位";
				    var content = [];	    
				    content.push("举办人姓名：" + $('#jcsbjbrxm').val());
				    content.push("举办人手机号：" + $('#jcsbjbrsjh').val());
				    content.push("聚餐地址：" + address); 
			    	addMarker(lng,lat,address,title,content);
			    	//mapObj.setFitView();
				    //mapObj.setZoomAndCenter(14, [lng,lat]);   
			    	mapObj.panTo([lng,lat]);				    	
				}
			});
		});
	}
	
	//逆地理编码
	function geocoderY(lng,lat) {
		if(lng != "" && lat != ""){
			//已知点坐标
			var lnglatXY = new AMap.LngLat(lng,lat);
			var MGeocoder; 
			//加载服务
			AMap.service(["AMap.Geocoder"],function() {
				//地理编码插件
				MGeocoder = new AMap.Geocoder({
		            radius: 1000,
		            extensions: "all"
		        });					
		        MGeocoder.getAddress(lnglatXY, function(status, result){
		        	if(status === 'complete'){
		        		var regeocode = result.regeocode;
		        		var address = regeocode.formattedAddress;
		        		var title = "聚餐地点定位";
					    var content = [];	    
					    content.push("举办人姓名：" + $('#jcsbjbrxm').val());
					    content.push("举办人手机号：" + $('#jcsbjbrsjh').val());
					    content.push("聚餐地址：" + address); 
				    	addMarker(lng,lat,address,title,content);
				    	//mapObj.setFitView();
					    //mapObj.setZoomAndCenter(14, [lng,lat]);   
				    	mapObj.panTo([lng,lat]);
		        	}
				});
			});
		}
	}

	var cluster, markers = [];
    // 添加点聚合
    function addCluster(tag) {
        if (cluster) {
            cluster.setMap(null);
        }
        if (tag == 1) {
            var sts = [{
                url: "http://developer.amap.com/wp-content/uploads/2014/06/1.png",
                size: new AMap.Size(32, 32),
                offset: new AMap.Pixel(-16, -30)
            }, {
                url: "http://developer.amap.com/wp-content/uploads/2014/06/2.png",
                size: new AMap.Size(32, 32),
                offset: new AMap.Pixel(-16, -30)
            }, {
                url: "http://developer.amap.com/wp-content/uploads/2014/06/3.png",
                size: new AMap.Size(48, 48),
                offset: new AMap.Pixel(-24, -45),
                textColor: '#CC0066'
            }];
            mapObj.plugin(["AMap.MarkerClusterer"], function() {
                cluster = new AMap.MarkerClusterer(mapObj, markers, {
                    styles: sts
                });
            });
        } else {
            mapObj.plugin(["AMap.MarkerClusterer"], function() {
                cluster = new AMap.MarkerClusterer(mapObj, markers);
            });
        }
    }

	//地图初始化时，在地图上添加一个marker标记,鼠标点击marker可弹出自定义的信息窗体
	function initialize(mydata) { 
		mapObj.clearMap();  // 清除地图覆盖物
	    // 向地图添加标注点
	    var mapBounds = mapObj.getBounds();
	    var sw = mapBounds.getSouthWest();
	    var ne = mapBounds.getNorthEast();
	    var lngSpan = Math.abs(sw.lng - ne.lng);
	    var latSpan = Math.abs(ne.lat - sw.lat);
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].jcsbjdzb;
		    var lat = mydata[i].jcsbwdzb;
            var address = mydata[i].jcsbjcdd;
			var title = "聚餐地点定位";
		    var content = [];	    
		    content.push("举办人姓名：" + mydata[i].jcsbjbrxm);
		    content.push("举办人手机号：" + mydata[i].jcsbjbrsjh);
		    content.push("聚餐地址：" + address); 
	    	addMarker(lng,lat,address,title,content);   
	    }
	    addCluster(0);
	    mapObj.setFitView(); 				
	}
	
	//添加marker标记
	function addMarker(lng,lat,address,title,content) {
		//mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			//icon: basePath + "images/cljk/img/ss_r_1.png",
			//icon: "http://webapi.amap.com/images/1.png",
			icon: "http://developer.amap.com/wp-content/uploads/2014/06/marker.png",
			position: new AMap.LngLat(lng, lat)
		});
		markers.push(marker);
		//实例化信息窗体
	    var infoWindow = new AMap.InfoWindow({
	        isCustom: true,  //使用自定义窗体
	        content: createInfoWindow(title, content.join("<br/>")),
	        offset: new AMap.Pixel(16, -45)
	    });
		//鼠标点击marker弹出自定义的信息窗体
		AMap.event.addListener(marker, 'mouseover',function() {
			infoWindow.open(mapObj, marker.getPosition());
		});
		//mapObj.setFitView();
	}
</script>
<script type="text/javascript">
	var op = '<%=op%>';
	var jcsbid = '<%=jcsbid%>';
	//下拉框列表
	var jcsbjcgm = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCGM")%>;
	var jcsbjclx = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCLX")%>;
	var jcsbylly = <%=SysmanageUtil.getAa10toJsonArray("JCSBYLLY")%>;
	var jcsbcsly = <%=SysmanageUtil.getAa10toJsonArray("JCSBCSLY")%>;
	var jcsbcyjly = <%=SysmanageUtil.getAa10toJsonArray("JCSBCYJLY")%>;
	var jcsbjccc = <%=SysmanageUtil.getAa10toJsonArray("JCSBJCCC")%>;
	var jcsbcslx = <%=SysmanageUtil.getAa10toJsonArray("JCSBCSLX")%>;
	var jcsbcdlx = <%=SysmanageUtil.getAa10toJsonArray("JCSBCDLX")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;	
	var cb_jcsbjcgm;
	var cb_jcsbjclx;
	var cb_jcsbylly;
	var cb_jcsbcsly;
	var cb_jcsbcyjly;
	var cb_jcsbjccc1;
	var cb_jcsbjccc2;
	var cb_jcsbjccc3;
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var aaa027 = '<%=aaa027%>';

	var jcsbcs_grid;
	var jcsbcd_grid;
	var jcsbpswp_grid;
	$(function() {
		cb_jcsbjcgm = $('#jcsbjcgm').combobox({
	    	data : jcsbjcgm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_jcsbjclx = $('#jcsbjclx').combobox({
	    	data : jcsbjclx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbylly = $('#jcsbylly').combobox({
	    	data : jcsbylly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbcsly = $('#jcsbcsly').combobox({
	    	data : jcsbcsly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbcyjly = $('#jcsbcyjly').combobox({
	    	data : jcsbcyjly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbjccc1 = $('#jcsbjccc1').combobox({
	    	data : jcsbjccc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbjccc2 = $('#jcsbjccc2').combobox({
	    	data : jcsbjccc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_jcsbjccc3 = $('#jcsbjccc3').combobox({
	    	data : jcsbjccc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		getJcsbcs();
		getJcsbcd();
		getJcsbpswp();
				
		if ($('#jcsbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/ncjtjc/jcgl/queryJcsbDTO', {
				jcsbid : $('#jcsbid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					//自动定位
					var lng = $('#jdzb').val();			
					var lat = $('#wdzb').val();
					geocoderY(lng,lat);

					//初始化厨师、菜单、配送物品数据
					jcsbcs_grid.datagrid({
						url : basePath + '/ncjtjc/jcgl/queryJcsbcs',
						queryParams : { 'jcsbid' : jcsbid }		
						
					});
					jcsbcd_grid.datagrid({
						url : basePath + '/ncjtjc/jcgl/queryJcsbcd',
						queryParams : { 'jcsbid' : jcsbid }		
					});
					jcsbpswp_grid.datagrid({
						url : basePath + '/ncjtjc/jcgl/queryJcsbpswp',
						queryParams : { 'jcsbid' : jcsbid }		
					});			
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');

			if(op == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);					
				$('#btn_dtdw').attr('disabled',true);			
				$('#btn_jcsb').attr('disabled',true);
				jcsbcs_grid.datagrid({toolbar: ''});			
				jcsbcd_grid.datagrid({toolbar: ''});			
				jcsbpswp_grid.datagrid({toolbar: ''});			
			}
		}		
	});

	//根据聚餐人数生成聚餐规模
	var makeJcsbjcgm = function() {
		var jcsbjcrs = $('#jcsbjcrs').val();		
		if(jcsbjcrs<100){
			$('#jcsbjcgm').combobox('setValue','1');
		}else if(jcsbjcrs>=100 && jcsbjcrs<300){
			$('#jcsbjcgm').combobox('setValue','2');
		}else if(jcsbjcrs>=300){
			$('#jcsbjcgm').combobox('setValue','3');
		}														
	} 
	
	// 保存 
	var addJcsb = function() {
		var url;
		if($('#jcsbid').val().length > 0){
			url = basePath + '/ncjtjc/jcgl/updateJcsb';
		}else{
			url = basePath + '/ncjtjc/jcgl/addJcsb';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#tabs').tabs('select',2);  
	        			$('#jcsbid').val(result.jcsbid);
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};


	// 关闭窗口
	var closeWindow = function($dialog,$pjq){
    	$dialog.dialog('destroy');
	};

	// 聚餐地点定位
	var geocoders = function(){
		var address = $('#aab301').val();
		//$('#tabs').tabs('select',1);			
		geocoder(address);
	}
</script>
<script type="text/javascript">
	function getJcsbcs(){
		jcsbcs_grid = $('#jcsbcs_grid').datagrid({
			//title : '聚餐申报厨师',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar2',
			//url : basePath + '/ncjtjc/jcgl/queryJcsbcs',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbcsid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报厨师ID',
				field : 'jcsbcsid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			}]],				
			columns : [ [ {
				width : '100',
				title : '厨师ID',
				field : 'csid',
				hidden : true
			},{
				width : '200',
				title : '厨师类型',
				field : 'jcsbcslx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbcslx,value);
				},
				editor : {
					type : 'combobox',
					options : {
						data : jcsbcslx,     
				        valueField : 'id',   
				        textField : 'text',
				        validType :'comboboxNoEmpty',
				        panelHeight : '100' 
					}
				}
			},{
				width : '150',
				title : '厨师姓名',
				field : 'csxm',
				hidden : false
			},{
				width : '100',
				title : '性别',
				field : 'csxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csxb,value);
				}
			},{
				width : '100',
				title : '从业年限',
				field : 'cscynx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cscynx,value);
				}
			},{
				width : '100',
				title : '健康证明',
				field : 'csjkzm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csjkzm,value);
				}
			},{
				width : '100',
				title : '培训情况',
				field : 'cspxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cspxqk,value);
				}
			} ] ],
			onDblClickRow:function(){//双击事件 查看、修改等操作
				if (op!='view' ){
			        var selected = jcsbcs_grid.datagrid('getSelected');
					if(selected){
						mydatagrid_edit(jcsbcs_grid);
					}
				}
		    },
		  	//工具栏
		    toolbar: [{
		    	iconCls: 'icon-add',
		    	text: '选择厨师',
		    	handler: function() {
		    		mydatagrid_selectman('false');
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {
		    		mydatagrid_edit(jcsbcs_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
		    		var row = jcsbcs_grid.datagrid('getSelected');
		    		if(row.jcsbcsid=='' || row.jcsbcsid==null){
		    			mydatagrid_remove(jcsbcs_grid);
		    		}else{
		    			delJcsbcs();
		    		}
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		if(mydatagrid_AllEndEditing(jcsbcs_grid)){
		    			addJcsbcs();
		    		}
		    	}
		    }]		 		    		    
		});
	}
	//从厨师信息表中读取
	function mydatagrid_selectman(singleSelect) {
		var obj = new Object();
		obj.singleSelect == 'true';
		if (singleSelect == 'false') {
			obj.singleSelect = 'false';
		}
		var jscbid=$('#jcsbid').val();
		var url = basePath + "/jsp/pub/pub/selectCs.jsp";
		/* var obj = new Object();
		var v_retStr = popwindow(url,obj,800,500); */
		var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 500,
				url : url
			},function(dialogID){ 
				var k = sy.getWinRet(dialogID); 
				for (var k = 0; k <= v_retStr.length - 1; k++) {
					var myrow = v_retStr[k];
					mydatagrid_selectman_addRow(jcsbcs_grid, myrow);
				}
				sy.removeWinRet(dialogID);			
			});
	} 
	//选择厨师插入对应信息
	function mydatagrid_selectman_addRow(v_grid, v_myrow) {
		var v_csid = v_myrow.csid; 
		var v_csxm = v_myrow.csxm; 
		var v_csxb = v_myrow.csxb; 
		var v_cscynx = v_myrow.cscynx; 
		var v_csjkzm = v_myrow.csjkzm; 
		var v_cspxqk = v_myrow.cspxqk; 

		var v_rowindex;
		v_rowindex = mydatagrid_append(v_grid);
		if (v_rowindex == -1) {
			return false;
		}
		$((v_grid.datagrid('getEditor', {index: v_rowindex,field: 'jcsbcslx'})).target).val(''); 
		v_grid.datagrid('updateRow',{
					index: v_rowindex,
					row: {
						csid: v_csid,
						csxm: v_csxm,
						csxb: v_csxb,
						cscynx: v_cscynx,
						csjkzm: v_csjkzm,
						cspxqk: v_cspxqk
					}
				});

										
		mydatagrid_endEditing(v_grid); 
	} 

	// 提交保存
	var addJcsbcs = function() {
		var rows = jcsbcs_grid.datagrid("getRows");		
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.progress();	// 显示进度条
			$.post(basePath + '/ncjtjc/jcgl/addJcsbcs', {
				jcsbid : $('#jcsbid').val(),
				succJsonStr : succJsonStr
			}, function(result) {
				if (result.code == '0') {		    		        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						jcsbcs_grid.datagrid('reload');
					});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '没有要保存的记录！', 'info');
		}
	};

	// 删除
	var delJcsbcs = function() {
		var row = jcsbcs_grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/jcgl/delJcsbcs', {
						jcsbcsid: row.jcsbcsid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								jcsbcs_grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}		
</script>
<script type="text/javascript">
	function getJcsbcd(){
		jcsbcd_grid = $('#jcsbcd_grid').datagrid({
			//title : '聚餐申报菜单',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar2',
			//url : basePath + '/ncjtjc/jcgl/queryJcsbcd',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbcdid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报菜单ID',
				field : 'jcsbcdid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			}]],				
			columns : [ [ {
				width : '150',
				title : '菜单类型',
				field : 'jcsbcdlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(jcsbcdlx,value);
				},
				editor : {
					type : 'combobox',
					options : {
						data : jcsbcdlx,     
				        valueField : 'id',   
				        textField : 'text',
				        validType :'comboboxNoEmpty',
				        panelHeight : '100' 
					}
				}
			},{
				width : '300',
				title : '菜单名称',
				field : 'jcsbcdmc',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : true,
						validType :'comboboxNoEmpty'
					}
				}
			} ] ],
			onDblClickRow:function(){//双击事件 查看、修改等操作
				if (op!='view' ){
			        var selected = jcsbcd_grid.datagrid('getSelected');
					if(selected){
						mydatagrid_edit(jcsbcd_grid);
						mydatagrid_exceptEndEditing(jcsbcd_grid);
					}
				}
		    },
		  	//工具栏
		    toolbar: [{
		    	iconCls: 'icon-add',
		    	text: '增加',
		    	handler: function() {
		    		mydatagrid_append(jcsbcd_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {
		    		mydatagrid_edit(jcsbcd_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
			    	var row = jcsbcd_grid.datagrid('getSelected');
		    		if(row.jcsbcdid=='' || row.jcsbcdid==null){
		    			mydatagrid_remove(jcsbcd_grid);
		    		}else{
		    			delJcsbcd();
		    		}
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-undo',
		    	text: '取消',
		    	handler: function() {
		    		mydatagrid_reject(jcsbcd_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		if(mydatagrid_endEditing(jcsbcd_grid)){
		    			addJcsbcd();
		    		}
		    	}
		    }]		    		    
		});
	}	

	// 提交保存
	var addJcsbcd = function() {
		var rows = jcsbcd_grid.datagrid("getRows");		
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.progress();	// 显示进度条
			$.post(basePath + '/ncjtjc/jcgl/addJcsbcd', {
				jcsbid : $('#jcsbid').val(),
				succJsonStr : succJsonStr
			}, function(result) {
				if (result.code == '0') {		    		        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						jcsbcd_grid.datagrid('reload');
					});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '没有要保存的记录！', 'info');
		}
	};

	// 删除
	var delJcsbcd = function() {
		var row = jcsbcd_grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/jcgl/delJcsbcd', {
						jcsbcdid: row.jcsbcdid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								jcsbcd_grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}	
</script>
<script type="text/javascript">
	function getJcsbpswp(){
		jcsbpswp_grid = $('#jcsbpswp_grid').datagrid({
			//title : '聚餐申报配送物品',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			//toolbar : '#toolbar2',
			//url : basePath + '/ncjtjc/jcgl/queryJcsbpswp',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcsbpswpid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '聚餐申报配送物品ID',
				field : 'jcsbpswpid',
				hidden : true
			},{
				width : '100',
				title : '聚餐申报ID',
				field : 'jcsbid',
				hidden : true
			}]],				
			columns : [ [ {
				width : '200',
				title : '配送物品名称',
				field : 'jcsbpswpmc',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : true
					}
				}
			},{
				width : '200',
				title : '配送物品品牌',
				field : 'jcsbpswppp',
				hidden : false,
				editor : {
					type : 'text'
				}
			},{
				width : '200',
				title : '配送物品数量',
				field : 'jcsbpswpsl',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : true
					}
				}
			} ] ],
			onDblClickRow:function(){//双击事件 查看、修改等操作
				if (op!='view' ){
			        var selected = jcsbpswp_grid.datagrid('getSelected');
					if(selected){
						mydatagrid_edit(jcsbpswp_grid);
						mydatagrid_exceptEndEditing(jcsbpswp_grid);
					}
				}
		    },
		  	//工具栏
		    toolbar: [{
		    	iconCls: 'icon-add',
		    	text: '增加',
		    	handler: function() {
		    		mydatagrid_append(jcsbpswp_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {
		    		mydatagrid_edit(jcsbpswp_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
			    	var row = jcsbpswp_grid.datagrid('getSelected');
		    		if(row.jcsbpswpid=='' || row.jcsbpswpid==null){
		    			mydatagrid_remove(jcsbpswp_grid);
		    		}else{
		    			delJcsbpswp();
		    		}
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-undo',
		    	text: '取消',
		    	handler: function() {
		    		mydatagrid_reject(jcsbpswp_grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		if(mydatagrid_endEditing(jcsbpswp_grid)){
		    			addJcsbpswp();
		    		}
		    	}
		    }]		    		    
		});
	}	

	// 提交保存
	var addJcsbpswp = function() {
		var rows = jcsbpswp_grid.datagrid("getRows");		
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.progress();	// 显示进度条
			$.post(basePath + '/ncjtjc/jcgl/addJcsbpswp', {
				jcsbid : $('#jcsbid').val(),
				succJsonStr : succJsonStr
			}, function(result) {
				if (result.code == '0') {		    		        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						jcsbpswp_grid.datagrid('reload');
					});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '没有要保存的记录！', 'info');
		}
	};

	// 删除
	var delJcsbpswp = function() {
		var row = jcsbpswp_grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/jcgl/delJcsbpswp', {
						jcsbpswpid: row.jcsbpswpid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								jcsbpswp_grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 	
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">		
		<div id="tabs" class="easyui-tabs" fit="false">
           	<div title="聚餐举办人申报" style="overflow:hidden;">
				<form id="fm" method="post" >	
				<sicp3:groupbox title="聚餐申报信息">
		       		<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>聚餐申报ID:</nobr></td>
							<td><input name="jcsbid" id="jcsbid"  style="width: 175px; " class="input_readonly" readonly="readonly" value="<%=jcsbid%>"/></td>
							<td style="text-align:right;"><nobr>聚餐申报编号:</nobr></td>
							<td><input name="jcsbbh" id="jcsbbh"  style="width: 175px; " class="input_readonly"  readonly="readonly" /></td>																
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>举办人姓名:</nobr></td>
							<td><input name="jcsbjbrxm" id="jcsbjbrxm"   style="width: 175px; " class="easyui-validatebox" data-options="required:true" onblur="getPinYin()" /></td>						
							<td style="text-align:right;"><nobr>举办人手机号:</nobr></td>
							<td><input name="jcsbjbrsjh" id="jcsbjbrsjh"   style="width: 175px; "  /></td>						
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>聚餐类型:</nobr></td>
							<td><input name="jcsbjclx" id="jcsbjclx"  style="width: 175px; "  class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
							<td style="text-align:right;"><nobr>聚餐人数:</nobr></td>
							<td><input name="jcsbjcrs" id="jcsbjcrs"  style="width: 175px; "  class="easyui-validatebox" data-options="required:true"  
								onkeypress="onlyInputNum();" onchange="makeJcsbjcgm(this)" onblur="makeJcsbjcgm(this)"/></td>
						</tr>					
						<tr>
							<td style="text-align:right;"><nobr>厨师来源:</nobr></td>
							<td><input name="jcsbcsly" id="jcsbcsly"   style="width: 175px; " class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
							<td style="text-align:right;"><nobr>聚餐规模:</nobr></td>
							<td><input name="jcsbjcgm" id="jcsbjcgm"  style="width: 175px; "  class="input_readonly"  readonly="readonly"/></td>									
						</tr>			
						<tr>
							<td style="text-align:right;"><nobr>餐饮具来源:</nobr></td>
							<td><input name="jcsbcyjly" id="jcsbcyjly"   style="width: 175px; " class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
							<td style="text-align:right;"><nobr>原料来源:</nobr></td>
							<td><input name="jcsbylly" id="jcsbylly"   style="width: 175px; " class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
						</tr>			
						<tr>
							<td style="text-align:right;"><nobr>聚餐时间1:</nobr></td>
							<td><input name="jcsbjcsj1" id="jcsbjcsj1" style="width: 175px; "  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  /></td>					
							<td style="text-align:right;"><nobr>聚餐餐次1:</nobr></td>
							<td><input name="jcsbjccc1" id="jcsbjccc1" style="width: 175px; "  /></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>聚餐时间2:</nobr></td>
							<td><input name="jcsbjcsj2" id="jcsbjcsj2" style="width: 175px; "  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  /></td>					
							<td style="text-align:right;"><nobr>聚餐餐次2:</nobr></td>
							<td><input name="jcsbjccc2" id="jcsbjccc2" style="width: 175px; "  /></td>
						</tr>
						<tr>				
							<td style="text-align:right;"><nobr>聚餐时间3:</nobr></td>
							<td><input name="jcsbjcsj3" id="jcsbjcsj3" style="width: 175px; "  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" /></td>
							<td style="text-align:right;"><nobr>聚餐餐次3:</nobr></td>
							<td><input name="jcsbjccc3" id="jcsbjccc3" style="width: 175px; "  /></td>					
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
							<td>
								<input name="aaa027name" id="aaa027name"  style="width: 175px; " onclick="showMenu_aaa027();" 
								   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
								<input name="aaa027" id="aaa027"  type="hidden"/>
								<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
									<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
								</div>							
							</td>
							<td style="text-align:right;"><nobr>所属机构:</nobr></td>
							<td>
								<input name="orgname" id="orgname"  style="width: 175px; " onclick="showMenu_sysorg();" 
								   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
								<input name="orgid" id="orgid"  type="hidden"/>
								<div id="menuContent_sysorg" class="menuContent" style="display:none; position: absolute;">
									<ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
								</div>							
							</td>				
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>聚餐地点:</nobr></td>
							<td colspan="2"><input name="aab301" id="aab301" style="width: 99%; "  /></td>
							<td>
								<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_dtdw"
									iconCls="icon-search" onclick="geocoders()"> 地图定位 </a>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>聚餐地点经度坐标</nobr></td>
							<td><input name="jcsbjdzb" id="jdzb"  style="width: 175px; " class="easyui-validatebox" data-options="required:true"  readonly="readonly" /></td>	
							<td style="text-align:right;"><nobr>聚餐地点纬度坐标</nobr></td>
							<td><input name="jcsbwdzb" id="wdzb"  style="width: 175px; " class="easyui-validatebox" data-options="required:true"  readonly="readonly" /></td>					
						</tr>					
						<tr>
							<td style="text-align:right;"><nobr>备注:</nobr></td>
							<td colspan="3"><input name="aae013" id="aae013" style="width: 99%;  "/></td>									
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>经办人:</nobr></td>
							<td><input name="aae011" id="aae011" style="width: 175px; " class="input_readonly" readonly="readonly"   /></td>					
							<td style="text-align:right;"><nobr>经办时间:</nobr></td>
							<td><input name="aae036" id="aae036" style="width: 175px; " class="input_readonly" readonly="readonly"   /></td>
						</tr>							
					</table>
					<br/><br/><br/>							       	       
			        <div style="text-align:right">
			        	<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_jcsb"
							iconCls="icon-save" onclick="addJcsb()">提交保存</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        </div>
			        <br/>		
		        </sicp3:groupbox> 
				</form>
		    </div>
		    <div title="聚餐地图定位"  style="overflow:hidden;">
				<sicp3:groupbox title="地图信息">				
			        <!--地图容器-->
				    <div id="mapContainer" style="width:98%;height:600px;border:#ccc solid 2px;">
				         &nbsp;
				    </div>
				    <div id="result"> </div>
			    	<div id="result1"> </div>
			    </sicp3:groupbox> 
		    </div>
		    <div title="聚餐厨师申报"  style="overflow:hidden;">
				<sicp3:groupbox title="厨师申报信息">				
			        <div id="jcsbcs_grid" style="height:400px;overflow:auto;"></div>
			    </sicp3:groupbox> 
		    </div>
		    <div title="聚餐菜单申报"  style="overflow:hidden;">
				<sicp3:groupbox title="菜单申报信息">				
			        <div id="jcsbcd_grid" style="height:400px;overflow:auto;"></div>				  
			    </sicp3:groupbox> 
		    </div>
		    <div title="配送物品申报"  style="overflow:hidden;">
				<sicp3:groupbox title="配送物品信息">				
			        <div id="jcsbpswp_grid" style="height:400px;overflow:auto;"></div>				  
			    </sicp3:groupbox> 
		    </div>
		</div>    
    </div>    
</body>
</html>
