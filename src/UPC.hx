package;

import js.Browser.*;
import model.constants.App;

@:expose
class UPC {



	public function new () {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('Dom ready :: build: ${App.BUILD} ');
			initUpdate();
		});
	}
	function initUpdate(){
		var updated = document.getElementById('last-updated');
		if(updated != null) updated.innerText ='Last update: ${App.BUILD}';
	}

	@:keep
	static public function twitterFetch(name:String, domId:String){
		trace ('twitterFetcher : $name');
		var configProfile = {
			"profile": {"screenName": '${name}'},
			"domId": '${domId}',
			"maxTweets": 5,
			"enableLinks": true,
			"showUser": true,
			"showTime": true,
			"showImages": false,
			"lang": "en"
		};
		untyped __js__ ("twitterFetcher.fetch({0})", configProfile);
	}

	/**
	 *  twitterFetcher.fetch('452474033284456448', 'testimonials-inner', 8, true, true, false, '', false, handleTweets, true);

function handleTweets(tweets) {
    var x = tweets.length;
    var n = 0;
    var z = 0;
    var element = document.getElementById('testimonials-inner');
    var html = '<ol class="carousel-indicators">';
        while (z < x) {
        html += '<li data-target="#testimonials-inner" data-slide-to="' + [z] + '"></li>';
        z++;
    }
    html += '</ol>';
    html += '<div class="carousel-inner">';
    while (n < x) {
        html += '<div class="item"><blockquote>' + tweets[n] + '</blockquote></div>';
        n++;
    }
    html += '</div>';
    html += '<a data-slide="prev" href="#testimonials-inner" class="left carousel-control"><i class="fa fa-chevron-left"></i></a>';
    html += '<a data-slide="next" href="#testimonials-inner" class="right carousel-control"><i class="fa fa-chevron-right"></i></a>';
    element.innerHTML = html;
}
	 */

	static public function main () {
		var app = new UPC ();
	}
}
