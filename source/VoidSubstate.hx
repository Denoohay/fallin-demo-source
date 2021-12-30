package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class VoidSubstate extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
	private var colorRotation:Int = 1;

	var titleText:FlxSprite;

	override function create()

	{
		FlxG.sound.playMusic(Paths.music('void'));

		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('entry'));
		bg.antialiasing = true;
		bg.screenCenter();
		add(bg);

		titleText = new FlxSprite(150, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('entryenter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			if (FlxG.save.data.flashing)
				titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('bing'), 0.7);

			PlayState.SONG = Song.loadFromJson('rap battle', 'rap battle');
			PlayState.isStoryMode = true;
			PlayState.storyDifficulty = 1;
			LoadingState.loadAndSwitchState(new PlayState());
			function endSong():Void
			FlxG.sound.music.onComplete = endSong;
			FlxG.switchState(new PlayState());
		}
		super.update(elapsed);
	}
}
