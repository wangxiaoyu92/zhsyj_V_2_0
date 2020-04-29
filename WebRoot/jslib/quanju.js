function myShowModalDialog(prm_url,prm_obj,prm_width,prm_height){
    var v_left=(screen.availWidth-prm_width)/2;
    var v_top=(screen.availHeight-prm_height)/2;
    
    var style = "help:no;status:no;scroll:auto;dialogWidth:"+prm_width+"px;dialogHeight:"+
                prm_height+"px;dialogTop:"+v_top+"px;dialogLeft:"+
                v_left+"px;resizable:yes;center:yes";   

	var k=window.showModalDialog(prm_url,prm_obj, style);
	return k;   
};

g_formatterDate = function (date) {
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	var hor = date.getHours()>9?date.getHours():"0"+date.getHours();
	var min = date.getMinutes()>9?date.getMinutes():"0"+date.getMinutes();
	var sec = date.getSeconds()>9?date.getSeconds():"0"+date.getSeconds();
	return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
	};
	
function quanjuYanZhengPassword(){
	var location = (window.location+'').split('/'); 
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 	
	
	var prm_width=300;
	var prm_height=170;
	var prm_obj=null;
	
	var prm_url=basePath+'/jsp/pub/pub/yanZhengPassword.jsp';
    var v_left=(screen.availWidth-prm_width)/2;
    var v_top=(screen.availHeight-prm_height)/2;
    
    var style = "help:no;status:no;scroll:no;dialogWidth:"+prm_width+"px;dialogHeight:"+
         prm_height+"px;dialogTop:"+v_top+"px;dialogLeft:"+
                v_left+"px;resizable:no;center:yes;location=no;";   

    return window.showModalDialog(prm_url,prm_obj, style);
	
}

function quanjuYanZhengPassword2(){
	var location = (window.location+'').split('/'); 
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 	
	var prm_url=basePath+'/jsp/pub/pub/yanZhengPassword.jsp';
	
	var dialog = parent.sy.modalDialog({
		title : '',
		width : 360,
		height : 270,
		url : prm_url,
		buttons : [ {
			text : '确定',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.queding(dialog,parent.$);
			}
		},{
			text : '取消',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.quxiao(dialog, parent.$);
			}
		} ]		
	});
}

//gu20160413$('form').form('load',data);不起作用，所以用这个方法
function GloballoadData(jsonStr){
    var obj = eval("("+jsonStr+")");
    var key,value,tagName,type,arr;
    for(x in obj){
        key = x;
        value = obj[x];
        if (value!=null && value!="null" && value!="" && value!=-1 && key.toLowerCase()!="ajdjid") { //guadd 
        $("[name='"+key+"'],[name='"+key+"[]']").each(function(){
            tagName = $(this)[0].tagName;
            type = $(this).attr('type');
            if(tagName=='INPUT'){
                if(type=='radio'){
                    $(this).attr('checked',$(this).val()==value);
                }else if(type=='checkbox'){
                    arr = value.split(',');
                    for(var i =0;i<arr.length;i++){
                        if($(this).val()==arr[i]){
                            $(this).attr('checked',true);
                            break;
                        }
                    }
                }else{
                    $(this).val(value);
                }
            }else if(tagName=='SELECT' || tagName=='TEXTAREA'){
                $(this).val(value);
            }
             
        });
        };//guaddend
    }
};

function shiFouWeiKong(data){ 
  return (data == "" || data == undefined || data == null) ? true : false; 
};

function g_GetDateStr(AddDayCount) {   
	   var dd = new Date();  
	   dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期  
	   var y = dd.getFullYear();   
	   var m = (dd.getMonth()+1)<10?"0"+(dd.getMonth()+1):(dd.getMonth()+1);//获取当前月份的日期，不足10补0  
	   var d = dd.getDate()<10?"0"+dd.getDate():dd.getDate();//获取当前几号，不足10补0  
	   return y+"-"+m+"-"+d;   
	};  

//得到当前日期
g_formatterDate = function() {
  var v_date=new Date();	
  var day = v_date.getDate() > 9 ? v_date.getDate() : "0" + v_date.getDate();
  var month = (v_date.getMonth() + 1) > 9 ? (v_date.getMonth() + 1) : "0"
  + (v_date.getMonth() + 1);
  return v_date.getFullYear() + '-' + month + '-' + day;
};	


