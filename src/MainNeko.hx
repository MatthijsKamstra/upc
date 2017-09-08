package;

import sys.io.File;
import sys.io.FileOutput;
import sys.FileSystem;

import TypeDef;

using StringTools;

class MainNeko {

	private var VERSION : String = '0.0.1';

	private var projectFolder 	: String = '';

	public function new () {
		trace('neko');

		projectFolder = validateFolder(Sys.getCwd());

		var assetFolder = projectFolder + '_assets/';
		var arr = FileSystem.readDirectory(assetFolder);

		for ( i in 0 ... arr.length ) {
			// trace(arr[i]);
			var str = File.getContent('$assetFolder${arr[i]}');
			var upcObj : UpcObj = haxe.Json.parse(str);

			var upcFolder = '${projectFolder}docs/${upcObj.firstname.toLowerCase().trim()}';
			createFolder(upcFolder);

			var templateBootStrapIndex = haxe.Resource.getString('BootstrapIndex');
			var templateBootStrapProfile = haxe.Resource.getString('BootstrapProfile');

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
				content : output0,
			});

			writeFile(upcFolder, 'index.html', output1);
		}

		Sys.println('HxGenerate :: done');
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
	}

	function createFolder(folder:String){
		if (!sys.FileSystem.exists(folder)) {
			try {
				sys.FileSystem.createDirectory(folder);
			} catch(e:Dynamic){
				trace(e);
			}
		}
		Sys.println('\tcreate $folder');
	}


	static public function main () {
		var app = new MainNeko ();
	}
}