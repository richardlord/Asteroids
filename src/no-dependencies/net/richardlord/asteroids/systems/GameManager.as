package net.richardlord.asteroids.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Point;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.GameConfig;
	import net.richardlord.asteroids.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroids.nodes.BulletCollisionNode;
	import net.richardlord.asteroids.nodes.GameNode;
	import net.richardlord.asteroids.nodes.SpaceshipNode;

	public class GameManager extends System
	{
		private var config : GameConfig;
		private var creator : EntityCreator;
		
		private var gameNodes : NodeList;
		private var spaceships : NodeList;
		private var asteroids : NodeList;
		private var bullets : NodeList;

		public function GameManager( creator : EntityCreator, config : GameConfig )
		{
			this.creator = creator;
			this.config = config;
		}

		override public function addToEngine( engine : Engine ) : void
		{
			gameNodes = engine.getNodeList( GameNode );
			spaceships = engine.getNodeList( SpaceshipNode );
			asteroids = engine.getNodeList( AsteroidCollisionNode );
			bullets = engine.getNodeList( BulletCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : GameNode = gameNodes.head;
			if( node && node.state.playing )
			{
				if( spaceships.empty )
				{
					if( node.state.lives > 0 )
					{
						var newSpaceshipPosition : Point = new Point( config.width * 0.5, config.height * 0.5 );
						var clearToAddSpaceship : Boolean = true;
						for( var asteroid : AsteroidCollisionNode = asteroids.head; asteroid; asteroid = asteroid.next )
						{
							if( Point.distance( asteroid.position.position, newSpaceshipPosition ) <= asteroid.collision.radius + 50 )
							{
								clearToAddSpaceship = false;
								break;
							}
						}
						if( clearToAddSpaceship )
						{
							creator.createSpaceship();
						}
					}
					else
					{
						node.state.playing = false;
						creator.createWaitForClick();
					}
				}
				
				if( asteroids.empty && bullets.empty && !spaceships.empty )
				{
					// next level
					var spaceship : SpaceshipNode = spaceships.head;
					node.state.level++;
					var asteroidCount : int = 2 + node.state.level;
					for( var i:int = 0; i < asteroidCount; ++i )
					{
						// check not on top of spaceship
						do
						{
							var position : Point = new Point( Math.random() * config.width, Math.random() * config.height );
						}
						while ( Point.distance( position, spaceship.position.position ) <= 80 );
						creator.createAsteroid( 30, position.x, position.y );
					}
				}
			}
		}

		override public function removeFromEngine( engine : Engine ) : void
		{
			gameNodes = null;
			spaceships = null;
			asteroids = null;
			bullets = null;
		}
	}
}
