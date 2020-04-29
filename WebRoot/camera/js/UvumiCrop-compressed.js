
var uvumiCropper = new Class({Implements:[Events, Options], options:{maskOpacity:0.5, maskClassName:"cropperMask", handleClassName:"cropperHandle", resizerClassName:"cropperResize", wrapperClassName:"cropperWrapper", coordinatesClassName:"cropperCoordinates", mini:{x:130, y:160}, handles:[["top", "left"], "top", ["top", "right"], "right", "left", ["bottom", "left"], "bottom", ["bottom", "right"]], onComplete:$empty, onDestroy:$empty, keepRatio:false, doubleClik:true, handleSize:16, coordinates:false, preview:false, downloadButton:false, cancelButton:false, saveButton:false, adopt:false, parameters:{}, coordinatesOpacity:0.25, serverScriptSave:"save.jsp", serverScriptDownload:"cut.jsp", onRequestFail:function () {
	alert("The request could not be performed.");
}, onCropFail:function (a) {
	alert(a);
}, onCropSuccess:function (b) {
	alert("Thumbnail was generated successfully.");
	new Asset.image("images/thumbs/" + b, {onload:function (a) {
		$$(this.previewWrapper, this.toolBox).destroy();
		this.wrapper.empty().setStyle("height", "auto");
		a.inject(this.wrapper);
	}.bind(this)});
	this.removeEvents();
	this.crop = $empty;
}, onDestroy:$empty}, initialize:function (b, c) {
	window.addEvent("domready", function () {
		this.target = $(b);
		if (!this.target.match("img")) {
			return false;
		}
		this.setOptions(c);
		this.params = this.options.parameters;
		this.mini = {};
		this.mini.x = this.options.mini.x.toInt();
		this.mini.y = this.options.mini.y.toInt();
		this.runonce = false;
		new Asset.image(this.target.get("src"), {onload:function (a) {
			if (this.runonce) {
				return;
			}
			this.runonce = true;
			this.width = a.get("width");
			this.buildCropper();
			if (this.options.maskOpacity) {
				this.buildMask();
			} else {
				this.updateMask = $empty;
			}
			this.drag = new Drag.Move(this.resizer, {container:this.target, snap:0, onStart:this.hideHandles.bind(this), onComplete:function () {
				this.showHandles();
				this.fireEvent("onComplete", [this.top, this.left, this.width, this.height]);
			}.bind(this)});
			if (this.options.handles && this.options.handles.length) {
				this.resizeX = new Drag(this.resizer, {snap:0, modifiers:{x:"width", y:false}, onComplete:this.stopResize.bind(this)}).detach();
				this.resizeY = new Drag(this.resizer, {snap:0, modifiers:{x:false, y:"height"}, onComplete:this.stopResize.bind(this)}).detach();
				if (this.options.doubleClik) {
					this.resizer.addEvent("dblclick", this.expandToMax.bind(this));
				}
				if (this.options.keepRatio) {
					this.ratioOn();
				} else {
					this.ratioOff();
				}
			} else {
				this.drag.addEvent("drag", this.onDrag.bind(this));
			}
			this.drag.fireEvent("onDrag");
			this.drag.fireEvent("onComplete");
			this.show();
		}.bind(this)});
	}.bind(this));
}, buildCropper:function () {
	this.wrapper = new Element("div", {"class":this.options.wrapperClassName, styles:{position:"relative", width:this.target.getSize().x, height:this.target.getSize().y, overflow:"hidden"}}).wraps(this.target);
	this.border = this.target.getStyle("border-left");
	this.target.setStyles({margin:0, border:0, "float":"none"});
	this.target_coord = this.target.getCoordinates(this.wrapper);
	this.scaleRatio = this.width / this.target_coord.width;
	this.previewSize = {x:this.mini.x, y:this.mini.y};
	if (this.target_coord.width < this.mini.x) {
		this.mini.y = this.target_coord.width * this.mini.y / this.mini.x;
		this.mini.x = this.target_coord.width;
	}
	if (this.target_coord.height < this.mini.y) {
		this.mini.x = this.target_coord.height * this.mini.x / this.mini.y;
		this.mini.y = this.target_coord.height;
	}
	this.resizer = new Element("div", {"class":this.options.resizerClassName, title:"按下鼠标拖动,可以移动裁剪区域!!", styles:{position:"absolute", display:"block", margin:0, opacity:0, width:(this.scaleRatio < 1 ? (this.mini.x / this.scaleRatio).toInt() : this.mini.x), height:(this.scaleRatio < 1 ? (this.mini.y / this.scaleRatio).toInt() : this.mini.y), left:(this.target_coord.left + (this.target_coord.width / 2) - (this.mini.x / 2)).toInt(), top:(this.target_coord.top + (this.target_coord.height / 2) - (this.mini.y / 2)).toInt(), zIndex:5}}).inject(this.target, "after");
	this.margin = 2 * this.resizer.getStyle("border-width").toInt();
	this.resizer.setStyles({width:(this.scaleRatio < 1 ? (this.mini.x / this.scaleRatio).toInt() : this.mini.x) - this.margin, height:(this.scaleRatio < 1 ? (this.mini.y / this.scaleRatio).toInt() : this.mini.y) - this.margin});
	//this.resizer.setStyles({width:(this.mini.x) - this.margin, height:(this.mini.y) - this.margin});
	if (this.options.coordinates || (this.options.preview && !$(this.options.preview)) || this.options.saveButton || this.options.downloadButton || this.options.cancelButton || this.options.adopt) {
		this.buildToolBox();
	} else {
		this.updateCoordinates = $empty;
	}
	if (this.options.coordinates) {
		this.buildCoordinates();
	}
	if (this.options.preview) {
		if ($(this.options.preview)) {
			this.preview = $(this.options.preview);
			this.previewWrapper = new Element("div", {styles:{height:this.previewSize.y + 2 * this.preview.getStyle("border-width").toInt() + this.preview.getStyle("margin-top").toInt() + this.preview.getStyle("margin-bottom").toInt()}}).wraps(this.preview);
		} else {
			var a = new Element("div", {"class":"preview"}).inject(this.toolBox, "top");
			this.preview = new Element("div").inject(a);
		}
		this.preview.setStyles({display:"block", position:"relative", width:this.previewSize.x, height:this.previewSize.y, overflow:"hidden", margin:"auto", fontSize:0, lineHeight:0, opacity:0});
		this.previewImage = this.target.clone();
		this.previewImage.removeProperties("width", "height").setStyle("position", "absolute").inject(this.preview);
		this.addEvent("onPreview", this.updatePreview.bind(this));
	}
	if (this.options.adopt) {
		var b = new Element("div", {styles:{clear:"both"}}).inject(this.toolBox);
		switch ($type(this.options.adopt)) {
		  case "string":
			b.set("html", this.options.adopt);
			break;
		  case "element":
		  case "collection":
			b.adopt(this.options.adopt);
			break;
		}
	}
	if (this.options.downloadButton || this.options.saveButton || this.options.cancelButton) {
		var p = new Element("p").inject(this.toolBox);
		if (this.options.downloadButton) {
			var c = new Element("button", {type:"button", html:($type(this.options.downloadButton) == "string" ? this.options.downloadButton : "裁剪"), events:{click:this.cropDownload.bind(this, ($type(this.options.downloadButton) == "objecy" ? this.options.downloadButton : false))}}).inject(p);
		}
		if (this.options.saveButton) {
			var c = new Element("button", {type:"button", html:($type(this.options.saveButton) == "string" ? this.options.saveButton : "保存"), events:{click:this.cropSave.bind(this, ($type(this.options.saveButton) == "object" ? this.options.saveButton : false))}}).inject(p);
		}
		if (this.options.cancelButton) {
			var c = new Element("button", {type:"button", html:($type(this.options.cancelButton) == "string" ? this.options.cancelButton : "取消"), events:{click:this.destroy.bind(this)}}).inject(p);
		}
	}
	if (this.options.handles && this.options.handles.length) {
		this.options.handles.each(this.buildHandle, this);
	}
	this.rezr_coord = this.resizer.getCoordinates(this.wrapper);
}, buildHandle:function (b) {
	b = $splat(b);
	var x = "";
	var y = "";
	["left", "right"].each(function (a) {
		if (b.contains(a)) {
			x = a;
		}
	});
	["top", "bottom"].each(function (a) {
		if (b.contains(a)) {
			y = a;
		}
	});
	var c = new Element("div", {"class":this.options.handleClassName + " " + y + " " + x, title:(this.options.keepRatio ? "Drag to resize" : "Hold Shift to maintain aspect ratio"), tween:{duration:250, link:"cancel"}, styles:{position:"absolute", height:this.options.handleSize, width:this.options.handleSize, fontSize:0}, events:{mousedown:this.startResize.bind(this)}});
	c.inject(this.resizer);
	if (y == "top") {
		c.setStyle("top", -((this.options.handleSize + this.margin) / 2).toInt());
	} else {
		if (y == "bottom") {
			c.setStyle("bottom", -((this.options.handleSize + this.margin) / 2).toInt());
		} else {
			c.setStyles({top:"50%", marginTop:-(this.options.handleSize / 2).toInt()});
		}
	}
	if (x == "left") {
		c.setStyle("left", -((this.options.handleSize + this.margin) / 2).toInt());
	} else {
		if (x == "right") {
			c.setStyle("right", -((this.options.handleSize + this.margin) / 2).toInt());
		} else {
			c.setStyles({left:"50%", marginLeft:-(this.options.handleSize / 2).toInt()});
		}
	}
}, buildMask:function () {
	this.innermask = this.target.clone();
	this.innermask.setProperties(this.target.getProperties("width", "height"));
	this.innermask.setStyles({position:"absolute", padding:0, margin:0, top:0, left:0, zIndex:4, opacity:0}).inject(this.wrapper);
	this.outtermask = new Element("div", {"class":this.options.maskClassName, styles:{position:"absolute", padding:0, margin:0, top:0, left:0, width:"100%", height:this.target_coord.height, zIndex:3, opacity:0}, events:{"click":this.moveToClick.bind(this)}}).inject(this.wrapper);
	this.slide = new Fx.Elements($$(this.resizer, this.innermask, this.previewImage, this.toolBox), {onComplete:function () {
		this.drag.fireEvent("onDrag");
		this.drag.fireEvent("onComplete");
	}.bind(this)});
}, buildToolBox:function () {
	this.toolBox = new Element("div", {"class":this.options.coordinatesClassName + (Browser.Engine.trident ? " IE" : ""), styles:{position:"absolute", zIndex:5, opacity:0}}).inject($(document.body));
	this.toolBoxOffesetLeft = 0;
	this.toolBoxOffesetTop = 10;
	if (this.options.coordinatesOpacity && this.options.coordinatesOpacity < 1) {
		this.toolBox.set("tween", {duration:"short", link:"cancel"}).addEvents({mouseenter:function () {
			this.fade("in");
		}, mouseleave:function () {
			this.toolBox.fade(this.options.coordinatesOpacity);
		}.bind(this)});
	}
    this.toolBoxTopBar = new Element("div", {"class":"topbar", html:"按下鼠标拖动,可以移动工具窗口!!", styles:{position:"absolute", top:0, left:0, width:193}}).inject(this.toolBox, "top");
	new Drag(this.toolBox, {handle:this.toolBoxTopBar, onComplete:function () {
		var a = this.resizer.getCoordinates();
		var b = this.toolBox.getCoordinates();
		this.toolBoxOffesetLeft = b.left - a.left;
		this.toolBoxOffesetTop = b.top - a.bottom;
	}.bind(this)});	 
}, buildCoordinates:function () {
	this.topcoord = new Element("input", {type:"text"});
	this.leftcoord = new Element("input", {type:"text"});
	this.heightcoord = new Element("input", {type:"text"});
	this.widthcoord = new Element("input", {type:"text"});
	$$(this.topcoord, this.leftcoord, this.heightcoord, this.widthcoord).addEvent("change", this.updateFromInput.bind(this));
	var a = new Element("label", {html:"x : "});
	var b = new Element("label", {html:"y : "});
	var c = new Element("label", {html:"w : "});
	var d = new Element("label", {html:"h : "});
	this.toolBox.adopt(a, this.leftcoord, b, this.topcoord, new Element("br"), c, this.widthcoord, d, this.heightcoord, new Element("br"));
}, startResize:function (e) {
	this.resizing = true;
	var a = $(e.target);
	if (e.shift && !this.options.keepRatio) {
		this.ratioOn();
	}
	this.drag.addEvent("beforeStart", function () {
		this.drag.options.limit = {x:[0, (this.rezr_coord.right - (this.mini.x / this.scaleRatio).toInt())], y:[0, (this.rezr_coord.bottom - (this.mini.y / this.scaleRatio).toInt())]};
	}.bind(this));
	if (a.hasClass("left")) {
		this.resizeX.options.invert = true;
		this.drag.options.modifiers.x = "left";
		this.resizeX.options.limit = {x:[((this.mini.x / this.scaleRatio).toInt() - this.margin), (this.rezr_coord.right - this.margin)]};
		this.resizeX.start(e);
	} else {
		if (a.hasClass("right") || this.ratio) {
			this.resizeX.options.invert = false;
			this.drag.options.modifiers.x = false;
			this.resizeX.options.limit = {x:[((this.mini.x / this.scaleRatio).toInt() - this.margin), ((this.target_coord.width - this.margin) - this.rezr_coord.left)]};
			this.resizeX.start(e);
		} else {
			this.drag.options.modifiers.x = false;
		}
	}
	if (a.hasClass("top")) {
		this.resizeY.options.invert = true;
		this.drag.options.modifiers.y = "top";
		this.resizeY.options.limit = {y:[((this.mini.y / this.scaleRatio).toInt() - this.margin), (this.rezr_coord.bottom - this.margin)]};
		this.resizeY.start(e);
	} else {
		if (a.hasClass("bottom") || this.ratio) {
			this.resizeY.options.invert = false;
			this.drag.options.modifiers.y = false;
			this.resizeY.options.limit = {y:[((this.mini.y / this.scaleRatio).toInt() - this.margin), ((this.target_coord.height - this.margin) - this.rezr_coord.top)]};
			this.resizeY.start(e);
		} else {
			this.drag.options.modifiers.y = false;
		}
	}
}, stopResize:function () {
	this.resizing = false;
	this.drag.options.modifiers = {x:"left", y:"top"};
	this.drag.options.limit = false;
	this.drag.removeEvents("beforeStart");
	if (this.ratio) {
		this.check();
		this.onDrag();
		if (!this.options.keepRatio) {
			this.ratioOff();
		}
	}
}, hideHandles:function () {
	if (!this.resizing) {
		$$("." + this.options.handleClassName).fade("out");
	}
}, showHandles:function () {
	if (!this.resizing) {
		$$("." + this.options.handleClassName).fade("in");
	}
}, onDrag:function () {
	this.updateMask();
	this.top = ((this.rezr_coord.top - this.target_coord.top) * this.scaleRatio).toInt();
	this.left = ((this.rezr_coord.left - this.target_coord.left) * this.scaleRatio).toInt();
	this.width = Math.max((this.rezr_coord.width * this.scaleRatio).toInt(), this.mini.x);
	this.height = Math.max((this.rezr_coord.height * this.scaleRatio).toInt(), this.mini.y);
	this.updateCoordinates();
	this.fireEvent("onPreview", [this.top, this.left, this.width, this.height]);
}, onDragRatio:function () {
	if (this.resizing) {
		this.check();
	}
	this.onDrag();
}, check:function () {
	this.rezr_coord = this.resizer.getCoordinates(this.wrapper);
	if (this.ratio > 1) {
		var a = (this.rezr_coord.height * this.ratio).toInt();
		var b = this.rezr_coord.height;
		this.resizer.setStyle("width", Math.min(a, this.target_coord.width - this.rezr_coord.left) - this.margin);
	} else {
		var a = this.rezr_coord.width;
		var b = (this.rezr_coord.width / this.ratio).toInt();
		this.resizer.setStyle("height", Math.min(b, this.target_coord.height - this.rezr_coord.top) - this.margin);
	}
	if (this.drag.options.modifiers.x) {
		this.resizer.setStyle("left", Math.max(this.rezr_coord.right - a, 0));
	}
	if (this.drag.options.modifiers.y) {
		this.resizer.setStyle("top", Math.max(this.rezr_coord.bottom - b, 0));
	}
	this.rezr_coord = this.resizer.getCoordinates(this.wrapper);
	if (this.rezr_coord.right >= this.target_coord.width) {
		this.resizer.setStyle("height", (this.rezr_coord.width / this.ratio).toInt() - this.margin);
	}
	if (this.rezr_coord.bottom >= this.target_coord.height) {
		this.resizer.setStyle("width", (this.rezr_coord.height * this.ratio).toInt() - this.margin);
	}
}, updatePreview:function (a, b, c, d) {
	if (d * this.previewSize.x / c < this.previewSize.y) {
		this.preview.setStyles({width:this.previewSize.x, height:(this.previewSize.x * d / c).toInt()});
		this.previewImage.setStyles({width:(this.target_coord.width * this.previewSize.x * this.scaleRatio / c).toInt(), height:"auto", top:-(a * this.previewSize.x / c).toInt(), left:-(b * this.previewSize.x / c).toInt()});
	} else {
		this.preview.setStyles({height:this.previewSize.y, width:(this.previewSize.y * c / d).toInt()});
		this.previewImage.setStyles({height:(this.target_coord.height * this.previewSize.y * this.scaleRatio / d).toInt(), width:"auto", top:-(a * this.previewSize.y / d).toInt(), left:-(b * this.previewSize.y / d).toInt()});
	}
}, updateMask:function () {
	this.rezr_coord = this.resizer.getCoordinates(this.wrapper);
	this.innermask.setStyle("clip", "rect(" + this.rezr_coord.top + "px " + this.rezr_coord.right + "px " + this.rezr_coord.bottom + "px " + this.rezr_coord.left + "px)");
}, updateCoordinates:function () {
	if (this.options.coordinates) {
		this.leftcoord.set("value", this.left);
		this.topcoord.set("value", this.top);
		this.widthcoord.set("value", this.width);
		this.heightcoord.set("value", this.height);
	}
	var a = this.resizer.getCoordinates();
	this.toolBox.setStyles({top:a.bottom + this.toolBoxOffesetTop, left:a.left + this.toolBoxOffesetLeft});
}, updateFromInput:function (e) {
	var a = (this.topcoord.get("value").clean() / this.scaleRatio || 0).toInt();
	var b = (this.leftcoord.get("value").clean() / this.scaleRatio || 0).toInt();
	var c = (this.heightcoord.get("value").clean() / this.scaleRatio || 0).toInt();
	var d = (this.widthcoord.get("value").clean() / this.scaleRatio || 0).toInt();
	a = a.limit(0, this.target_coord.height - this.rezr_coord.height);
	b = b.limit(0, this.target_coord.width - this.rezr_coord.width);
	c = c.limit((this.mini.y / this.scaleRatio).toInt(), this.target_coord.height - this.rezr_coord.top);
	d = d.limit((this.mini.x / this.scaleRatio).toInt(), this.target_coord.width - this.rezr_coord.left);
	if (this.ratio) {
		if ($(e.target) == this.widthcoord) {
			c = Math.min((d / this.ratio).toInt(), this.target_coord.height - this.rezr_coord.top);
			d = (c * this.ratio).toInt();
		} else {
			if ($(e.target) == this.heightcoord) {
				d = Math.min((c * this.ratio).toInt(), this.target_coord.width - this.rezr_coord.left);
				c = (d / this.ratio).toInt();
			}
		}
	}
	this.resizer.setStyles({"height":c - this.margin, "width":d - this.margin, "top":a, "left":b});
	this.drag.fireEvent("drag");
	this.drag.fireEvent("onComplete");
}, moveToClick:function (e) {
	var a = e.page.x;
	var b = e.page.y;
	var c = this.wrapper.getPosition();
	var d = a - c.x;
	var f = b - c.y;
	var g = (f - (this.rezr_coord.height / 2).toInt()).limit(0, this.target_coord.height - this.rezr_coord.height);
	var h = (d - (this.rezr_coord.width / 2).toInt()).limit(0, this.target_coord.width - this.rezr_coord.width);
	var i = h + this.rezr_coord.width;
	var j = g + this.rezr_coord.height;
	var k = {0:{top:g, left:h}, 1:{clip:[[this.rezr_coord.top, this.rezr_coord.right, this.rezr_coord.bottom, this.rezr_coord.left], [g, i, j, h]]}};
	if (this.preview) {
		var l = this.preview.getSize();
		k[2] = {top:-(g * l.y / (j - g)).toInt(), left:-(h * l.x / (i - h)).toInt()};
	}
	if (this.toolBox) {
		k[this.slide.elements.length - 1] = {"top":j + c.y + this.toolBoxOffesetTop, "left":h + c.x + this.toolBoxOffesetLeft};
	}
	this.slide.start(k);
}, expandToMax:function () {
	if (this.ratio) {
		if (this.target_coord.width / this.target_coord.height < this.ratio) {
			var a = ((this.target_coord.height - (this.target_coord.width / this.ratio)) / 2).toInt();
			var b = 0;
			var c = this.target_coord.width - this.margin;
			var d = (this.target_coord.width / this.ratio).toInt() - this.margin;
		} else {
			var a = 0;
			var b = ((this.target_coord.width - (this.target_coord.height * this.ratio)) / 2).toInt();
			var c = (this.target_coord.height * this.ratio).toInt() - this.margin;
			var d = this.target_coord.height - this.margin;
		}
	} else {
		var a = 0;
		var b = 0;
		var c = this.target_coord.width - this.margin;
		var d = this.target_coord.height - this.margin;
		if (this.preview) {
			if (d * this.previewSize.x / c < this.previewSize.y) {
				this.preview.setStyles({width:this.previewSize.x, height:(this.previewSize.x * d / c).toInt()});
			} else {
				this.preview.setStyles({height:this.previewSize.y, width:(this.previewSize.y * c / d).toInt()});
			}
		}
	}
	var e = {0:{top:a, left:b, width:c, height:d}, 1:{clip:[[this.rezr_coord.top, this.rezr_coord.right, this.rezr_coord.bottom, this.rezr_coord.left], [a, b + c, d + a, b]]}};
	if (this.preview) {
		var f = this.previewImage.getCoordinates(this.preview);
		f.bottom = null;
		f.right = null;
		this.previewImage.setStyles(f);
		var g = this.preview.getSize();
		e[2] = {top:-(a * this.previewSize.y / d).toInt(), left:-(b * this.previewSize.x / c).toInt(), width:(this.target_coord.width * g.x * this.scaleRatio / c).toInt(), height:(this.target_coord.height * g.y * this.scaleRatio / d).toInt()};
	}
	if (this.toolBox) {
		var h = this.wrapper.getPosition();
		e[this.slide.elements.length - 1] = {"top":d + h.y + this.toolBoxOffesetTop, "left":b + h.x + this.toolBoxOffesetLeft};
	}
	this.slide.start(e);
}, hide:function () {
	$$(this.resizer, this.innermask, this.outtermask, this.preview, this.toolBox).fade("out");
}, show:function () {
	$$(this.resizer, this.innermask, this.preview).fade("in");
	if (this.options.maskOpacity) {
		this.outtermask.fade(this.options.maskOpacity);
	}
	if (this.toolBox) {
		this.toolBox.fade(this.options.coordinatesOpacity || "in");
	}
}, toggle:function () {
	if (this.resizer.getStyle("opacity") == 1) {
		this.hide();
	} else {
		this.show();
	}
}, destroy:function () {
	this.hide();
	this.target.setStyle("border", this.border);
	(function () {
		this.target.replaces(this.wrapper);
		if (this.previewWrapper) {
			this.preview.empty().setStyles({height:0, width:0}).replaces(this.previewWrapper);
		}
		this.fireEvent("onDestroy", this.target);
		if (this.toolBox) {
			this.toolBox.destroy();
		}
	}).delay(600, this);
}, ratioOn:function () {
	this.ratio = this.rezr_coord.width / this.rezr_coord.height;
	this.drag.removeEvents("drag");
	this.drag.addEvent("drag", this.onDragRatio.bind(this));
}, ratioOff:function () {
	this.ratio = false;
	this.drag.removeEvents("drag");
	this.drag.addEvent("drag", this.onDrag.bind(this));
}, changeImage:function (c) {
	new Asset.image(c, {onload:function (b) {
		this.hide();
		this.target.get("tween").start("opacity", 0).chain(function () {
			this.scaleRatio = b.get("width") / this.target_coord.width;
			var a = (b.get("height") / this.scaleRatio).toInt();
			this.wrapper.setStyle("height", a);
			this.target.set({width:this.target_coord.width, height:a});
			this.target_coord = this.target.getCoordinates(this.wrapper);
			this.target.set("src", c);
			if (this.target_coord.width < this.mini.x) {
				this.mini.y = this.target_coord.width * this.mini.y / this.mini.x;
				this.mini.x = this.target_coord.width;
			}
			if (this.target_coord.height < this.mini.y) {
				this.mini.x = this.target_coord.height * this.mini.x / this.mini.y;
				this.mini.y = this.target_coord.height;
			}
			this.resizer.setStyles({width:(this.mini.x / this.scaleRatio).toInt() - this.margin, height:(this.mini.y / this.scaleRatio).toInt() - this.margin, left:(this.target_coord.left + (this.target_coord.width / 2) - (this.mini.x / 2)).toInt(), top:(this.target_coord.top + (this.target_coord.height / 2) - (this.mini.y / 2)).toInt()});
			this.innermask.setProperties(this.target.getProperties("width", "height", "src"));
			this.outtermask.setStyle("height", this.target_coord.height);
			if (this.previewImage) {
				this.previewImage.set("src", c);
			}
			this.drag.fireEvent("onDrag");
			this.drag.fireEvent("onComplete");
			this.show();
			this.target.get("tween").start("opacity", 1);
		}.bind(this));
	}.bind(this)});
}, cropDownload:function (a) {
	this.prepareParameters(a);
	params = new Hash(this.params);
	location.href = this.options.serverScriptDownload + "?" + params.toQueryString();
}, cropSave:function (c) {
	this.prepareParameters(c);
	this.request = new Request.JSON({url:this.options.serverScriptSave, data:this.params, onSuccess:function (a, b) {
		if (a) {
			if (a.error) {
				this.fireEvent("onCropFail", a.error);
			} else {
				if (a.success) {
					this.fireEvent("onCropSuccess", a.success);
				}
			}
		} else {
			this.fireEvent("onCropFail", b);
		}
	}.bind(this), onFailure:function () {
		this.fireEvent("onRequestFail");
	}.bind(this)}).send();
}, prepareParameters:function (a) {
	var b = {fileName:this.target.get("src").split("/").getLast(), max_height:this.mini.y, max_width:this.mini.x, top:this.top, left:this.left, width:this.width, height:this.height};
	this.addParameters(b);
	this.addParameters(a);
}, addParameters:function (a) {
	if ($type(a) == "object") {
		this.params = $merge(this.params, a);
	}
}});

