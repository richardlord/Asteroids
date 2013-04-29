package net.richardlord.asteroids.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroids.nodes.BulletCollisionNode;
	import net.richardlord.asteroids.nodes.GameNode;
	import net.richardlord.asteroids.nodes.SpaceshipCollisionNode;

	import flash.geom.Point;

	public class CollisionSystem extends System
	{
		private var creator : EntityCreator;
		
		private var games : NodeList;
		private var spaceships : NodeList;
		private var asteroids : NodeList;
		private var bullets : NodeList;

		public function CollisionSystem( creator : EntityCreator )
		{
			this.creator = creator;
		}

		override public function addToEngine( engine : Engine ) : void
		{
			games = engine.getNodeList( GameNode );
			spaceships = engine.getNodeList( SpaceshipCollisionNode );
			asteroids = engine.getNodeList( AsteroidCollisionNode );
			bullets = engine.getNodeList( BulletCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{
			var bullet : BulletCollisionNode;
			var asteroid : AsteroidCollisionNode;
			var spaceship : SpaceshipCollisionNode;

			for ( bullet = bullets.head; bullet; bullet = bullet.next )
			{
				for ( asteroid = asteroids.head; asteroid; asteroid = asteroid.next )
				{
					if ( Point.distance( asteroid.position.position, bullet.position.position ) <= asteroid.collision.radius )
					{
						creator.destroyEntity( bullet.entity );
						if ( asteroid.collision.radius > 10 )
						{
							creator.createAsteroid( asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5 );
							creator.createAsteroid( asteroid.collision.radius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5 );
						}
						asteroid.asteroid.fsm.changeState( "destroyed" );
						asteroid.audio.play( ExplodeAsteroid );
						if( games.head )
						{
							games.head.state.hits++;
						}
						break;
					}
				}
			}

			for ( spaceship = spaceships.head; spaceship; spaceship = spaceship.next )
			{
				for ( asteroid = asteroids.head; asteroid; asteroid = asteroid.next )
				{
					if ( Point.distance( asteroid.position.position, spaceship.position.position ) <= asteroid.collision.radius + spaceship.collision.radius )
					{
						spaceship.spaceship.fsm.changeState( "destroyed" );
						spaceship.audio.play( ExplodeShip );
						if( games.head )
						{
							games.head.state.lives--;
						}
						break;
					}
				}
			}
		}

		override public function removeFromEngine( engine : Engine ) : void
		{
			spaceships = null;
			asteroids = null;
			bullets = null;
		}
	}
}
