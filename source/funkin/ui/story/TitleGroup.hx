package funkin.ui.story;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSignal.FlxTypedSignal;
import funkin.audio.FunkinSound;
import funkin.data.story.LevelRegistry;
import funkin.input.Controls;
import funkin.ui.story.Level;
import funkin.util.MathUtil;

/**
 * A group of `TitleText`s that display different level titles.
 */
class TitleGroup extends FlxTypedGroup<TitleText>
{
    final SPACING:Float = 30;

    public var selected:Int;
    public var y:Float;
    public var levels:Array<String>;
    
    public var busy:Bool = false;
    public var lerp:Bool = true;

    public var title(get, never):TitleText;
    public var level(get, never):Level;
    public var size(get, never):Int;

    public var onChanged(default, null) = new FlxTypedSignal<Int->Void>();

    public function new(selected:Int = 0, y:Float)
    {
        super();

        this.selected = selected;
        this.y = y;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        var up:Bool = Controls.instance.UI_UP_P;
        var down:Bool = Controls.instance.UI_DOWN_P;

        if ((up || down) && !busy)
            change(up ? -1 : 1);

        forEachAlive(text -> {
            if (lerp)
                text.y = MathUtil.lerp(text.y, getIntendedY(text), 0.2);
            text.alpha = text.ID == selected ? 1 : 0.6;
        });
    }

    public function change(change:Int)
    {
        final lastSelected:Int = selected;

        selected += change;

        if (selected < 0)
            selected = size - 1;
        else if (selected >= size)
            selected = 0;

        if (lastSelected != selected && change != 0)
        {
            FunkinSound.playOnce('ui/sounds/scroll');

            onChanged.dispatch(selected);
        }
    }

    public function load(levels:Array<String>)
    {
        this.levels = levels;

        killMembers();

        for (i => level in levels)
        {
            var level:Level = LevelRegistry.instance.fetch(level);
            var text:TitleText = recycle(TitleText);

            text.ID = i;

            text.text = level.title;
            text.size = 64;
            text.screenCenter(X);
            text.y = getIntendedY(text);
        }
    }

    function getIntendedY(text:TitleText):Float
    {
        return y + (text.ID - selected) * (text.height + SPACING);
    }

    inline function get_title():TitleText
        return members[selected];

    inline function get_level():Level
        return LevelRegistry.instance.fetch(levels[selected]);

    inline function get_size():Int
        return countLiving();
}