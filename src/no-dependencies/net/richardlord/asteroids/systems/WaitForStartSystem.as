package net.richardlord.asteroids.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;

	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroids.nodes.GameNode;
	import net.richardlord.asteroids.nodes.WaitForStartNode;

	public class WaitForStartSystem extends System
	{
		private var engine : Engine;
		private var creator : EntityCreator;
		
		private var gameNodes : NodeList;
		private var waitNodes : NodeList;
		private var asteroids : NodeList;
		
		public function WaitForStartSystem( creator : EntityCreator )
		{
			this.creator = creator;
		}

		override public function addToEngine( engine : Engine ) : void
		{
			this.engine = engine;
			waitNodes = engine.getNodeList( WaitForStartNode );
			gameNodes = engine.getNodeList( GameNode );
			asteroids = engine.getNodeList( AsteroidCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : WaitForStartNode = waitNodes.head;
			var game : GameNode = gameNodes.head;
			if( node && node.wait.startGame && game )
			{
				for( var asteroid : AsteroidCollisionNode = asteroids.head; asteroid; asteroid = asteroid.next )
				{
					creator.destroyEntity( asteroid.entity );
				}

				game.state.setForStart();
				node.wait.startGame = false;
				engine.removeEntity( node.entity );
			}
		}

		override public function removeFromEngine( engine : Engine ) : void
		{
			gameNodes = null;
			waitNodes = null;
		}
	}
}
