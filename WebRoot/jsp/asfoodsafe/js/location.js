
function mygetlocation(){
	navigator.geolocation.getCurrentPosition(showPosition);
}

function showPosition(position){
	var latitude = position.coords.latitude; 
	var longitude = position.coords.longitude; 
		//创建对象实例
		geocoder = new qq.maps.Geocoder({
			//若服务请求成功，则运行以下函数，并将结果传入
			complete:function(result){
				ajaxAddr(result.detail.address);
			},
			//若服务请求失败，则运行以下函数
			error:function(){
				//alert('出错啦~');
			}
		});

		//创建坐标对象
		var coord=new qq.maps.LatLng(latitude,longitude);
		//通过经纬度得到其位置信息
		geocoder.getAddress(coord);	
}


function ajaxAddr(addr){
	//if(sym_state=="ok"){
		$.ajax({
				//url:encodeURI(encodeURI(v_local_path+"/common/sjb/saveQsymqrylog?qrysym="+v_local_sym+"&qryposition ="+addr+"&time="+new Date().getMilliseconds())),
			    url:encodeURI(encodeURI(v_local_path+"/common/sjb/saveQsymqrylog?qrysym="+v_local_sym+"&qryposition="+addr+"&time="+new Date().getMilliseconds())),
				type:'post',
				async:true,
				cache:false,
				timeout: 100000,
				data:'',
				error:function(){
					//alert("服务器繁忙，请稍后再试！");
				},
				success: function(result){
			        if(result.code=="1"){
			        	//alert("成功！");
			        }
			     }
		      });	
		
		
	//}
}