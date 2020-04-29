/**
 * 公共组件
 * 注意：需要定义var app_param={};app_param.path = '项目路径';
 */
h = {};

var module={};
module.cms = 'cms';//信息发布
module.jtyyc = 'jtyyc';//集体营养餐
module.mclz = 'mclz';//明厨亮灶
module.jtjc = 'jtjc';//集体聚餐
module.cam = 'mclz.camera';//集体聚餐

var pageOpt = {
	dom: '#Pagination',//需要分页的元素id，若使用class选择器则可写作.Pagination
	url: '',
	pageIndex: 0,
	pageSize: 10,
	pageCount: 0,
	prev_text: '上一页',
	next_text: '下一页',
	num_display_entries: '6',//连续分页主体部分分页条目数
	num_edge_entries: '2'	//两侧首尾分页条目数   
};
var favlikeOpt = {
	title: '',
	rid: '',//外键
	url: '',//要访问的URL，例如：点赞，记录当前信息的URL，以便直接访问
	module: '',//模块,信息发布：cms,集体营养餐:jtyyc等
	type: ''//点赞/喜欢:0,踩:1,收藏:2
	
};
var discussOpt = {
	title: '',
	url : '',
	rid: '',//外键
	content: ''//评论内容
};
var scoreOpt = {
	rid: '',//外键
	score: ''//分数
	};
