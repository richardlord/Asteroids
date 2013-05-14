package net.richardlord.asteroids.graphics
{
	import ash.signals.Signal0;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class WaitForStartView extends Sprite
	{
		private var gameOver : TextField;
		private var clickToStart : TextField;
		
		public var click : Signal0 = new Signal0();
		
		public function WaitForStartView()
		{
			gameOver = createGameOver();
			addChild( gameOver );
			clickToStart = createClickToStart();
			addChild( clickToStart );

			addEventListener( Event.ADDED_TO_STAGE, addClickListener );
			addEventListener( Event.REMOVED_FROM_STAGE, removeClickListener );
		}
		
		private function createGameOver() : TextField
		{
			var format : TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.color = 0xFFFFFF;
			format.font = "Helvetica";
			format.size = 32;
			
			var tf : TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.width = 200;
			tf.text = "ASTEROIDS";
			tf.selectable = false;
			tf.x = 200;
			tf.y = 175;
			return tf;
		}
		
		private function dispatchClick( event : MouseEvent ) : void
		{
			click.dispatch();
		}
		
		public function addClickListener( event : Event ) : void
		{
			stage.addEventListener( MouseEvent.CLICK, dispatchClick );
		}
		
		public function removeClickListener( event : Event ) : void
		{
			stage.removeEventListener( MouseEvent.CLICK, dispatchClick );
			gameOver.text = "GAME OVER";
		}
		
		private function createClickToStart() : TextField
		{
			var format : TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.color = 0xFFFFFF;
			format.font = "Helvetica";
			format.size = 18;
			
			var tf : TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.width = 200;
			tf.text = "CLICK TO START";
			tf.selectable = false;
			tf.x = 200;
			tf.y = 225;
			return tf;
		}
	}
}
