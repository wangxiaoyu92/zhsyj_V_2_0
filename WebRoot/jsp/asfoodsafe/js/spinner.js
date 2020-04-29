//微调数值函数，_obj为对象的ID,isAddZero为是否追加.00
function spinner( _obj,isAddZero,stepVal,minVal,maxVal){
//alert(isAddZero)
        //http://itsuki.iteye.com/blog/986464
        var _this = this;
        this.target = {};
        this.spin_label = null;
       this.step = 1;
        //绑定 上下箭头
        this.bind = function(){
                if (!this.target) return false;
                this.spin_label = document.createElement( "label" );
                this.spin_label.style.cssText = "display:inline-block;z-index:200;color:red;margin-top:-5px;height:34px;cursor:pointer;width:20px;height:20px;overflow:auto;overflow-y:scroll;vertical-align:middle;";
                this.spin_label.innerHTML = "<br/><br/><br/><br/>";
                this.spin_label.onmouseover = function(){
                _this.spin_label.scrollTop = 1;//可以滚动
        }

        //滚动
        this.spin_label.onscroll = function(){
	        if ( _this.spin_label.scrollTop == _this.spin_label.getAttribute("orgscrolltop") )
	        　　　 return;
	
	        if (_this.spin_label.scrollTop!=1){
		        if (!_this.target.value || isNaN(_this.target.value)) 
		        　　　_this.target.value=minVal;
		        
		        if (_this.spin_label.scrollTop==0){
		        	if(isAddZero){//追加.00，返回n.00
		       			_this.target.value =addZero(parseFloat(_this.target.value,10)+_this.step);
		        	}else{//直接返回n+步长
		       			_this.target.value = parseFloat(_this.target.value,10)+_this.step;		       				
		        	}
		        }else{
		        	if(isAddZero){//追加.00，返回n.00
		        		//_this.target.value =addZero(parseFloat(_this.target.value,10)-_this.step);
		        		_this.target.value =parseFloat(_this.target.value,10)-_this.step;
		        		//判断是否<=最小值
			        	if(_this.target.value<=minVal){//<=时直接=最小值
			        		_this.target.value =addZero(parseFloat(minVal,10));
			        	}else{
			        		_this.target.value =addZero(parseFloat(_this.target.value,10));
			        	}
		        	}else{//直接返回n-步长
		        		_this.target.value = parseFloat(_this.target.value,10)-_this.step;
		        		//判断是否<=最小值
			        	if(_this.target.value<=minVal){//<=时直接=最小值
			        		_this.target.value =parseFloat(minVal,10);
			        	}else{
			        		_this.target.value =parseFloat(_this.target.value,10);
			        	}			        
		        	}
		        	
		        	
		        　　　if (parseFloat(_this.target.value,10)<0) 
		        　　　　　_this.target.value=minVal;
		        　}
	        }
	
	        _this.spin_label.setAttribute("orgscrolltop",_this.spin_label.scrollTop);
	        _this.spin_label.scrollTop = 1;
	    }

        if (this.target.nextSibling){
        	this.target.parentNode.insertBefore( this.spin_label , this.target.nextSibling );
        }else{
        	this.target.parentNode.appendChild( this.spin_label );
        }
        }

        if (_obj){
	        this.target = document.getElementById( _obj );
	        this.bind();
        }
}

//追加.00
function addZero(tValue){
	tValue=tValue.toString();
	if(tValue.indexOf(".")==-1){
		tValue=tValue+".00";
	}else {
		var len=tValue.length;
		var pointPosition=tValue.indexOf(".");
		var bb=len-(pointPosition+1);//bb= 小数位数
		if(bb==1){
			tValue=tValue+"0";
		}
	}
	return tValue;
}