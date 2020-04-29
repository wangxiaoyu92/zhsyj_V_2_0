var right = new Object();
right.allBtn = new Object();
right.gridAllBtn = new Object();
right.showDataAttr = function(_this){
	$(right.allBtn).each(function(){
		$(this).hide();
	});
	var tmpAttr = $(_this).attr('data');
	if(tmpAttr==undefined||tmpAttr==null||tmpAttr==""){

		$(_this).attr("onclick","javascript:void(0);");
		$(_this).toggle();
		$(_this).tooltip({
			position: 'top',
			content: '<span style="color:#fff">data属性无.</span>',
			onShow: function(){
				$(_this).tooltip('tip').css({
					backgroundColor: '#666',
					borderColor: '#666'
				});
			}
		});
		return true;
	}else{
		return false;
	}
}
//根据【按钮级权限】控制按钮的显示
right.grantBtnPrivilege = function(){
	$(right.allBtn).each(function(){
		$(this).hide();
	});
	var tmpAttr = '';
	if(menusAll == null){
	}else if(menusAll.length > 0){
		var temp = null;
		$(right.allBtn).each(function(){
			temp = this;
			var flag = true;
			tmpAttr = $(this).attr('data');
			var reason = "";
			if(isDebug){
				if(tmpAttr==undefined||tmpAttr==null||tmpAttr==""){
					reason = ":data属性无.";
				}
			}
			$.each(menusAll,function(n,value) {
				if(tmpAttr == 'btn_' + value.bizid){
					flag = false;
					$(temp).toggle();
				}
			});
			if(flag){
				//$(temp).attr("href","javascript:void(0);");
				$(temp).attr("onclick","javascript:void(0);");
				$(temp).tooltip({
					position: 'top',
					content: "<span style=color:#fff>权限不足."+reason+"</span>",
					onShow: function(){
						$(this).tooltip('tip').css({
							backgroundColor: '#666',
							borderColor: '#666'
						});
					}
				});
				$(temp).css("color","gray");
				$(temp).toggle();
//				$(temp).parent().next().remove();
//				$(temp).parent().remove();
//				$(temp).remove();
			}//end if
		}); //end outer each
	}//end else if
}

right.grantGridBtnPrivilege = function(){
	//jquery easyui datagrid权限控制
	$('.grid').datagrid({
		onLoadSuccess: function (data) {
			//1.隐藏全部按钮
			right.gridAllBtn = $(".datagrid-cell a");
			$(right.gridAllBtn).each(function(){
				$(this).hide();
			});
			//2.根据【按钮级权限】控制按钮的显示

			var tmpAttr = '';

			if(menusAll == null){
			}else if(menusAll.length > 0){
				var temp = null;
				$(right.gridAllBtn).each(function(){
					temp = this;
					var flag = true;
					tmpAttr = $(this).attr('data');
					$.each(menusAll,function(n,value) {
						if(tmpAttr == 'btn_' + value.bizid){
							flag = false;
							$(temp).toggle();
						}
					});
					if(flag){
						$(temp).attr("href","javascript:void(0);");
						$(temp).attr("onclick","javascript:void(0);");
						$(temp).tooltip({
							position: 'top',
							content: '<span style="color:#fff">权限不足.</span>',
							onShow: function(){
								$(this).tooltip('tip').css({
									backgroundColor: '#666',
									borderColor: '#666'
								});
							}
						});
						$(temp).css("color","gray");
						$(temp).toggle();
					}
				});
			}
		}
	});
}
$(window).bind("load",function(){
	if(isDebug){
		right.allBtn = $("a");
	}else{
		right.allBtn = $("a[data^='btn_']");
	}

	right.grantBtnPrivilege();
	right.grantGridBtnPrivilege();
});