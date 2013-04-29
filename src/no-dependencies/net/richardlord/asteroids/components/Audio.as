package net.richardlord.asteroids.components
{
	public class Audio
	{
		public var toPlay : Vector.<Class> = new Vector.<Class>();
		
		public function play( sound : Class ) : void
		{
			toPlay.push( sound );
		}
	}
}
