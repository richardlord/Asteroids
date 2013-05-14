package net.richardlord.asteroids.components
{
	import net.richardlord.asteroids.graphics.WaitForStartView;

	public class WaitForStart
	{
		public var waitForStart : WaitForStartView;
		public var startGame : Boolean;
	
		public function setStartGame() : void
		{
			startGame = true;
		}
		
		public function WaitForStart( waitForStart : WaitForStartView ) : void
		{
			this.waitForStart = waitForStart;
			waitForStart.click.add( setStartGame );
		}
	}
}
