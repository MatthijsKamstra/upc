// Generated by Haxe 3.4.2
(function ($global) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.dateStr = function(date) {
	var m = date.getMonth() + 1;
	var d = date.getDate();
	var h = date.getHours();
	var mi = date.getMinutes();
	var s = date.getSeconds();
	return date.getFullYear() + "-" + (m < 10 ? "0" + m : "" + m) + "-" + (d < 10 ? "0" + d : "" + d) + " " + (h < 10 ? "0" + h : "" + h) + ":" + (mi < 10 ? "0" + mi : "" + mi) + ":" + (s < 10 ? "0" + s : "" + s);
};
var Main = function() {
	this.document = window.document;
	console.log("Hello 'UPC JS'");
	this.init();
};
Main.__name__ = true;
Main.main = function() {
	var app = new Main();
};
Main.prototype = {
	init: function() {
		var _gthis = this;
		this.document.addEventListener("DOMContentLoaded",function(event) {
			window.console.log("Dom ready :: build: " + model_constants_App.BUILD + " ");
			_gthis.initVar();
			_gthis.initBtn();
			_gthis.initSharedObject();
		});
	}
	,initVar: function() {
		this.inputtextfirstnameInput = this.document.getElementById("firstnameInput");
		this.inputtextlastnameInput = this.document.getElementById("lastnameInput");
		this.inputtextartistnameInput = this.document.getElementById("artistnameInput");
		this.inputcheckboxartistnameCheckbox = this.document.getElementById("artistnameCheckbox");
		this.inputemailemailInput = this.document.getElementById("emailInput");
		this.inputtextwebsiteInput = this.document.getElementById("websiteInput");
		this.inputtexttwitterInput = this.document.getElementById("twitterInput");
		this.inputtextLinkedinInput = this.document.getElementById("LinkedinInput");
		this.inputtextflickrInput = this.document.getElementById("flickrInput");
		this.inputtextinstagramInput = this.document.getElementById("instagramInput");
		this.inputfilephotoFile = this.document.getElementById("photoFile");
		this.textareabioEnglishInput = this.document.getElementById("bioEnglishInput");
		this.textareadesciptionEnglishInput = this.document.getElementById("desciptionEnglishInput");
		this.textarearemarkEnglishInput = this.document.getElementById("remarkEnglishInput");
		this.selectupcSelect = this.document.getElementById("upcSelect");
		this.selectcountrySelect = this.document.getElementById("countrySelect");
		this.selectnativeSelect = this.document.getElementById("nativeSelect");
		this.selectlanguageGoodSelect = this.document.getElementById("languageGoodSelect");
		this.selectlanguageUnderstandSelect = this.document.getElementById("languageUnderstandSelect");
	}
	,initBtn: function() {
		var _gthis = this;
		$("#test-fill-btn").click(function(e) {
			e.preventDefault();
			_gthis.inputtextfirstnameInput.value = "Matthijs";
			_gthis.inputtextlastnameInput.value = "Kamstra";
			_gthis.inputtextartistnameInput.value = "[mck]";
			_gthis.inputcheckboxartistnameCheckbox.checked = true;
			_gthis.inputemailemailInput.value = "grumm@foo.bar";
			_gthis.inputtextwebsiteInput.value = "http://www.matthijskamstra.nl";
			_gthis.inputtexttwitterInput.value = "https://twitter.com/matthijskamstra";
			_gthis.inputtextLinkedinInput.value = "https://linked";
			_gthis.inputtextflickrInput.value = "https://flickrr";
			_gthis.inputtextinstagramInput.value = "https://instagram";
			_gthis.textareabioEnglishInput.value = "I love foobar";
			_gthis.textareadesciptionEnglishInput.value = "paper artist";
			_gthis.textarearemarkEnglishInput.value = "I have no clue";
			_gthis.selectupcSelect.value = "upcmember";
			_gthis.selectcountrySelect.value = "NL";
			_gthis.selectnativeSelect.value = "NL";
			_gthis.selectlanguageGoodSelect.value = "EN";
			_gthis.selectlanguageUnderstandSelect.value = "DE";
		});
		$("#save-btn").click(function(e1) {
			e1.preventDefault();
			console.log("save-btn");
			var tmp = JSON.stringify(_gthis.storeData());
			_gthis.download(tmp,"upc_" + _gthis.inputtextfirstnameInput.value + "_" + _gthis.inputtextlastnameInput.value + ".json","text/plain");
		});
		$("#test-btn").click(function(e2) {
			e2.preventDefault();
			console.log("test-btn");
			var firstname = (js_Boot.__cast(_gthis.document.getElementById("firstnameInput") , HTMLInputElement)).value;
			console.log(firstname);
		});
		$("input, select, textarea").focusout(function(e3) {
			_gthis.storeData();
		});
		$("input, select, textarea").focusin(function(e4) {
			_gthis.storeData();
		});
	}
	,storeData: function() {
		var jsonData = { "created" : "" + Std.string(new Date()), "firstname" : this.inputtextfirstnameInput.value, "lastname" : this.inputtextlastnameInput.value, "artistname" : this.inputtextartistnameInput.value, "useartist" : this.inputcheckboxartistnameCheckbox.checked, "email" : this.inputemailemailInput.value, "website" : this.inputtextwebsiteInput.value, "twitter" : this.inputtexttwitterInput.value, "linkedin" : this.inputtextLinkedinInput.value, "flickrr" : this.inputtextflickrInput.value, "instagram" : this.inputtextinstagramInput.value, "photo" : this.inputfilephotoFile.value, "bio" : this.textareabioEnglishInput.value, "description" : this.textareadesciptionEnglishInput.value, "remark" : this.textarearemarkEnglishInput.value, "upcselect" : this.selectupcSelect.value, "country" : this.selectcountrySelect.value, "language0" : this.selectnativeSelect.value, "language1" : this.selectlanguageGoodSelect.value, "language2" : this.selectlanguageUnderstandSelect.value};
		var _g = 0;
		var _g1 = Reflect.fields(jsonData);
		while(_g < _g1.length) {
			var field = _g1[_g];
			++_g;
			window.localStorage.setItem("" + field,"" + Std.string(Reflect.field(jsonData,field)));
		}
		return jsonData;
	}
	,initSharedObject: function() {
		var tmp = window.localStorage.getItem("firstname") != null ? window.localStorage.getItem("firstname") : "";
		this.inputtextfirstnameInput.value = tmp;
		var tmp1 = window.localStorage.getItem("lastname") != null ? window.localStorage.getItem("lastname") : "";
		this.inputtextlastnameInput.value = tmp1;
		var tmp2 = window.localStorage.getItem("artistname") != null ? window.localStorage.getItem("artistname") : "";
		this.inputtextartistnameInput.value = tmp2;
		var tmp3 = window.localStorage.getItem("useartist") != "false";
		this.inputcheckboxartistnameCheckbox.checked = tmp3;
		var tmp4 = window.localStorage.getItem("email") != null ? window.localStorage.getItem("email") : "";
		this.inputemailemailInput.value = tmp4;
		var tmp5 = window.localStorage.getItem("website") != null ? window.localStorage.getItem("website") : "";
		this.inputtextwebsiteInput.value = tmp5;
		var tmp6 = window.localStorage.getItem("twitter") != null ? window.localStorage.getItem("twitter") : "";
		this.inputtexttwitterInput.value = tmp6;
		var tmp7 = window.localStorage.getItem("linkedin") != null ? window.localStorage.getItem("linkedin") : "";
		this.inputtextLinkedinInput.value = tmp7;
		var tmp8 = window.localStorage.getItem("flickrr") != null ? window.localStorage.getItem("flickrr") : "";
		this.inputtextflickrInput.value = tmp8;
		var tmp9 = window.localStorage.getItem("instagram") != null ? window.localStorage.getItem("instagram") : "";
		this.inputtextinstagramInput.value = tmp9;
		var tmp10 = window.localStorage.getItem("photoFile") != null ? window.localStorage.getItem("photoFile") : "";
		this.inputfilephotoFile.value = tmp10;
		var tmp11 = window.localStorage.getItem("bio") != null ? window.localStorage.getItem("bio") : "";
		this.textareabioEnglishInput.value = tmp11;
		var tmp12 = window.localStorage.getItem("description") != null ? window.localStorage.getItem("description") : "";
		this.textareadesciptionEnglishInput.value = tmp12;
		var tmp13 = window.localStorage.getItem("remark") != null ? window.localStorage.getItem("remark") : "";
		this.textarearemarkEnglishInput.value = tmp13;
		var tmp14 = window.localStorage.getItem("upcselect") != null ? window.localStorage.getItem("upcselect") : "";
		this.selectupcSelect.value = tmp14;
		var tmp15 = window.localStorage.getItem("country") != null ? window.localStorage.getItem("country") : "";
		this.selectcountrySelect.value = tmp15;
		var tmp16 = window.localStorage.getItem("language0") != null ? window.localStorage.getItem("language0") : "";
		this.selectnativeSelect.value = tmp16;
		var tmp17 = window.localStorage.getItem("language1") != null ? window.localStorage.getItem("language1") : "";
		this.selectlanguageGoodSelect.value = tmp17;
		var tmp18 = window.localStorage.getItem("language2") != null ? window.localStorage.getItem("language2") : "";
		this.selectlanguageUnderstandSelect.value = tmp18;
	}
	,download: function(text,name,type) {
		var a = this.document.createElement("a");
		var file = new Blob([text],{ type : type});
		a.href = URL.createObjectURL(file);
		a.download = name;
		a.click();
	}
	,__class__: Main
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) {
			a.push(f);
		}
		}
	}
	return a;
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.wrap = function(val) {
	if((val instanceof Error)) {
		return val;
	} else {
		return new js__$Boot_HaxeError(val);
	}
};
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) {
		return Array;
	} else {
		var cl = o.__class__;
		if(cl != null) {
			return cl;
		}
		var name = js_Boot.__nativeClassName(o);
		if(name != null) {
			return js_Boot.__resolveNativeClass(name);
		}
		return null;
	}
};
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
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) {
		return false;
	}
	if(cc == cl) {
		return true;
	}
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) {
				return true;
			}
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) {
		return false;
	}
	switch(cl) {
	case Array:
		if((o instanceof Array)) {
			return o.__enum__ == null;
		} else {
			return false;
		}
		break;
	case Bool:
		return typeof(o) == "boolean";
	case Dynamic:
		return true;
	case Float:
		return typeof(o) == "number";
	case Int:
		if(typeof(o) == "number") {
			return (o|0) === o;
		} else {
			return false;
		}
		break;
	case String:
		return typeof(o) == "string";
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) {
					return true;
				}
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) {
					return true;
				}
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) {
					return true;
				}
			}
		} else {
			return false;
		}
		if(cl == Class ? o.__name__ != null : false) {
			return true;
		}
		if(cl == Enum ? o.__ename__ != null : false) {
			return true;
		}
		return o.__enum__ == cl;
	}
};
js_Boot.__cast = function(o,t) {
	if(js_Boot.__instanceof(o,t)) {
		return o;
	} else {
		throw new js__$Boot_HaxeError("Cannot cast " + Std.string(o) + " to " + Std.string(t));
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") {
		return null;
	}
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g1 = 0;
		var _g = len;
		while(_g1 < _g) {
			var i = _g1++;
			this.a[i] = 0;
		}
		this.byteLength = len;
	}
};
js_html_compat_ArrayBuffer.__name__ = true;
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null ? null : end - begin);
	var result = new ArrayBuffer(u.byteLength);
	var resultArray = new Uint8Array(result);
	resultArray.set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_Uint8Array = function() { };
js_html_compat_Uint8Array.__name__ = true;
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g1 = 0;
		var _g = arg1;
		while(_g1 < _g) {
			var i = _g1++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) {
			offset = 0;
		}
		if(length == null) {
			length = buffer.byteLength - offset;
		}
		if(offset == 0) {
			arr = buffer.a;
		} else {
			arr = buffer.a.slice(offset,offset + length);
		}
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else {
		throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	}
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > this.byteLength) {
			throw new js__$Boot_HaxeError("set() outside of range");
		}
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			this[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > this.byteLength) {
			throw new js__$Boot_HaxeError("set() outside of range");
		}
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			this[i1 + offset] = a1[i1];
		}
	} else {
		throw new js__$Boot_HaxeError("TODO");
	}
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var a = js_html_compat_Uint8Array._new(this.slice(start,end));
	a.byteOffset = start;
	return a;
};
var model_constants_App = function() { };
model_constants_App.__name__ = true;
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
var ArrayBuffer = $global.ArrayBuffer || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) {
	ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
}
var Uint8Array = $global.Uint8Array || js_html_compat_Uint8Array._new;
js_Boot.__toStr = ({ }).toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
model_constants_App.BUILD = "2017-09-08 00:31:30";
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=upc.js.map