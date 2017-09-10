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

		var upcRootRelative = new Path('');

		trace('projectRootAbsolute: $projectRootAbsolute , upcRootAbsolute: $upcRootAbsolute' );


		for ( i in 0 ... upcMemberArr.length ) {
			Sys.println('+ convert data for: ${upcMemberArr[i].firstname}');

			var upcObj : UpcObj = upcMemberArr[i];

			var upcMemberFolder = '${projectFolder}docs/${upcObj.firstname.toLowerCase().trim()}';
			createFolder(upcMemberFolder);

			var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapProfile1');

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

			});
			var t1 = new haxe.Template(templateBootStrapIndex);
			var output1 = t1.execute({
				version : VERSION,
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
			});

			writeFile(upcMemberFolder, 'index.html', output1);
		}
		Sys.println('+ write index.html');


		buildHomepage();

		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			upcRoot : upcRootRelative,
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/about.md'))
		});
		writeFile(upcRootAbsolute.toString(), 'about.html', output2);
		var output2 = t2.execute({
			version : VERSION,
			upcRoot : upcRootRelative,
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : Markdown.markdownToHtml(File.getContent('${projectRootAbsolute}/_assets/markdown/mission.md'))
		});
		writeFile(upcRootAbsolute.toString(), 'mission.html', output2);
		Sys.println('Site generated :: done');
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

			});

			memberslist += output0;

		}
		memberslist += '</div></div>';


		var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
		var t2 = new haxe.Template(templateBootStrapIndex);
		var output2 = t2.execute({
			version : VERSION,
			upcRoot : '',
			nav : '<ul class="navbar-nav mr-auto justify-content-end">${setNav(new Path(''))}</ul>',
			content : '<h2>Mission Statement</h2><h2>Urban Paper Members</h2>${memberslist}'
		});
		writeFile(upcRootAbsolute.toString(), 'index.html', output2);
	}


	function setNav(root:Path):String{
		var nav = '';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"about.html")}">About</a></li>';
		nav += '<li><a class="nav-link" href="${Path.normalize(root+"mission.html")}"">Mission</a></li>';
		nav += '<li class="nav-item dropdown">';
		nav += '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Members</a>';
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