//翻页调用  
function PageCallback(index, jq) {             
	initPageData(index);  
}
function mslScore(id,rid){
	var hints = ['很差','较差','一般','推荐','力荐'];
	var action = "scoreAction!notAuth_get.action";
	$.ajax({   
        type: "POST",  
        dataType: "json",  
        url: action,      //提交到一般处理程序请求数据  
        data : {rid:rid},   //提交1个参数：rid                 
        success: function(data) {
        	$('#'+id).raty({hints:hints,score:data,click:function(score,event){
        		layer.confirm('您的打分：'+score+'分，确定提交吗?', function(index){
        			h.component.saveScore({rid:rid,score:score},function(data){
        				if (data.status!='success'){
        					mslScore(id,rid);
        				}else{
        					$('#'+id).raty({hints:hints,readOnly: true, score: score });
        				}
        			});
        			layer.close(index);
        		},function(){
        			mslScore(id,rid);
        		}); 
        	}});
        }  
    });
}
h.component = {
    /**
     * 创建分页
     * @param options
     * @param data
     */
    initPageInation: function(options,data) {
        var opts = $.extend(pageOpt, options);
        var url = opts.url;
        var t = {};
    	if(data!=null){
    		data.page = opts.pageIndex+1;
        	data.rows = opts.pageSize;
        	t = data;
    	}else{
    		t.page = opts.pageIndex+1;
        	t.rows = opts.pageSize;
    	}
        $.ajax({   
            type: "POST",  
            dataType: "json",  
            url: url,      //提交到一般处理程序请求数据  
            data : t,   //提交两个参数：pageIndex(页面索引)，pageSize(显示条数)                  
            success: function(data) {
            	pageCount = data.obj;
            	$(opts.dom).pagination(pageCount, {  
    	            callback: PageCallback,  
    	            prev_text: opts.prev_text,       //上一页按钮里text  
    	            next_text: opts.next_text,       //下一页按钮里text  
    	            items_per_page: opts.pageSize,  //显示条数  
    	            num_display_entries: opts.num_display_entries,    //连续分页主体部分分页条目数  
    	            current_page: opts.pageIndex,   //当前页索引  
    	            num_edge_entries: opts.num_edge_entries       //两侧首尾分页条目数   
    	        });
            }  
        });
    },
    /**
     * 初始化分页数据
     * @param options
     * @param data
     * @param callback
     */
    initPageData: function(options,data,callback){
    	var opts = $.extend(pageOpt, options);
    	var url = opts.url;
    	var t = {};
    	if(typeof(data)=='function'){
    		t.page = opts.pageIndex+1;
        	t.rows = opts.pageSize;
        	callback = data;
    	}else{
    		data.page = opts.pageIndex+1;
        	data.rows = opts.pageSize;
        	t = data;
    	}
    	$.ajax({   
            type: "POST",  
            dataType: "json",  
            url: url,      //提交到一般处理程序请求数据  
            data : t,         //提交两个参数：pageIndex(页面索引)，pageSize(显示条数)                  
            success: function(data) {
            	callback(data);
            }
    	});
    },
    /**
     * 收藏、点赞/喜欢、踩、浏览等功能
     * @param options
     */
    favlike : function(options,callback){
    	var opts = $.extend(favlikeOpt,options);
    	var action = 'favLikeAction!in.action';
    	//浏览
    	if(opts.type==3){
    		action = 'favLikeAction!noAuth_in.action';
    	}
    	//依赖layer.js
    	var fav = layer.load(1);
    	$.ajax({
            type: "POST",  
            dataType: "json",  
            url: app_param.path+'/'+action,
            data : {title:opts.title,rid:opts.rid,url:opts.url,module:opts.module,type:opts.type},
            success: function(data) {
				if (data.status=='success'){
					if(typeof(callback)=='function'){
						var c = layer.alert(data.msg,function(){
							callback(data);
							layer.close(c);
						});
					}else{
						layer.alert(data.msg,function(){
							parent.window.location.reload();
						});
					}
				}else{
					layer.alert(data.msg);
				}
				layer.close(fav);
            },
            error: function(){
            	layer.alert('您尚未登录,请登录后操作！');
            	layer.close(fav);
            }
    	});
    },
    /**
     * 初始化评论插件
     * 使用方法：在需要的元素中增加id属性，在script标签中增加h.component.initDiscuss(元素id,需要添加评论的主键);
     * @param id
     * @param rid
     */
    initDiscuss : function(id,rid,url){
    	var d = layer.load(1);
    	$(function() {
	    	$('#'+id).load(app_param.path+'/discussAction!notAuth_index.action',{rid:rid,url:url},function(){
	    		layer.close(d);
	    	});
    	});
    },
    /**
     * 发表评论
     * @param options
     * @param callback
     */
    saveDiscuss : function(options,callback){
    	var opts = $.extend(discussOpt,options);
    	//依赖layer.js
    	var dc = layer.load(1);
    	$.ajax({
            type: "POST",  
            dataType: "json",  
            url: app_param.path+'/discussAction!in.action',
            data : {title:opts.title,rid:opts.rid,content:opts.content,url:opts.url},
            success: function(data) {
				if (data.status=='success'){
					if(typeof(callback)=='function'){
						var c = layer.alert(data.msg,function(){
							callback(data);
							layer.close(c);
						});
					}else{
						layer.alert(data.msg,function(){
							parent.window.location.reload();
						});
					}
				}else{
					layer.alert(data.msg);
				}
				layer.close(dc);
            },
            error: function(){
            	layer.alert('您尚未登录,请登录后操作！');
            	layer.close(dc);
            }
    	});
    },
    /**
     * 评论回复
     * @param options
     * @param callback
     */
    saveDiscussReply : function(options,callback){
    	var opts = $.extend(discussOpt,options);
    	//依赖layer.js
    	var dr = layer.load(1);
    	$.ajax({
            type: "POST",  
            dataType: "json",  
            url: app_param.path+'/discussReplyAction!in.action',
            data : {rid:opts.rid,content:opts.content},
            success: function(data) {
				if (data.status=='success'){
					if(typeof(callback)=='function'){
						var c = layer.alert(data.msg,function(){
							callback(data);
							layer.close(c);
						});
					}else{
						layer.alert(data.msg,function(){
							parent.window.location.reload();
						});
					}
				}else{
					layer.alert(data.msg);
				}
				layer.close(dr);
            },
            error: function(){
            	layer.alert('您尚未登录,请登录后操作！');
            	layer.close(dr);
            }
    	});
    },
    /**
     * 初始化打分插件
     * 使用方法：在需要的元素中增加id属性，在script标签中增加h.component.initRaty(元素id,需要添加评分的主键);
     * @param id
     * @param rid
     */
    initRaty : function(id,rid){
    	$(document).ready(function(){
    		$.getScript(app_param.path+'/jslib/raty/js/jquery.raty.js?v=20160310',function(){
    			mslScore(id,rid);
    		});
    	});
    },
    /**
     * 五星评分
     * @param options
     * @param callback
     */
    saveScore : function(options,callback){
    	var opts = $.extend(scoreOpt,options);
    	//依赖layer.js
    	var score = layer.load(1);
    	$.ajax({
            type: "POST",  
            dataType: "json",  
            url: app_param.path+'/scoreAction!in.action',
            data : {rid:opts.rid,score:opts.score},
            success: function(data) {
				if (data.status=='success'){
					if(typeof(callback)=='function'){
						var c = layer.alert(data.msg,function(){
							callback(data);
							layer.close(c);
						});
					}else{
						layer.alert(data.msg,function(){
							parent.window.location.reload();
						});
					}
				}else{
					if(typeof(callback)=='function'){
						var c = layer.alert(data.msg,function(){
							callback(data);
							layer.close(c);
						});
					}else{
						layer.alert(data.msg);
					}
				}
				layer.close(score);
            },
            error: function(data){
            	layer.alert('您尚未登录,请登录后操作！');
            	if(typeof(callback)=='function'){
            		callback(data);
            	}
            	layer.close(score);
            }
    	});
    }
};