/**
 * 全局错误提示,请自己扩展 wangxueshu 
 * GLOBAL_ERROR  与 TIPS 按顺序对应
 */
var GLOBAL_ERROR = ['请求未授权的功能', '您访问了尚未拥有的功能权限', '登录页面标识'];
var GLOBAL_ERROR_TIPS = ['您请求了未被授权的功能，如需开通，请联系上级业务部门或管理员!', '您访问了尚未拥有的功能权限!', '登录已经超时，请重新登录!'];
function checkJsonResult(str) {
	if (typeof(str) == "string") {
		var b = true;
		$.each(GLOBAL_ERROR,
		function(i, v) {
			eval("var re = /" + v + "/g;");
			if (str.search(re) > 0) {
				alert(GLOBAL_ERROR_TIPS[i]);
				b = false;
				return false;
			}
		});
		return b;
	}
	return true;
}
