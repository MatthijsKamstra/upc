package;

import js.Browser.*;
import model.constants.App;

@:expose
class UPC {

	public function new () {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Dom ready :: build: ${App.BUILD} ');
			initUpdate();
			initImages();
			initCharts();
		});
	}
	function initUpdate(){
		var updated = document.getElementById('last-updated');
		if(updated != null) updated.innerText ='Last update: ${App.BUILD}';
	}
	function initImages(){
		var arr = document.getElementById('wrapper').getElementsByTagName('img');
		for ( i in 0 ... arr.length ) {
			var img = arr[i];
			// if(img.parentElement.className == 'navbar-brand') continue;
			img.className = 'img-fluid img-fluid-max';
		}
	}
	function initCharts(){
		// https://github.com/rendro/easy-pie-chart
		var element = document.querySelectorAll('.chart');
		for (i in 0...element.length){
			var _element = element[i];
			//your code
			untyped __js__ (
			'new EasyPieChart({0}, {
				// your options goes here
			});', _element);
		}
	}

	/**
	 *  @example
	 *  	UPC.twitterFetch("matthijskamstra", "testimonials-inner");
	 *  @param name -
	 *  @param domId -
	 */
	@:keep
	static public function twitterFetch(name:String, domId:String){
		if(name == null || name == '') {
			trace('UPC.twitterFetcher : this user has no twitter account');
			return;
		}
		trace ('UPC.twitterFetcher : $name');
		var configProfile = {
			"profile": {"screenName": '${name}'},
			"domId": '${domId}',
			"maxTweets": 5,
			"enableLinks": true,
			"showUser": false,
			"showTime": true,
			"showImages": false,
			"lang": "en",
			"customCallback" : UPC.handleTweets
		};
		untyped __js__ ("twitterFetcher.fetch({0})", configProfile);
		untyped __js__ ("$('.carousel').carousel({
			pause: true,
			interval: 4000,
		});");

	}

	/**
	 *  twitterFetcher.fetch('452474033284456448', 'testimonials-inner', 8, true, true, false, '', false, handleTweets, true);
	 */
	 @:keep
	static public function handleTweets(tweets:Array<Dynamic>) {
		// trace('handleTweets $tweets');

		// for (i in 0...tweets.length){
		// 	var _tweets = tweets[i];
		// 	// trace('$i ${_tweets}');
		// }
		var x = tweets.length;
		var n = 0;
		var z = 0;
		var element = document.getElementById('carouselExampleControls');
		var html = '';
		html += '<ol class="carousel-indicators">';
		while (z < x) {
			var klass =  (z > 0 ) ? '' : 'active';
			html += '<li data-target="#carouselExampleControls" data-slide-to="${z}" class="${klass}"></li>';
			z++;
		}
		html += '</ol>';

		html += '<div class="carousel-inner">';
		while (n < x) {
			var klass =  (n > 0 ) ? '' : 'active';
			html += '<div class="carousel-item ${klass}" style="background-color:black;">
			<img class="d-block w-100" style="opacity: 0.2;" src="http://lorempixel.com/1600/900/abstract/?${n}" alt="First slide">
			<div class="carousel-caption d-none d-md-block">
				<p>${tweets[n]}</p>
			</div>
			</div>';
			n++;
		}
		html += '</div>';

		html += '
<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
<span class="carousel-control-prev-icon" aria-hidden="true"></span>
<span class="sr-only">Previous</span>
</a>
<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
<span class="carousel-control-next-icon" aria-hidden="true"></span>
<span class="sr-only">Next</span>
</a>
';


		element.innerHTML = html;
	}

	static public function main () {
		var app = new UPC ();
	}
}
