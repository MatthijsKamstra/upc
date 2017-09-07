package;

import js.Browser.*;
import js.Browser;
import js.html.*;

import model.constants.App;


import js.Browser.*;
import js.Browser;
import js.html.*;
import js.jquery.*;

import js.html.FileReader;


import model.constants.App;



import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.html.svg.SVGElement;

import createjs.*;

// import PDFDocument;

using StringTools;


/**
 * @author Matthijs Kamstra aka [mck]
 * MIT
 *
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


		new JQuery('#save-btn').click(function(e){
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

	function storeData():Dynamic{
		var jsonData = {
			'created':'${Date.now()}',
			'firstname':inputtextfirstnameInput.value,
			'lastname':inputtextlastnameInput.value,
			'artistname':inputtextartistnameInput.value,
			'useartist':inputcheckboxartistnameCheckbox.checked,
			'email':inputemailemailInput.value,
			'website':inputtextwebsiteInput.value,
			'twitter':inputtexttwitterInput.value,
			'linkedin':inputtextLinkedinInput.value,
			'flickrr':inputtextflickrInput.value,
			'instagram':inputtextinstagramInput.value,
			'photo':base64Image,
			'bio':textareabioEnglishInput.value,
			'description':textareadesciptionEnglishInput.value,
			'remark':textarearemarkEnglishInput.value,
			'upcselect':selectupcSelect.value,
			'country':selectcountrySelect.value,
			'language0':selectnativeSelect.value,
			'language1':selectlanguageGoodSelect.value,
			'language2':selectlanguageUnderstandSelect.value,
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
		var a = document.createAnchorElement();
		var file = new Blob([text], {type: type});
		a.href = URL.createObjectURL(file);
		a.download = name;
		a.click();
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

	function initHTML () {
		container = document.createDivElement();
		container.id = "example_js_gitlab";
		container.className = "container";
		document.body.appendChild(container);

		var h1 = document.createElement('h1');
		h1.innerText = "Example JS Gitlab";
		container.appendChild(h1);
	}

	function loadData(){
		var url = 'http://ip.jsontest.com/';
		var req = new haxe.Http(url);
		// req.setHeader('Content-Type', 'application/json');
		// req.setHeader('auth', '${App.TOKEN}');
		req.onData = function (data : String) {
			try {
				var json = haxe.Json.parse(data);
				trace (json);
			} catch (e:Dynamic){
				trace(e);
			}
		}
		req.onError = function (error : String) {
			trace('error: $error');
		}
		req.onStatus = function (status : Int) {
			trace('status: $status');
		}
		req.request(true);  // false=GET, true=POST
	}

	static public function main () {
		var app = new Main ();
	}
}
