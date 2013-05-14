package net.richardlord.asteroids.components
{
	public class GameState
	{
		public var lives : int = 0;
		public var level : int = 0;
		public var hits : int = 0;
		public var playing : Boolean = false;
		
		public function setForStart() : void
		{
			lives = 3;
			level = 0;
			hits = 0;
			playing = true;
		}
	}
}
