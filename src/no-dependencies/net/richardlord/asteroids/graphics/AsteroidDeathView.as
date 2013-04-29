package net.richardlord.asteroids.graphics
{
	import flash.display.Sprite;
	
	public class AsteroidDeathView extends Sprite implements Animatable
	{
		private static const numDots : int = 8;
		
		private var dots : Vector.<Dot>;
		
		public function AsteroidDeathView( radius : Number )
		{
			dots = new Vector.<Dot>();
			for( var i : int = 0; i < numDots; ++i )
			{
				var dot : Dot = new Dot( radius );
				addChild( dot.image );
				dots.push( dot );
			}
		}
		
		public function animate( time : Number ) : void
		{
			for each( var dot : Dot in dots )
			{
				dot.image.x += dot.velocity.x * time;
				dot.image.y += dot.velocity.y * time;
			}
		}
	}
}

import flash.display.Shape;
import flash.geom.Point;

class Dot
{
	public var velocity : Point;
	public var image : Shape;
	
	public function Dot( maxDistance : Number )
	{
		image = new Shape();
		image.graphics.beginFill( 0xFFFFFF );
		image.graphics.drawCircle( 0, 0, 1 );
		image.graphics.endFill();
		var angle : Number = Math.random() * 2 * Math.PI;
		var distance : Number = Math.random() * maxDistance;
		image.x = Math.cos( angle ) * distance;
		image.y = Math.sin( angle ) * distance;
		var speed : Number = Math.random() * 10 + 10;
		velocity = new Point( Math.cos( angle ) * speed, Math.sin( angle ) * speed );
	}
}