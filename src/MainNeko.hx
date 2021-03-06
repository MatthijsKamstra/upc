package;

import haxe.io.Path;
import sys.io.File;
import sys.io.FileOutput;
import sys.FileSystem;

import TypeDef;

using StringTools;

class MainNeko {

	// var photo = upcObj.photo;
	// if(photo != null){
	// 	var replaceStr = 'data:image/png;base64,/';
	// 	var ex = 'png';
	// 	if(photo.indexOf('jpg') != -1){
	// 		trace('jpg');
	// 		replaceStr = 'data:image/jpeg;base64,/';
	// 		ex = 'jpeg';
	// 	}
	// 	var base64Data = photo.replace(replaceStr,"");

	// 	try{
	// 		var temp = haxe.crypto.Base64.decode(photo,false);
	// 		File.saveBytes('${projectFolder}/docs/img/out_${upcObj.firstname}.${ex}', temp);
	// 	} catch (e:Dynamic){
	// 		trace('error: ' + e);
	// 	}
	// }


	var VERSION : String = '0.0.1';

	var projectFolder : String = '';
	var assetFolder : String = '';

	var projectRootAbsolute : Path = new Path('');
	var upcRootAbsolute : Path = new Path('');

	var upcMemberArr : Array<UpcObj> = [];
	var upcFriendsArr : Array<UpcObj> = [];
	var upcAllArr : Array<UpcObj> = [];

	var URL = 'https://matthijskamstra.github.io/upc/';

	public function new () {
		Sys.println('Init CMS');
		init();
	}

	function init(){
		projectFolder = validateFolder(Sys.getCwd());
		projectRootAbsolute  = new Path(Sys.getCwd());
		upcRootAbsolute = new Path ('${Sys.getCwd()}docs');
		assetFolder = projectFolder + '_assets/';

		upcAllArr = getMemberArray(assetFolder); //will update upcMemberArr & upcFriendsArr

		Sys.println('Generate site :: start ');

		buildProfiles();
		buildHomepage();
		buildMissionPage();
		buildAboutPage();

		Sys.println('Generate site :: done');
	}

