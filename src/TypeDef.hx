package;

/**
 * Generated with HxJsonDef (version 0.0.8) on Fri Sep 08 2017 09:29:13 GMT+0200 (CEST)
 * from : http://matthijskamstra.github.io/hxjsondef/
 *
 * AST = Abstract Syntax Tree
 *
 * Note:
 * If you provide a .json there should be no null values
 * comments in this document show you the values that need to be changed!
 *
 * Some (backend)-developers choose to hide empty/null values, you can add them:
 * 		@:optional var _id : Int;
 *
 * Name(s) that you possibly need to change:
 * 		FoobarObj
 */

typedef UpcObj =
{
	var created : String;
	var firstname : String;
	var lastname : String;
	var artistname : String;
	var useartist : Bool;
	var email : String;
	var website : String;

	var twitter : String;
	var linkedin : String;
	var flickrr : String;
	var instagram : String;

	var facebook : String;
	var patreon : String;
	var photo : String;

	var bio : String;
	var description : String;
	var remark : String;
	var upcselect : String;
	var country : String;
	var language0 : String;
	var language1 : String;
	var language2 : String;
};