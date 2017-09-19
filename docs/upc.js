// Generated by Haxe 3.4.2
(function ($hx_exports) { "use strict";
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var UPC = $hx_exports["UPC"] = function() {
	var _gthis = this;
	window.document.addEventListener("DOMContentLoaded",function(event) {
		window.console.log("Dom ready :: build: " + model_constants_App.BUILD + " ");
		_gthis.initUpdate();
		_gthis.initImages();
		_gthis.initLibs();
	});
};
UPC.__name__ = true;
UPC.qrcode = function(url) {
	var qrelement = window.document.getElementById("qrcode");
	new QRCode(qrelement, url);
};
UPC.twitterFetch = function(name,domId) {
	if(name == null || name == "") {
		console.log("UPC.twitterFetcher : this user has no twitter account");
		return;
	}
	console.log("UPC.twitterFetcher : " + name);
	var configProfile = { "profile" : { "screenName" : "" + name}, "domId" : "" + domId, "maxTweets" : 5, "enableLinks" : true, "showUser" : false, "showTime" : true, "showImages" : false, "lang" : "en", "customCallback" : UPC.handleTweets};
	twitterFetcher.fetch(configProfile);
	$('.carousel').carousel({
			pause: true,
			interval: 4000,
		});
};
UPC.handleTweets = function(tweets) {
	var x = tweets.length;
	var n = 0;
	var z = 0;
	var element = window.document.getElementById("carouselExampleControls");
	var html = "";
	html += "<ol class=\"carousel-indicators\">";
	while(z < x) {
		var klass = z > 0 ? "" : "active";
		html += "<li data-target=\"#carouselExampleControls\" data-slide-to=\"" + z + "\" class=\"" + klass + "\"></li>";
		++z;
	}
	html += "</ol>";
	html += "<div class=\"carousel-inner\">";
	while(n < x) {
		var klass1 = n > 0 ? "" : "active";
		html += "<div class=\"carousel-item " + klass1 + "\" style=\"background-color:black;\">\n\t\t\t<img class=\"d-block w-100\" style=\"opacity: 0.2;\" src=\"http://lorempixel.com/1600/900/abstract/?" + n + "\" alt=\"First slide\">\n\t\t\t<div class=\"carousel-caption d-none d-md-block\">\n\t\t\t\t<p>" + Std.string(tweets[n]) + "</p>\n\t\t\t</div>\n\t\t\t</div>";
		++n;
	}
	html += "</div>";
	html += "\n<a class=\"carousel-control-prev\" href=\"#carouselExampleControls\" role=\"button\" data-slide=\"prev\">\n<span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>\n<span class=\"sr-only\">Previous</span>\n</a>\n<a class=\"carousel-control-next\" href=\"#carouselExampleControls\" role=\"button\" data-slide=\"next\">\n<span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>\n<span class=\"sr-only\">Next</span>\n</a>\n";
	element.innerHTML = html;
};
UPC.main = function() {
	var app = new UPC();
};
UPC.prototype = {
	initUpdate: function() {
		var updated = window.document.getElementById("last-updated");
		if(updated != null) {
			updated.innerText = "Last update: " + model_constants_App.BUILD;
		}
	}
	,initImages: function() {
		var arr = window.document.getElementById("wrapper").getElementsByTagName("img");
		var _g1 = 0;
		var _g = arr.length;
		while(_g1 < _g) {
			var i = _g1++;
			var img = arr[i];
			img.className = "img-fluid img-fluid-max";
		}
	}
	,initLibs: function() {
		var element = window.document.querySelectorAll(".chart");
		var _g1 = 0;
		var _g = element.length;
		while(_g1 < _g) {
			var i = _g1++;
			var _element = element[i];
			new EasyPieChart(_element, {
				// your options goes here
			});
		}
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0 ? "," : "") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var model_constants_App = function() { };
model_constants_App.__name__ = true;
String.__name__ = true;
Array.__name__ = true;
model_constants_App.BUILD = "2017-09-19 11:38:29";
UPC.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this);

//# sourceMappingURL=upc.js.map