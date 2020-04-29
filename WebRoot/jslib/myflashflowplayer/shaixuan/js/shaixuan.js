window.onload = function(){ 
	inputSearchData();
};

function inputSearchData(){
	/**
	 * 加载筛选数据
	 */
	$.ajax({
		url : BasePath + 'controlunitdtoAction!notAuth_getScreenData.action',
		dataType : 'json',
		success : function(data) {
			var rs = data[0].children;
			if(rs!=null&&typeof(rs) != "undefined"&&rs.length>0){
				for(var i = 0;i<rs.length;i++){
					$('#shaixuan_tabs').append('<a id="sxTab_'+rs[i].id+'" class="tabs " onclick="setSelected(this);" href="javascript:void(0)" data-id="pLocation_'+rs[i].id+'">'+rs[i].text+'<I class="sect-up"></I></a>');
					var ch = rs[i].children;
					if(ch!=null&&typeof(ch) != "undefined"&&ch.length>0){
						$('#J_locationFilterWraper').append('<div class="filter-item filter-item-administrative" id="pLocation_'+rs[i].id+'" style="display:none;"><div><div class="filter-administrative-txt" id="sx_xzq_'+rs[i].id+'">');
						$('#sx_xzq_'+rs[i].id).append('<span class="name">行政区：</span>');
						for(var j = 0;j<ch.length;j++){
							$('#sx_xzq_'+rs[i].id).append('<a id="region_'+ch[j].id+'" class="region tag" href="javascript:search({\'name\':\'region\',\'val\':\''+ch[j].id+'\'});">'+ch[j].text+'</a>');
						}
						$('#J_locationFilterWraper').append('</div></div></div>');
					}
				}
			}
			//setSelected("#sxTab_"+rs[0].id);
		}
	});
}

/**
 * 标签切换
 * @param obj
 */
function setSelected(obj){
	$(obj).parent('div').find('a').removeClass("cur");
	$(obj).parent('div').find('a').find("i").attr("class", "sect-up");
	$(obj).addClass("cur");
	$(obj).find("i").attr("class", "sect-down");
	$("div[id^='pLocation_']").attr("style", "display:none;");
	var pLocation = $(obj).data('id');
	$("#" + pLocation).attr("style", "display:;");
	var this_id = $(obj).attr("id");
	regionVal = this_id.split("_")[1];
	search({'name':'sxTab','val':regionVal});
}

var regionVal;
var regionName;

function search(con) {
	if(con.name=="region"&&con.val==regionVal){
		return;
	}
	$('a[id^="'+con.name+'"]').each(function(){
		if($(this).attr("id")==con.name+"_"+con.val){
			$(this).addClass("selected");
		}else{
			if($(this).hasClass("selected")){
				$(this).removeClass("selected");
			}
		}
	}); 
	regionVal = con.val;
	LoadPageInation();
}

function searchByOrgName(){
	regionName = $("#search_keyword").val();
	LoadPageInation();
}
