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

	public function new () {
		Sys.println('Init CMS');
		init();
	}

	function init(){

		projectFolder = validateFolder(Sys.getCwd());
		projectRootAbsolute  = new Path(Sys.getCwd());
		upcRootAbsolute = new Path ('${Sys.getCwd()}docs');
		assetFolder = projectFolder + '_assets/';
		upcMemberArr = getMemberArray(assetFolder);

		buildProfiles();
		buildHomepage();

		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/about.md')),
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective :: About',
			social_website : 'https://matthijskamstra.github.io/upc/',
			social_photo : 'https://matthijskamstra.github.io/upc/img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',

		});
		writeFile(upcRootAbsolute.toString(), 'about.html', output2);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/mission.md')),
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective :: Mission',
			social_website : 'https://matthijskamstra.github.io/upc/',
			social_photo : 'https://matthijskamstra.github.io/upc/img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',

		});
		writeFile(upcRootAbsolute.toString(), 'mission.html', output2);
		Sys.println('Site generated :: done');
	}


	function buildProfiles(){
		trace('projectRootAbsolute: $projectRootAbsolute , upcRootAbsolute: $upcRootAbsolute' );

		for ( i in 0 ... upcMemberArr.length ) {
			Sys.println('+ convert data for: ${upcMemberArr[i].firstname}');

			var upcObj : UpcObj = upcMemberArr[i];

			var upcMemberFolder = '${projectFolder}docs/${upcObj.firstname.toLowerCase().trim()}';
			createFolder(upcMemberFolder);

			var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapProfile1');

			// check image
			if (upcObj.photo == null || upcObj.photo.startsWith('data:image')){
				if(FileSystem.exists('${upcRootAbsolute}/img/members/${upcObj.firstname.toLowerCase()}.jpeg')){
					trace('yes, I found an image for ${upcObj.firstname}');
					upcObj.photo = '${upcRootAbsolute}/img/members/${upcObj.firstname.toLowerCase()}.jpeg'.replace('${upcRootAbsolute.toString()}/','');
				}
				if(upcObj.photo == null){
					upcObj.photo = 'img/logo/logo.png';
				}
			}
			// validate socials
			if(upcObj.website.startsWith('www')) upcObj.website = 'http://' + upcObj.website;

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
			var t1 = new haxe.Template(templateBootStrapIndex);
			var output1 = t1.execute({
				version : VERSION,
				update : Date.now(),
				upcRoot : '../',
				nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path('../'))}</ul>',
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
				nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path('../'))}</ul>',
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
		var memberslist = '<!-- etst --><div class="container"><div class="row">';

		for ( i in 0 ... upcMemberArr.length ) {
			Sys.println('+ convert data for: ${upcMemberArr[i].firstname}');

			var upcObj : UpcObj = upcMemberArr[i];
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapHomeProfile');

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
				photo : upcObj.photo,
				bio : upcObj.bio,
				description : upcObj.description,
				remark : upcObj.remark,
				upcselect : upcObj.upcselect,
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


		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			update : Date.now(),
			upcRoot : '',
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : '<h2>Mission Statement</h2><h2>Urban Paper Members</h2>${memberslist}',
			social_description: 'Urban Paper Collective',
			social_author: 'Matthijs Kamstra aka [mck]',
			social_title: 'Urban Paper Collective',
			social_website : 'https://matthijskamstra.github.io/upc/',
			social_photo : 'https://matthijskamstra.github.io/upc/img/logo/logo.png',
			social_description_long : 'Urban Paper Collective',
		});
		writeFile(upcRootAbsolute.toString(), 'index.html', output2);
	}


	function setNav(root:Path):String{
		var nav = '';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"about.html")}">About</a></li>';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"mission.html")}"">What we do</a></li>';
		nav += '<li class="nav-item dropdown">';
		nav += '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Who we are</a>';
		nav += '<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">';
		for (i in upcMemberArr){
			nav += '<a class="dropdown-item" href="${Path.normalize(root+i.firstname.toLowerCase())}/index.html">${i.firstname}</a>';
			// nav += '<li><a class="nav-link" href="#${i.firstname.toLowerCase()}">${i.firstname}</a></li>';
		}
		nav += '</div></li>';
		return nav;
	}

	function getMemberArray (assetFolder:String) : Array<UpcObj> {
		var temp : Array<UpcObj> = [];
		var arr = FileSystem.readDirectory(assetFolder);
		for ( i in 0 ... arr.length ) {
			Sys.println('+ read assets: ${arr[i]}');
			if(arr[i].indexOf('.DS_Store') != -1) continue;
			if(FileSystem.isDirectory('${assetFolder}/${arr[i]}')) continue;
			var str = File.getContent('$assetFolder${arr[i]}');
			var upcObj : UpcObj = haxe.Json.parse(str);
			temp.push(upcObj);
		}
		return temp;
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

	function readConfig() : Void
	{
		var folder = Sys.getCwd();

		// var json : HxGenConfig;
		// if (sys.FileSystem.exists(folder + 'hxgenerate.json')) {
		// 	var str = (sys.io.File.getContent(folder +  'hxgenerate.json'));
		// 	json = haxe.Json.parse(str);
		// 	projectFolder 	= json.folder;
		// 	projectTarget 	= json.target;
		// 	projectName 	= json.name;
		// 	projectAuthor  	= json.author;
		// 	projectLicense 	= json.license;
		// } else {
		// 	Sys.println('ERROR: can\'t find the config (${folder}hxgenerate.json)');
		// }
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