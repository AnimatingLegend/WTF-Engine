package funkin.data.story;

import funkin.ui.story.Level;
import funkin.util.FileUtil;
import funkin.util.SortUtil;
import json2object.JsonParser;

/**
 * A registry class for loading levels.
 */
class LevelRegistry extends BaseRegistry<Level>
{
    public static var instance:LevelRegistry;

    var parser(default, null) = new JsonParser<LevelData>();

    public function new()
    {
        super('levels', 'ui/story/levels');
    }

    override public function load()
    {
        super.load();

        for (id in FileUtil.listFolders(path))
        {
            final metaPath:String = Paths.json('$path/$id/meta');

            // Skip the level if it doesn't have a metadata file
            if (!Paths.exists(metaPath)) continue;

            var meta:LevelData = parser.fromJson(FileUtil.getText(metaPath));
            var level:Level = new Level(id, meta);

            register(id, level);
        }
    }

    public function listSorted():Array<String>
    {
        var list:Array<String> = list();
        list.sort(SortUtil.defaultsAlphabetically.bind(Constants.DEFAULT_LEVELS));
        return list;
    }
}