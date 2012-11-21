package net.richardlord.asteroids
{
	import ash.core.Engine;
	import ash.integration.starling.StarlingFrameTickProvider;
	import flash.geom.Rectangle;
	import net.richardlord.asteroids.systems.AnimationSystem;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.DeathThroesSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Asteroids extends Sprite
	{
		private var engine : Engine;
		private var tickProvider : StarlingFrameTickProvider;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var config : GameConfig;
		
		public function Asteroids()
		{
			addEventListener( Event.ADDED_TO_STAGE, startGame );
		}
		
		private function startGame( event : Event ) : void
		{
			prepare();
			start();
		}
		
		private function prepare() : void
		{
			engine = new Engine();
			creator = new EntityCreator( engine );
			keyPoll = new KeyPoll( Starling.current.nativeStage );
			var viewPort : Rectangle = Starling.current.viewPort;
			config = new GameConfig();
			config.width = viewPort.width;
			config.height = viewPort.height;

			engine.addSystem( new GameManager( creator, config ), SystemPriorities.preUpdate );
			engine.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			engine.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			engine.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			engine.addSystem( new DeathThroesSystem( creator ), SystemPriorities.update );
			engine.addSystem( new MovementSystem( config ), SystemPriorities.move );
			engine.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			engine.addSystem( new AnimationSystem(), SystemPriorities.animate );
			engine.addSystem( new RenderSystem( this ), SystemPriorities.render );
			
			creator.createGame();
		}
		
		private function start() : void
		{
			tickProvider = new StarlingFrameTickProvider( Starling.current.juggler );
			tickProvider.add( engine.update );
			tickProvider.start();
		}
	}
}
