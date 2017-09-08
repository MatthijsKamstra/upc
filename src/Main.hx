package;

import js.Browser.*;
import js.Browser;
import js.html.*;
import js.jquery.*;

import js.html.FileReader;

import model.constants.App;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.html.svg.SVGElement;

using StringTools;

/**
 * @author Matthijs Kamstra aka [mck]
 * MIT
 */
class Main {

	var document : js.html.HTMLDocument = js.Browser.document;
	var container : js.html.DivElement;

	var inputtextfirstnameInput : InputElement;
	var inputtextlastnameInput : InputElement;
	var inputtextartistnameInput : InputElement;
	var inputcheckboxartistnameCheckbox : InputElement;
	var inputemailemailInput : InputElement;
	var inputtextwebsiteInput : InputElement;
	var inputtexttwitterInput : InputElement;
	var inputtextLinkedinInput : InputElement;
	var inputtextflickrInput : InputElement;
	var inputtextinstagramInput : InputElement;
	var inputtextfacebookInput : InputElement;
	var inputtextpatreonInput : InputElement;
	var inputfilephotoFile : InputElement;
	var textareabioEnglishInput : TextAreaElement;
	var textareadesciptionEnglishInput : TextAreaElement;
	var textarearemarkEnglishInput : TextAreaElement;
	var selectupcSelect : SelectElement;
	var selectcountrySelect : SelectElement;
	var selectnativeSelect : SelectElement;
	var selectlanguageGoodSelect : SelectElement;
	var selectlanguageUnderstandSelect : SelectElement;

	var image : ImageElement;
	var base64Image : String;


	public function new () {
		trace( "Hello 'UPC JS'" );
		init();
	}

	function init() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Dom ready :: build: ${App.BUILD} ');

			initVar();
			initBtn();
			// output ();
			initSharedObject();

