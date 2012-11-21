package net.richardlord.asteroids
{
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;
	import ash.tick.ITickProvider;

	import net.richardlord.asteroids.events.StartGameEvent;
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

	public class StartAsteroids
	{
		[Inject]
		public var injector : Injector;
		[Inject]
		public var event : StartGameEvent;
		[Inject]
		public var engine : Engine;
		
		public function execute() : void
		{
			prepare();
			start();
		}
		
		private function prepare() : void
		{
			injector.map( GameConfig ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( event.container.stage ) );
			injector.map( ITickProvider ).toValue( new FrameTickProvider( event.container ) );
			
			var config : GameConfig = injector.getInstance( GameConfig );
			config.width = event.width;
			config.height = event.height;
			
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
			var tickProvider : ITickProvider = injector.getInstance( ITickProvider );
			tickProvider.add( engine.update );
			tickProvider.start();
		}
	}
}
