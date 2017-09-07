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

	public function new () {
		trace( "Hello 'Example JS Gitlab'" );
		init();
	}

	function init() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Dom ready :: build: ${App.BUILD} ');

			// var container = document.getElementById("prop");
			// container.innerHTML = 'html';

			initBtn();

			// initHTML();
			// loadData();
		});
	}

	function initBtn(){
		new JQuery('#test-fill-btn').click(function(e){
			e.preventDefault();
			var inputtextfirstnameInput : InputElement = cast document.getElementById("firstnameInput");
			inputtextfirstnameInput.value = 'Matthijs';
			var inputtextlastnameInput : InputElement = cast document.getElementById("lastnameInput");
			inputtextlastnameInput.value = 'Kamstra';
			var inputtextartistnameInput : InputElement = cast document.getElementById("artistnameInput");
			inputtextartistnameInput.value = '[mck]';
			var inputcheckboxartistnameCheckbox : InputElement = cast document.getElementById("artistnameCheckbox");
			inputcheckboxartistnameCheckbox.value = 'checked';
			var inputemailemailInput : InputElement = cast document.getElementById("emailInput");
			inputemailemailInput.value = 'grumm@foo.bar';
			var inputtextwebsiteInput : InputElement = cast document.getElementById("websiteInput");
			inputtextwebsiteInput.value = 'http://www.matthijskamstra.nl';
			var inputtexttwitterInput : InputElement = cast document.getElementById("twitterInput");
			inputtexttwitterInput.value = 'https://twitter.com/matthijskamstra';
			var inputtextLinkedinInput : InputElement = cast document.getElementById("LinkedinInput");
			inputtextLinkedinInput.value = 'https://linked';
			var inputtextflickrInput : InputElement = cast document.getElementById("flickrInput");
			inputtextflickrInput.value = 'https://flickrr';
			var inputtextinstagramInput : InputElement = cast document.getElementById("instagramInput");
			inputtextinstagramInput.value = 'https://instagram';
			// var inputfilephotoFile : InputElement = cast document.getElementById("photoFile");
			// inputfilephotoFile.value = 'foo';
			var textareabioEnglishInput : TextAreaElement = cast document.getElementById("bioEnglishInput");
			textareabioEnglishInput.value = 'I love foobar';
			var textareadesciptionEnglishInput : TextAreaElement = cast document.getElementById("desciptionEnglishInput");
			textareadesciptionEnglishInput.value = 'paper artist';
			var textarearemarkEnglishInput : TextAreaElement = cast document.getElementById("remarkEnglishInput");
			textarearemarkEnglishInput.value = 'I have no clue';
			// var selectupcSelect : SelectElement = cast document.getElementById("upcSelect");
			// selectupcSelect.value = 'foo';
			var selectcountrySelect : SelectElement = cast document.getElementById("countrySelect");
			selectcountrySelect.value = 'NL';
			var selectnativeSelect : SelectElement = cast document.getElementById("nativeSelect");
			selectnativeSelect.value = 'NL';
			var selectlanguageGoodSelect : SelectElement = cast document.getElementById("languageGoodSelect");
			selectlanguageGoodSelect.value = 'EN';
			var selectlanguageUnderstandSelect : SelectElement = cast document.getElementById("languageUnderstandSelect");
			selectlanguageUnderstandSelect.value = 'DE';

		});


		new JQuery('#save-btn').click(function(e){
			e.preventDefault();
			trace('save-btn');

			var inputtextfirstnameInput : InputElement = cast document.getElementById("firstnameInput"); trace( inputtextfirstnameInput.value );
			var inputtextlastnameInput : InputElement = cast document.getElementById("lastnameInput"); trace( inputtextlastnameInput.value );
			var inputtextartistnameInput : InputElement = cast document.getElementById("artistnameInput"); trace( inputtextartistnameInput.value );
			var inputcheckboxartistnameCheckbox : InputElement = cast document.getElementById("artistnameCheckbox"); trace( inputcheckboxartistnameCheckbox.value );
			var inputemailemailInput : InputElement = cast document.getElementById("emailInput"); trace( inputemailemailInput.value );
			var inputtextwebsiteInput : InputElement = cast document.getElementById("websiteInput"); trace( inputtextwebsiteInput.value );
			var inputtexttwitterInput : InputElement = cast document.getElementById("twitterInput"); trace( inputtexttwitterInput.value );
			var inputtextLinkedinInput : InputElement = cast document.getElementById("LinkedinInput"); trace( inputtextLinkedinInput.value );
			var inputtextflickrInput : InputElement = cast document.getElementById("flickrInput"); trace( inputtextflickrInput.value );
			var inputtextinstagramInput : InputElement = cast document.getElementById("instagramInput"); trace( inputtextinstagramInput.value );
			var inputfilephotoFile : InputElement = cast document.getElementById("photoFile"); trace( inputfilephotoFile.value );
			var textareabioEnglishInput : TextAreaElement = cast document.getElementById("bioEnglishInput"); trace( textareabioEnglishInput.value );
			var textareadesciptionEnglishInput : TextAreaElement = cast document.getElementById("desciptionEnglishInput"); trace( textareadesciptionEnglishInput.value );
			var textarearemarkEnglishInput : TextAreaElement = cast document.getElementById("remarkEnglishInput"); trace( textarearemarkEnglishInput.value );
			var selectupcSelect : SelectElement = cast document.getElementById("upcSelect"); trace( selectupcSelect.value );
			var selectcountrySelect : SelectElement = cast document.getElementById("countrySelect"); trace( selectcountrySelect.value );
			var selectnativeSelect : SelectElement = cast document.getElementById("nativeSelect"); trace( selectnativeSelect.value );
			var selectlanguageGoodSelect : SelectElement = cast document.getElementById("languageGoodSelect"); trace( selectlanguageGoodSelect.value );
			var selectlanguageUnderstandSelect : SelectElement = cast document.getElementById("languageUnderstandSelect"); trace( selectlanguageUnderstandSelect.value );


			var jsonData = {
				'created':'${Date.now()}',
				'firstname':inputtextfirstnameInput.value,
				'lastname':inputtextlastnameInput.value,
				'artistname':inputtextartistnameInput.value,
				'useartist':inputcheckboxartistnameCheckbox.value,
				'email':inputemailemailInput.value,
				'website':inputtextwebsiteInput.value,
				'twitter':inputtexttwitterInput.value,
				'linkedin':inputtextLinkedinInput.value,
				'flickrr':inputtextflickrInput.value,
				'instagram':inputtextinstagramInput.value,
				'photo':inputfilephotoFile.value,
				'bio':textareabioEnglishInput.value,
				'description':textareadesciptionEnglishInput.value,
				'remark':textarearemarkEnglishInput.value,
				'upcselect':selectupcSelect.value,
				'country':selectcountrySelect.value,
				'language0':selectnativeSelect.value,
				'language1':selectlanguageGoodSelect.value,
				'language2':selectlanguageUnderstandSelect.value,
			}
			download(haxe.Json.stringify( jsonData), 'upc_${inputtextfirstnameInput.value}_${inputtextlastnameInput.value}.json', 'text/plain');
		});
		new JQuery('#test-btn').click(function(e){
			e.preventDefault();
			trace('test-btn');
			var firstname = cast(document.getElementById('firstnameInput'), js.html.InputElement).value;
			trace(firstname);
			var list = new JQuery('input');
			for ( i in 0 ... list.length ) {
				// your code
				var input : InputElement = cast list[i];
				// trace(input);
				console.log('var input${input.type}${input.id} : InputElement = cast document.getElementById("${input.id}"); trace( input${input.type}${input.id}.value ); ');
			}

			var area = new JQuery('textarea');
			for ( i in 0 ... area.length ) {
				// your code
				var input : js.html.TextAreaElement = cast area[i];
				// trace(input);
				console.log('var textarea${input.id} : TextAreaElement = cast document.getElementById("${input.id}"); trace( textarea${input.id}.value ); ');
			}

			var select = new JQuery('select');
			for ( i in 0 ... select.length ) {
				// your code
				var input : js.html.SelectElement = cast select[i];
				// trace(input);
				console.log('var select${input.id} : SelectElement = cast document.getElementById("${input.id}"); trace( select${input.id}.value ); ');
			}

		});
	}

	function download(text:String, name:String, type:String) {
		var a = document.createAnchorElement();
		var file = new Blob([text], {type: type});
		a.href = URL.createObjectURL(file);
		a.download = name;
		a.click();
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
