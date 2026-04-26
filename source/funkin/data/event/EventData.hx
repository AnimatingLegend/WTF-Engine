package funkin.data.event;

/**
 * A structure object used for song events.
 */
typedef EventData =
{
	var t:Float;
	var e:String;
	@:default(new Map<String, Dynamic>())
	var v:Dynamic;
}
