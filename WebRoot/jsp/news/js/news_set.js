function writeCookie(name, value, hours) {
	var expire = "";
	var domain = ";path=/"; // "; domain=xyrlzycs.com; path=/"; 
	if (hours != null) {
		expire = new Date((new Date()).getTime() + hours * 3600000);
		expire = "; expires=" + expire.toGMTString();
	}
	document.cookie = name + "=" + escape(value) + domain;
}
function readCookie(name) {
	var cookieValue = "";
	var search = name + "=";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search);
		if (offset != -1) {
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length;
			cookieValue = unescape(document.cookie.substring(offset, end))
		}
	}
	return cookieValue;
}
function setColor(color_val) {
	color_val = '#' + color_val;
	document.getElementById('news_page').style.background = color_val;
	writeCookie("bgColor_cookie", color_val, 24)
}
function getColor() {
	document.getElementById('news_page').style.background = "#FFFFFF";
	var bg_color = readCookie("bgColor_cookie");
	if (bg_color != null) {
		document.getElementById('news_page').style.background = bg_color
	}
}
function setFont(size_val) {
	document.getElementById('mynews_content').style.fontSize = size_val + "px";
	writeCookie("fontSize_cookis", size_val, 24)
}
function getFontSize() {
	document.getElementById('mynews_content').style.fontSize = "14px";
	var size = readCookie("fontSize_cookis");
	if (size != "") {
		document.getElementById('mynews_content').style.fontSize = size + "px";
	}
}
