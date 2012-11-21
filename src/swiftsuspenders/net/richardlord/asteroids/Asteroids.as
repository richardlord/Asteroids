package net.richardlord.asteroids
{
	import ash.core.Engine;
	import ash.integration.swiftsuspenders.SwiftSuspendersEngine;
	import ash.tick.FrameTickProvider;

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

	import org.swiftsuspenders.Injector;

	import flash.display.DisplayObjectContainer;

	public class Asteroids
	{
		private var engine : Engine;
		private var tickProvider : FrameTickProvider;
		private var injector : Injector;
		private var container : DisplayObjectContainer;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			prepare( width, height );
		}
		
		private function prepare( width : Number, height : Number ) : void
		{
			injector = new Injector();
			engine = new SwiftSuspendersEngine( injector );
			
			injector.map( Engine ).toValue( engine );
			injector.map( DisplayObjectContainer ).toValue( container );
			injector.map( GameConfig ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( container.stage ) );
			
			var config : GameConfig = injector.getInstance( GameConfig );
			config.width = width;
			config.height = height;
			
			engine.addSystem( new GameManager(), SystemPriorities.preUpdate );
			engine.addSystem( new MotionControlSystem(), SystemPriorities.update );
			engine.addSystem( new GunControlSystem(), SystemPriorities.update );
			engine.addSystem( new BulletAgeSystem(), SystemPriorities.update );
			engine.addSystem( new DeathThroesSystem(), SystemPriorities.update );
			engine.addSystem( new MovementSystem(), SystemPriorities.move );
			engine.addSystem( new CollisionSystem(), SystemPriorities.resolveCollisions );
			engine.addSystem( new AnimationSystem(), SystemPriorities.animate );
			engine.addSystem( new RenderSystem(), SystemPriorities.render );
			
			var creator : EntityCreator = injector.getInstance( EntityCreator );
			creator.createGame();
		}
		
		public function start() : void
		{
			tickProvider = new FrameTickProvider( container );
			tickProvider.add( engine.update );
			tickProvider.start();
		}
	}
}
