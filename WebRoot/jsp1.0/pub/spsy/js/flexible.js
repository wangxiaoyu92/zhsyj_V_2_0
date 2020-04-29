(function (J, G) {
	var t = J.document;
	var K = t.documentElement;
	var z = t.querySelector('meta[name="viewport"]');
	var y = t.querySelector('meta[name="flexible"]');
	var L = 0;
	var u = 0;
	var A;
	var I = G.flexible || (G.flexible = {});
	if (z) {
		console.warn("将根据已有的meta标签来设置缩放比例");
		var H = z.getAttribute("content").match(/initial\-scale=([\d\.]+)/);
		if (H) {
			u = parseFloat(H[1]);
			L = parseInt(1 / u)
		}
	} else {
		if (y) {
			var C = y.getAttribute("content");
			if (C) {
				var v = C.match(/initial\-dpr=([\d\.]+)/);
				var E = C.match(/maximum\-dpr=([\d\.]+)/);
				if (v) {
					L = parseFloat(v[1]);
					u = parseFloat((1 / L).toFixed(2))
				}
				if (E) {
					L = parseFloat(E[1]);
					u = parseFloat((1 / L).toFixed(2))
				}
			}
		}
	}
	if (!L && !u) {
		var w = J.navigator.appVersion.match(/android/gi);
		var x = J.navigator.appVersion.match(/iphone/gi);
		var B = J.devicePixelRatio;
		if (x) {
			if (B >= 3 && (!L || L >= 3)) {
				L = 3
			} else {
				if (B >= 2 && (!L || L >= 2)) {
					L = 2
				} else {
					L = 1
				}
			}
		} else {
			L = 1
		}
		u = 1 / L
	}
	K.setAttribute("data-dpr", L);
	if (!z) {
		z = t.createElement("meta");
		z.setAttribute("name", "viewport");
		z.setAttribute("content", "initial-scale=" + u + ", maximum-scale=" + u + ", minimum-scale=" + u + ", user-scalable=no");
		if (K.firstElementChild) {
			K.firstElementChild.appendChild(z)
		} else {
			var F = t.createElement("div");
			F.appendChild(z);
			t.write(F.innerHTML)
		}
	}

	function D() {
		var b = K.getBoundingClientRect().width;
		if (b / L > 540) {
			b = 540 * L
		}
		var a = b / 10;
		K.style.fontSize = a + "px";
		I.rem = J.rem = a
	}
	J.addEventListener("resize", function () {
		clearTimeout(A);
		A = setTimeout(D, 300)
	}, false);
	J.addEventListener("pageshow", function (a) {
		if (a.persisted) {
			clearTimeout(A);
			A = setTimeout(D, 300)
		}
	}, false);
	if (t.readyState === "complete") {
		t.body.style.fontSize = 12 * L + "px"
	} else {
		t.addEventListener("DOMContentLoaded", function (a) {
			t.body.style.fontSize = 12 * L + "px"
		}, false)
	}
	D();
	I.dpr = J.dpr = L;
	I.refreshRem = D;
	I.rem2px = function (a) {
		var b = parseFloat(a) * this.rem;
		if (typeof a === "string" && a.match(/rem$/)) {
			b += "px"
		}
		return b
	};
	I.px2rem = function (a) {
		var b = parseFloat(a) / this.rem;
		if (typeof a === "string" && a.match(/px$/)) {
			b += "rem"
		}
		return b
	}
})(window, window.lib || (window.lib = {}));
