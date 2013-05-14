package net.richardlord.asteroids.graphics
{
	import ash.signals.Signal0;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ClickToStartView extends TextField
	{
		public var click : Signal0 = new Signal0();
		
		public function ClickToStartView()
		{
			var format : TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.color = 0xFFFFFF;
			format.font = "Helvetica";
			format.size = 18;
			defaultTextFormat = format;
			
			width = 200;
			text = "CLICK TO START";
			selectable = false;
			
			addEventListener( Event.ADDED_TO_STAGE, addClickListener );
			addEventListener( Event.REMOVED_FROM_STAGE, removeClickListener );
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
		}
	}
}
