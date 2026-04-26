package funkin.play.note;

import funkin.modding.IScriptedClass.INoteScriptedClass;
import funkin.modding.event.ScriptEvent;

/**
 * The note kind class (no-anim, ugh, etc.).
 */
class NoteKind implements INoteScriptedClass
{
	public var id:String;

	public function new(id:String)
	{
		this.id = id;
	}

	public function onCreate(event:ScriptEvent) {}

	public function onUpdate(event:UpdateScriptEvent) {}

	public function onDestroy(event:ScriptEvent) {}

	public function onScriptEvent(event:ScriptEvent) {}

	public function onNoteHit(event:NoteScriptEvent) {}

	public function onNoteMiss(event:NoteScriptEvent) {}

	public function onHoldNoteHold(event:HoldNoteScriptEvent) {}

	public function onHoldNoteDrop(event:HoldNoteScriptEvent) {}

	public function onGhostMiss(event:GhostMissScriptEvent) {}

	public function toString():String
	{
		return id;
	}
}