	function buildMissionPage(){
		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : setNav(new Path('')),
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/about.md')),
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective :: About',
			social_website : URL,
			social_photo : '${URL}/img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',

		});
		writeFile(upcRootAbsolute.toString(), 'about.html', output2);
	}

	function buildAboutPage(){
		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : setNav(new Path('')),
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/mission.md')),
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective :: Mission',
			social_website : URL,
			social_photo : '${URL}/img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',
		});
		writeFile(upcRootAbsolute.toString(), 'mission.html', output2);
	}

	function buildProfiles(){
		trace('projectRootAbsolute: $projectRootAbsolute , upcRootAbsolute: $upcRootAbsolute' );

		for ( i in 0 ... upcAllArr.length ) {
			Sys.println('+ convert data for: ${upcAllArr[i].firstname} / ${upcAllArr[i].artistname}');

			var upcObj : UpcObj = upcAllArr[i];

			// use artist name
			var folderName = upcObj.firstname.toLowerCase().trim().replace(' ', '_');
			if(upcObj.useartist == true){
				folderName = upcObj.artistname.toLowerCase().trim().replace(' ', '_');
			}

			var upcMemberFolder = '${projectFolder}docs/${folderName}';
			createFolder(upcMemberFolder);

			var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapProfile1');

			// check image/photo
			if (upcObj.photo == null || upcObj.photo.startsWith('data:image')){
				if(FileSystem.exists('${upcRootAbsolute}/img/profile/${upcObj.firstname.toLowerCase()}.jpeg')){
					trace('yes, I found an image for ${upcObj.firstname}');
					upcObj.photo = '${upcRootAbsolute}/img/profile/${upcObj.firstname.toLowerCase()}.jpeg'.replace('${upcRootAbsolute.toString()}/','');
				}
				if(FileSystem.exists('${upcRootAbsolute}/img/profile/${upcObj.firstname.toLowerCase()}.jpg')){
					trace('yes, I found an image for ${upcObj.firstname}');
					upcObj.photo = '${upcRootAbsolute}/img/profile/${upcObj.firstname.toLowerCase()}.jpg'.replace('${upcRootAbsolute.toString()}/','');
				}
				if(upcObj.photo == null){
					Sys.println('\t ERROR >>>>>>>>> create file with name for ${upcObj.firstname.toLowerCase()}.jpg or ${upcObj.firstname.toLowerCase()}.jpeg');
					upcObj.photo = 'img/logo/logo.png';
				}
			}
			var testScript = '';
			testScript +=
'
setTimeout(function() {
	UPC.twitterFetch("${upcObj.twitter}", "testimonials-inner");
	UPC.qrcode("${URL + folderName}");
}, 1000);


';

			// validate socials
			if(upcObj.website.startsWith('www')) upcObj.website = 'http://' + upcObj.website;
			upcObj.twitter = validateURL(upcObj.twitter, SocialType.Twitter);
			upcObj.facebook = validateURL(upcObj.facebook, SocialType.Facebook);
			upcObj.flickrr = validateURL(upcObj.flickrr, SocialType.Flickr);
			upcObj.instagram = validateURL(upcObj.instagram, SocialType.Instagram);
			upcObj.linkedin = validateURL(upcObj.linkedin, SocialType.Linkedin);
			upcObj.patreon = validateURL(upcObj.patreon, SocialType.Patreon);
			upcObj.pinterest = validateURL(upcObj.pinterest, SocialType.Pinterest);

			if (upcObj.country != null){
				// trace(utils.CountryCode.getCountryName(upcObj.country));
				upcObj.country = utils.CountryCode.getCountryName(upcObj.country);
			}

			if (upcObj.language0 != null){
				// trace(utils.LanguageCode.getLanguageName(upcObj.language0));
				upcObj.language0 = utils.LanguageCode.getLanguageName(upcObj.language0);
			}
			if (upcObj.language1 != null){
				// trace(utils.LanguageCode.getLanguageName(upcObj.language1));
				upcObj.language1 = utils.LanguageCode.getLanguageName(upcObj.language1);
			}
			if (upcObj.language2 != null){
				// trace(utils.LanguageCode.getLanguageName(upcObj.language2));
				upcObj.language2 = utils.LanguageCode.getLanguageName(upcObj.language2);
			}

			if(upcObj.useartist == true){
				trace('${upcObj.firstname} wants to use Artistname: ${upcObj.artistname}');
				upcObj.firstname = '';
				upcObj.lastname = '';
				// return;
			}



			var t0 = new haxe.Template(templateBootStrapProfile);
			var output0 = t0.execute({
				firstname : upcObj.firstname,
				lastname : upcObj.lastname,
				artistname : upcObj.artistname,
				website : upcObj.website,
				twitter : upcObj.twitter,
				linkedin : upcObj.linkedin,
				flickrr : upcObj.flickrr,
				instagram : upcObj.instagram,
				facebook : upcObj.facebook,
				patreon : upcObj.patreon,
				photo : '../${upcObj.photo}',
				bio : upcObj.bio,
				description : upcObj.description,
				remark : upcObj.remark,
				upcselect : upcObj.upcselect,
				city : upcObj.city,
				country : upcObj.country,
				language0 : upcObj.language0,
				language1 : upcObj.language1,
				language2 : upcObj.language2,
				social_description: upcObj.description,
				social_author: '${upcObj.firstname} ${upcObj.lastname}',
				social_title: 'Urban Paper profile of ${upcObj.firstname} ${upcObj.lastname} aka ${upcObj.artistname}',
				social_website : upcObj.website,
				social_photo : '../${upcObj.photo}',
				social_description_long : upcObj.bio,
				update : Date.now(),
				script : testScript,

			});
			var t1 = new haxe.Template(templateBootStrapIndex);
			var output1 = t1.execute({
				version : VERSION,
				update : Date.now(),
				upcRoot : '../',
				nav : setNav(new Path('../')),
				firstname : upcObj.firstname,
				lastname : upcObj.lastname,
				artistname : upcObj.artistname,
				website : upcObj.website,
				twitter : upcObj.twitter,
				linkedin : upcObj.linkedin,
				flickrr : upcObj.flickrr,
				instagram : upcObj.instagram,
				facebook : upcObj.facebook,
				patreon : upcObj.patreon,
				photo : upcObj.photo,
				bio : upcObj.bio,
				description : upcObj.description,
				remark : upcObj.remark,
				upcselect : upcObj.upcselect,
				city : upcObj.city,
				country : upcObj.country,
				language0 : upcObj.language0,
				language1 : upcObj.language1,
				language2 : upcObj.language2,
				content : output0,
				social_description: upcObj.description,
				social_author: '${upcObj.firstname} ${upcObj.lastname}',
				social_title: 'Urban Paper profile of ${upcObj.firstname} ${upcObj.lastname} aka ${upcObj.artistname}',
				social_website : upcObj.website,
				social_photo : '../${upcObj.photo}',
				social_description_long : upcObj.bio,
			});

			var shortstuff = '<h1>${upcObj.firstname} ${upcObj.lastname}</h1>';
			shortstuff += '<div class="container"><div class="row"><div class="col-6">';
			for (field in Reflect.fields(upcObj)) {
				if(field == 'email') continue;
				if(field == 'created') continue;
				// trace('$field : ${Reflect.field(upcObj, field)}');
				if(field == 'photo'){
					shortstuff += '<div class="row"><div class="col"><b>${field}</b></div><div class="col"><img src="../${Reflect.field(upcObj, field)}" class="img-fluid rounded-circle" alt="Responsive image"></div></div>';
				} else {
					shortstuff += '<div class="row"><div class="col"><b>${field}</b></div><div class="col">${Reflect.field(upcObj, field)}</div></div>';
				}
			}

			shortstuff += '</div><div class="col-6">editor will be here later</div></div></div>';

			var t2 = new haxe.Template(templateBootStrapIndex);
			var output2 = t2.execute({
				version : VERSION,
				update : Date.now(),
				upcRoot : '../',
				nav : setNav(new Path('../')),
				content : shortstuff,
			});

			writeFile(upcMemberFolder, 'index.html', output1);
			writeFile(upcMemberFolder, 'info.html', output2);

			// remove data
			Reflect.deleteField (upcObj, 'email');
			Reflect.deleteField (upcObj, 'created');
			writeFile(upcMemberFolder, 'data.json', haxe.Json.stringify(upcObj, '\t'));
		}
		Sys.println('+ write index.html');
	}

	function buildHomepage (){
		var memberslist = '<!-- member list --><div class="container"><div class="row">';

		for ( i in 0 ... upcMemberArr.length ) {
			Sys.println('+ homepage convert data for: ${upcMemberArr[i].firstname} / ${upcMemberArr[i].artistname}');

			var upcObj : UpcObj = upcMemberArr[i];
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapHomeProfile');

			// use artist name
			var folderName = upcObj.firstname.toLowerCase().trim().replace(' ', '_');
			if(upcObj.useartist == true){
				folderName = upcObj.artistname.toLowerCase().trim().replace(' ', '_');
			}
			// var upcMemberFolder = '${projectFolder}docs/${folderName}';


			var t0 = new haxe.Template(templateBootStrapProfile);
			var output0 = t0.execute({
				memberfolder : folderName,
				firstname : upcObj.firstname,
				lastname : upcObj.lastname,
				artistname : upcObj.artistname,
				website : upcObj.website,
				twitter : upcObj.twitter,
				linkedin : upcObj.linkedin,
				flickrr : upcObj.flickrr,
				instagram : upcObj.instagram,
				facebook : upcObj.facebook,
				patreon : upcObj.patreon,
				photo : upcObj.photo,
				bio : upcObj.bio,
				description : upcObj.description,
				remark : upcObj.remark,
				upcselect : upcObj.upcselect,
				city : upcObj.city,
				country : upcObj.country,
				language0 : upcObj.language0,
				language1 : upcObj.language1,
				language2 : upcObj.language2,
				social_description: upcObj.description,
				social_author: '${upcObj.firstname} ${upcObj.lastname}',
				social_title: 'Urban Paper profile of ${upcObj.firstname} ${upcObj.lastname} aka ${upcObj.artistname}',
				social_website : upcObj.website,
				social_photo : '../${upcObj.photo}',
				social_description_long : upcObj.bio,
				update : Date.now(),

			});

			memberslist += output0;

		}
		memberslist += '</div></div>';


		var friendslist = '<!-- friends list --><div class="container"><div class="row">';

		for ( i in 0 ... upcFriendsArr.length ) {
			Sys.println('+ convert data for: ${upcFriendsArr[i].firstname}');

			var upcObj : UpcObj = upcFriendsArr[i];
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapHomeProfile');

			var t0 = new haxe.Template(templateBootStrapProfile);
			var output0 = t0.execute({
				memberfolder : upcObj.firstname.toLowerCase(),
				firstname : upcObj.firstname,
				lastname : upcObj.lastname,
				artistname : upcObj.artistname,
				website : upcObj.website,
				twitter : upcObj.twitter,
				linkedin : upcObj.linkedin,
				flickrr : upcObj.flickrr,
				instagram : upcObj.instagram,
				facebook : upcObj.facebook,
				patreon : upcObj.patreon,
				photo : upcObj.photo,
				bio : upcObj.bio,
				description : upcObj.description,
				remark : upcObj.remark,
				upcselect : upcObj.upcselect,
				city : upcObj.city,
				country : upcObj.country,
				language0 : upcObj.language0,
				language1 : upcObj.language1,
				language2 : upcObj.language2,
				social_description: upcObj.description,
				social_author: '${upcObj.firstname} ${upcObj.lastname}',
				social_title: 'Urban Paper profile of ${upcObj.firstname} ${upcObj.lastname} aka ${upcObj.artistname}',
				social_website : upcObj.website,
				social_photo : '../${upcObj.photo}',
				social_description_long : upcObj.bio,
				update : Date.now(),

			});

			friendslist += output0;

		}
		friendslist += '</div></div>';

		var carousel = '
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img class="d-block w-100" src="img/what1.png" alt="Second slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="img/bottom_whoweare.png" alt="First slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="img/what4.png" alt="Third slide">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
		';


		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : setNav(new Path('')),
			content : '${carousel}<h2 id="upcmembers">Urban Paper Members</h2>${memberslist}<h2 id="upcmembers">Urban Paper Friends</h2>${friendslist}',
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective',
			social_website : '${URL}',
			social_photo : '${URL}img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',
		});
		writeFile(upcRootAbsolute.toString(), 'index.html', output2);
	}


	function setNav(root:Path):String{
		var nav = '';
		nav += '<ul class="navbar-nav mr-auto justify-content-end">';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"about.html")}">About</a></li>';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"mission.html")}"">What we do</a></li>';
		// dropdown members
		nav += '<li class="nav-item dropdown">';
		nav += '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Who we are</a>';
		nav += '<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">';
		for (i in upcMemberArr){
			if(i.useartist == true){
				nav += '<a class="dropdown-item" href="${Path.normalize(root+i.artistname.toLowerCase().trim().replace(' ', '_'))}/index.html">${i.artistname}</a>';
			} else {
				nav += '<a class="dropdown-item" href="${Path.normalize(root+i.firstname.toLowerCase())}/index.html">${i.firstname}</a>';
			}
		}
		nav += '</div></li>';
		// dropdown family
		nav += '<li class="nav-item dropdown">';
		nav += '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Friends and Family</a>';
		nav += '<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">';
		for (i in upcFriendsArr){
			nav += '<a class="dropdown-item" href="${Path.normalize(root+i.firstname.toLowerCase())}/index.html">${i.firstname}</a>';
		}
		nav += '</div></li>';
		nav += '</ul>';
		return nav;
	}

	function getMemberArray (assetFolder:String) : Array<UpcObj> {
		Sys.println('+ Convert data to groups "member" / "familie" ');
		var temp : Array<UpcObj> = [];
		var arr = FileSystem.readDirectory(assetFolder);
		for ( i in 0 ... arr.length ) {
			Sys.println('+ read assets: ${arr[i]}');
			if(arr[i].indexOf('.DS_Store') != -1) continue;
			if(FileSystem.isDirectory('${assetFolder}/${arr[i]}')) continue;
			var str = File.getContent('$assetFolder${arr[i]}');
			var upcObj : UpcObj = haxe.Json.parse(str);
			// trace(upcObj.upcselect, type);
			if(upcObj.upcselect == 'upcmember') {
				trace('+++++ yes, \'upcmember\' == ${upcObj.upcselect}');
				upcMemberArr.push(upcObj);
			} else {
				upcFriendsArr.push(upcObj);
			}
			temp.push(upcObj);
		}
		return temp;
	}


	function validateURL(url:String, type:SocialType) : String{
		var newURL = url;
		if(newURL == null || newURL == '') return '';
		var preURL = '';
		switch (type) {
			case SocialType.Twitter :
				preURL = 'https://twitter.com/';
				newURL = newURL.replace('@','');
			case SocialType.Flickr :
				if(newURL.indexOf('https://www.flickr.com/') != -1)
					preURL = '';
				else
					preURL = 'https://www.flickr.com/';
			case SocialType.Patreon :
				preURL = 'https://www.patreon.com/';
			case SocialType.Facebook :
				preURL = 'https://www.facebook.com/';
			case SocialType.Linkedin :
				preURL = 'https://www.linkedin.com/in/';
			case SocialType.Instagram :
				preURL = 'https://www.instagram.com/';
			case SocialType.Behance :
				preURL = 'https://www.behance.net/';
			case SocialType.Pinterest :
				preURL = 'https://www.pinterest.com/';
			default :
				trace ("case '"+type+"': trace ('"+type+"');");
		}
		return preURL + newURL;
	}

	/*
	*  clean up folder structure
	* 	 - no spaces at the start and end of the path
	* 	 - has to end with a backslash ("/")
	* 	 - remove \ to escape folder structures with spaces in it `Volume/foobar/this\ is\ bad/`
	*/
	function validateFolder (folder:String) : String
	{
		folder = folder.trim().trim();
		folder = folder.replace("\\ "," ");
		if (folder.charAt(folder.length-1) != "/"){
			folder += "/";
		}
		return folder;
	}



	function writeFile (path:String, name:String, content:String) {
		sys.io.File.saveContent(path + '/' + name, content);
		Sys.println('\t> write file: "${name}" in "${path}"');
	}

	function createFolder(folder:String){
		if (!sys.FileSystem.exists(folder)) {
			try {
				sys.FileSystem.createDirectory(folder);
			} catch(e:Dynamic){
				trace(e);
			}
		}
		Sys.println('\t> create folder: "$folder"');
	}


	static public function main () {
		var app = new MainNeko ();
	}
}

enum SocialType {
  Twitter;
  Facebook;
  Flickr;
  Instagram;
  Linkedin;
  Patreon;
  Behance;
  Pinterest;
}