			// initHTML();
			// loadData();
		});
	}

	function initVar (){
		image = cast document.getElementById('uploadedPhoto');

		inputtextfirstnameInput = cast document.getElementById("firstnameInput");
		inputtextlastnameInput = cast document.getElementById("lastnameInput");
		inputtextartistnameInput = cast document.getElementById("artistnameInput");
		inputcheckboxartistnameCheckbox = cast document.getElementById("artistnameCheckbox");
		inputemailemailInput = cast document.getElementById("emailInput");
		inputtextwebsiteInput = cast document.getElementById("websiteInput");
		inputtexttwitterInput = cast document.getElementById("twitterInput");
		inputtextLinkedinInput = cast document.getElementById("LinkedinInput");
		inputtextflickrInput = cast document.getElementById("flickrInput");
		inputtextinstagramInput = cast document.getElementById("instagramInput");
		inputtextfacebookInput = cast document.getElementById("facebookInput");
		inputtextpatreonInput = cast document.getElementById("patreonInput");
		inputfilephotoFile = cast document.getElementById("photoFile");
		textareabioEnglishInput = cast document.getElementById("bioEnglishInput");
		textareadesciptionEnglishInput = cast document.getElementById("desciptionEnglishInput");
		textarearemarkEnglishInput = cast document.getElementById("remarkEnglishInput");
		selectupcSelect = cast document.getElementById("upcSelect");
		selectcountrySelect = cast document.getElementById("countrySelect");
		selectnativeSelect = cast document.getElementById("nativeSelect");
		selectlanguageGoodSelect = cast document.getElementById("languageGoodSelect");
		selectlanguageUnderstandSelect = cast document.getElementById("languageUnderstandSelect");
	}

	function initBtn (){

  		document.getElementById('photoFile').addEventListener('change', handleFileSelect, false);

		new JQuery('#test-fill-btn').click(function(e){
			e.preventDefault();
			image.src = 'https://dummyimage.com/500x500/00ffff/000000.png&text=Minimal+500+px';
			inputtextfirstnameInput.value = 'Matthijs';
			inputtextlastnameInput.value = 'Kamstra';
			inputtextartistnameInput.value = '[mck]';
			inputcheckboxartistnameCheckbox.checked = true;
			inputemailemailInput.value = 'grumm@foo.bar';
			inputtextwebsiteInput.value = 'http://www.matthijskamstra.nl';
			inputtexttwitterInput.value = 'https://twitter.com/matthijskamstra';
			inputtextLinkedinInput.value = 'https://linked';
			inputtextflickrInput.value = 'https://flickrr';
			inputtextinstagramInput.value = 'https://instagram';
			inputtextfacebookInput.value = 'https://facebook';
			inputtextpatreonInput.value = 'https://patje';
			// inputfilephotoFile.value = 'foo';
			textareabioEnglishInput.value = 'I love foobar';
			textareadesciptionEnglishInput.value = 'paper artist';
			textarearemarkEnglishInput.value = 'I have no clue';
			selectupcSelect.value = 'upcmember';
			selectcountrySelect.value = 'NL';
			selectnativeSelect.value = 'NL';
			selectlanguageGoodSelect.value = 'EN';
			selectlanguageUnderstandSelect.value = 'DE';
		});


		new JQuery('.save-btn').click(function(e){
			e.preventDefault();
			trace('save-btn');
			download(haxe.Json.stringify(storeData()), 'upc_${inputtextfirstnameInput.value}_${inputtextlastnameInput.value}.json', 'text/plain');
		});
		new JQuery('#test-btn').click(function(e){
			e.preventDefault();
			trace('test-btn');
			var firstname = cast(document.getElementById('firstnameInput'), js.html.InputElement).value;
			trace(firstname);
		});

		new JQuery('input, select, textarea').focusout(function (e){
			// trace('focusout: ' + e.currentTarget);
			storeData();
		});
		new JQuery('input, select, textarea').focusin(function (e){
			// trace('focusin: ' + e.currentTarget);
			storeData();
		});

	}


	// function get_browser() {
	// 	var ua=navigator.userAgent,tem,M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
	// 	if(/trident/i.test(M[1])){
	// 		tem=/\brv[ :]+(\d+)/g.exec(ua) || [];
	// 		return {name:'IE',version:(tem[1]||'')};
	// 		}
	// 	if(M[1]==='Chrome'){
	// 		tem=ua.match(/\bOPR|Edge\/(\d+)/)
	// 		if(tem!=null)   {return {name:'Opera', version:tem[1]};}
	// 		}
	// 	M=M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
	// 	if((tem=ua.match(/version\/(\d+)/i))!=null) {M.splice(1,1,tem[1]);}
	// 	return {
	// 	name: M[0],
	// 	version: M[1]
	// 	};
	// }

	function storeData():Dynamic{

		showSnackBar('Save data to local memory');

		var jsonData = {
			'created':'${Date.now()}',
			'firstname':inputtextfirstnameInput.value.trim(),
			'lastname':inputtextlastnameInput.value.trim(),
			'artistname':inputtextartistnameInput.value.trim(),
			'useartist':inputcheckboxartistnameCheckbox.checked,
			'email':inputemailemailInput.value.trim(),
			'website':inputtextwebsiteInput.value.trim(),
			'twitter':inputtexttwitterInput.value.trim(),
			'linkedin':inputtextLinkedinInput.value.trim(),
			'flickrr':inputtextflickrInput.value.trim(),
			'instagram':inputtextinstagramInput.value.trim(),
			'facebook':inputtextfacebookInput.value.trim(),
			'patreon':inputtextpatreonInput.value.trim(),
			'photo':base64Image,
			'bio':textareabioEnglishInput.value.trim(),
			'description':textareadesciptionEnglishInput.value.trim(),
			'remark':textarearemarkEnglishInput.value.trim(),
			'upcselect':selectupcSelect.value.trim(),
			'country':selectcountrySelect.value.trim(),
			'language0':selectnativeSelect.value.trim(),
			'language1':selectlanguageGoodSelect.value.trim(),
			'language2':selectlanguageUnderstandSelect.value.trim(),
		}
		for (field in Reflect.fields(jsonData)) {
			// trace('$field : ${Reflect.field(jsonData, field)}');
			window.localStorage.setItem('$field','${Reflect.field(jsonData, field)}');
		}
		// trace('counter: ' + window.localStorage.getItem('counter') );
		// window.localStorage.setItem('counter',Std.string(Std.parseInt(window.localStorage.getItem('counter'))+1));
		return jsonData;
	}

	function initSharedObject(){
		image.src = (window.localStorage.getItem("photo") != null) ? window.localStorage.getItem("photo") : "https://dummyimage.com/1000x1000/f011f0/000000.png&text=Minimal+1000+px";

		inputtextfirstnameInput.value = (window.localStorage.getItem("firstname") != null) ? window.localStorage.getItem("firstname") : "";
		inputtextlastnameInput.value = (window.localStorage.getItem("lastname") != null) ? window.localStorage.getItem("lastname") : "";
		inputtextartistnameInput.value = (window.localStorage.getItem("artistname") != null) ? window.localStorage.getItem("artistname") : "";
		inputcheckboxartistnameCheckbox.checked = (window.localStorage.getItem("useartist") != 'false') ? true : false;
		inputemailemailInput.value = (window.localStorage.getItem("email") != null) ? window.localStorage.getItem("email") : "";
		inputtextwebsiteInput.value = (window.localStorage.getItem("website") != null) ? window.localStorage.getItem("website") : "";
		inputtexttwitterInput.value = (window.localStorage.getItem("twitter") != null) ? window.localStorage.getItem("twitter") : "";
		inputtextLinkedinInput.value = (window.localStorage.getItem("linkedin") != null) ? window.localStorage.getItem("linkedin") : "";
		inputtextflickrInput.value = (window.localStorage.getItem("flickrr") != null) ? window.localStorage.getItem("flickrr") : "";
		inputtextinstagramInput.value = (window.localStorage.getItem("instagram") != null) ? window.localStorage.getItem("instagram") : "";
		inputtextfacebookInput.value = (window.localStorage.getItem("facebook") != null) ? window.localStorage.getItem("facebook") : "";
		inputtextpatreonInput.value = (window.localStorage.getItem("patreon") != null) ? window.localStorage.getItem("patreon") : "";
		inputfilephotoFile.value = (window.localStorage.getItem("photoFile") != null) ? window.localStorage.getItem("photoFile") : "";
		textareabioEnglishInput.value = (window.localStorage.getItem("bio") != null) ? window.localStorage.getItem("bio") : "";
		textareadesciptionEnglishInput.value = (window.localStorage.getItem("description") != null) ? window.localStorage.getItem("description") : "";
		textarearemarkEnglishInput.value = (window.localStorage.getItem("remark") != null) ? window.localStorage.getItem("remark") : "";
		selectupcSelect.value = (window.localStorage.getItem("upcselect") != null) ? window.localStorage.getItem("upcselect") : "";
		selectcountrySelect.value = (window.localStorage.getItem("country") != null) ? window.localStorage.getItem("country") : "";
		selectnativeSelect.value = (window.localStorage.getItem("language0") != null) ? window.localStorage.getItem("language0") : "";
		selectlanguageGoodSelect.value = (window.localStorage.getItem("language1") != null) ? window.localStorage.getItem("language1") : "";
		selectlanguageUnderstandSelect.value = (window.localStorage.getItem("language2") != null) ? window.localStorage.getItem("language2") : "";
	}

	function output (){
		var list = new JQuery('input');
		for ( i in 0 ... list.length ) {
			// your code
			var input : InputElement = cast list[i];
			// trace(input);
			// console.log('var input${input.type}${input.id} : InputElement = cast document.getElementById("${input.id}"); trace( input${input.type}${input.id}.value ); ');
			console.log('input${input.type}${input.id}.value = (window.localStorage.getItem("${input.id}") != null) ? window.localStorage.getItem("${input.id}") : "";');
		}

		var area = new JQuery('textarea');
		for ( i in 0 ... area.length ) {
			// your code
			var input : js.html.TextAreaElement = cast area[i];
			// trace(input);
			// console.log('var textarea${input.id} : TextAreaElement = cast document.getElementById("${input.id}"); trace( textarea${input.id}.value ); ');
			console.log('textarea${input.id}.value = (window.localStorage.getItem("${input.id}") != null) ? window.localStorage.getItem("${input.id}") : "";');
		}

		var select = new JQuery('select');
		for ( i in 0 ... select.length ) {
			// your code
			var input : js.html.SelectElement = cast select[i];
			// trace(input);
			// console.log('var select${input.id} : SelectElement = cast document.getElementById("${input.id}"); trace( select${input.id}.value ); ');
			console.log('select${input.id}.value = (window.localStorage.getItem("${input.id}") != null) ? window.localStorage.getItem("${input.id}") : "";');
		}
	}

	function download(text:String, name:String, type:String) {

		showSnackBar('Start download');

		trace('download $text, $name, $type');

		var a = document.createAnchorElement();
	    a.className = "display: none";
		var file = new Blob([text], {type: type});
		// trace(file);


		a.href = URL.createObjectURL(file);
		a.download = name;

		// trace(a);
		// trace(a.href);
		// trace(a.download);

		document.body.appendChild(a);

		a.click();

		untyped setTimeout(function(){
			document.body.removeChild(a);
			window.URL.revokeObjectURL(url);
		}, 100);

// 	unction downloadFile(filename, data) {

//     var a = document.createElement('a');
//     a.style = "display: none";
//     var blob = new Blob(data, {type: "application/octet-stream"});
//     var url = window.URL.createObjectURL(blob);
//     a.href = url;
//     a.download = filename;
//     document.body.appendChild(a);
//     a.click();
//     document.body.removeChild(a);
//     window.URL.revokeObjectURL(url);
// }


	}

	function handleFileSelect (evt) {
		var files = evt.target.files;
		var file = files[0];

		if (files != null && file != null) {
			var reader = new FileReader();

			// reader.onload = function(readerEvt) {
			// 	var binaryString = readerEvt.target.result;

			// 	trace(binaryString);
			// 	// document.getElementById("base64textarea").value = btoa(binaryString);
			// };

			// reader.readAsBinaryString(file);
			reader.onload = function () {
				console.log(reader.result);
				base64Image = (reader.result);
				// base64Image
				image.src = reader.result;
				storeData();
			};
			reader.onerror = function (error) {
				console.log('Error: ', error);
			};
			reader.readAsDataURL(file);
		}
	};

	function getBase64(file) {
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function () {
			console.log(reader.result);
			console.log(reader.result);
		};
		reader.onerror = function (error) {
			console.log('Error: ', error);
		};
	}


	function showSnackBar(?content:String) {
		// Get the snackbar DIV
		var x = document.getElementById("snackbar");

		if(content != null) x.innerText = content;

		// Add the "show" class to DIV
		x.className = "show";

		// After 3 seconds, remove the show class from DIV
		untyped setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}


	// var saveData = (function () {
	// 	var a = document.createElement("a");
	// 	document.body.appendChild(a);
	// 	a.style = "display: none";
	// 	return function (blob, fileName) {
	// 		var url = window.URL.createObjectURL(blob);
	// 		a.href = url;
	// 		a.download = fileName;
	// 		a.click();
	// 		window.URL.revokeObjectURL(url);
	// 	};
	// }());

	// function initHTML () {
	// 	container = document.createDivElement();
	// 	container.id = "example_js_gitlab";
	// 	container.className = "container";
	// 	document.body.appendChild(container);

	// 	var h1 = document.createElement('h1');
	// 	h1.innerText = "Example JS Gitlab";
	// 	container.appendChild(h1);
	// }

	// function loadData(){
	// 	var url = 'http://ip.jsontest.com/';
	// 	var req = new haxe.Http(url);
	// 	// req.setHeader('Content-Type', 'application/json');
	// 	// req.setHeader('auth', '${App.TOKEN}');
	// 	req.onData = function (data : String) {
	// 		try {
	// 			var json = haxe.Json.parse(data);
	// 			trace (json);
	// 		} catch (e:Dynamic){
	// 			trace(e);
	// 		}
	// 	}
	// 	req.onError = function (error : String) {
	// 		trace('error: $error');
	// 	}
	// 	req.onStatus = function (status : Int) {
	// 		trace('status: $status');
	// 	}
	// 	req.request(true);  // false=GET, true=POST
	// }

	static public function main () {
		var app = new Main ();
	}
}
