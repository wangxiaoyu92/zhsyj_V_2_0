var pinch_status = 0;

function openImg(b, e) {
	var a = $(e).find("img");
	a.attr("src", b);
	var d = $(e + ">div");
	if (pinch_status == 0) {
		d.css("height", screen.availHeight + "px");
		var c = new RTP.PinchZoom($("#modal div"), {});
		pinch_status++
	}
	$(e).show()
};
