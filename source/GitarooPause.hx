package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class GitarooPause extends MusicBeatSubstate
{

	var curSelected:Int = 0;
	var replayButton:FlxSprite;
	var cancelButton:FlxSprite;

	var replaySelect:Bool = false;

	var pauseMusic:FlxSound;

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music(''), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('pauseAlt/pauseBG'));
		bg.alpha = 0;
		bg.scrollFactor.set();
		bg.antialiasing = true;
		add(bg);

		var bf:FlxSprite = new FlxSprite(0, 30);
		bf.frames = Paths.getSparrowAtlas('pauseAlt/bfLol');
		bf.antialiasing = true;
		bf.animation.addByPrefix('lol', "funnyThing", 13);
		bf.animation.play('lol');
		bf.scrollFactor.set();
		bf.alpha = 0;
		add(bf);
		bf.screenCenter(X);

		replayButton = new FlxSprite(FlxG.width * 0.58, FlxG.height * 0.7);
		replayButton.frames = Paths.getSparrowAtlas('pauseAlt/pauseUI');
		replayButton.antialiasing = true;
		replayButton.animation.addByPrefix('selected', 'bluereplay', 0, false);
		replayButton.animation.appendByPrefix('selected', 'yellowreplay');
		replayButton.animation.play('selected');
		replayButton.scrollFactor.set();
		replayButton.alpha = 0;
		add(replayButton);

		cancelButton = new FlxSprite(FlxG.width * 0.28, replayButton.y);
		cancelButton.frames = Paths.getSparrowAtlas('pauseAlt/pauseUI');
		cancelButton.antialiasing = true;
		cancelButton.animation.addByPrefix('selected', 'bluecancel', 0, false);
		cancelButton.animation.appendByPrefix('selected', 'cancelyellow');
		cancelButton.animation.play('selected');
		cancelButton.scrollFactor.set();
		cancelButton.alpha = 0;
		add(cancelButton);

		FlxTween.tween(bg, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bf, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(replayButton, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(cancelButton, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		changeThing();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (controls.LEFT_P || controls.RIGHT_P)
			changeThing();

		if (FlxG.keys.justPressed.ESCAPE)
		{
			close();
		}

		if (controls.ACCEPT)
		{
			if (replaySelect)
			{
				close();
			}
			else
			{
				FlxG.switchState(new PlayState());
			}
		}

		super.update(elapsed);
	}

	function changeThing():Void
	{
		replaySelect = !replaySelect;

		if (replaySelect)
		{
			cancelButton.animation.curAnim.curFrame = 1;
			replayButton.animation.curAnim.curFrame = 0;
		}
		else
		{
			cancelButton.animation.curAnim.curFrame = 0;
			replayButton.animation.curAnim.curFrame = 1;
		}
	}
}
