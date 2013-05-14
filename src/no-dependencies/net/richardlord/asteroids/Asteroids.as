package net.richardlord.asteroids
{
	import ash.core.Engine;
	import ash.tick.FrameTickProvider;

	import net.richardlord.asteroids.systems.AnimationSystem;
	import net.richardlord.asteroids.systems.AudioSystem;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.DeathThroesSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.HudSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.asteroids.systems.WaitForStartSystem;
	import net.richardlord.input.KeyPoll;

	import flash.display.DisplayObjectContainer;

	public class Asteroids
	{
		private var container : DisplayObjectContainer;
		private var engine : Engine;
		private var tickProvider : FrameTickProvider;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var config : GameConfig;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			prepare( width, height );
		}
		
		private function prepare( width : Number, height : Number ) : void
		{
			engine = new Engine();
			creator = new EntityCreator( engine );
			keyPoll = new KeyPoll( container.stage );
			config = new GameConfig();
			config.width = width;
			config.height = height;

			engine.addSystem( new WaitForStartSystem( creator ), SystemPriorities.preUpdate );
			engine.addSystem( new GameManager( creator, config ), SystemPriorities.preUpdate );
			engine.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			engine.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			engine.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			engine.addSystem( new DeathThroesSystem( creator ), SystemPriorities.update );
			engine.addSystem( new MovementSystem( config ), SystemPriorities.move );
			engine.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			engine.addSystem( new AnimationSystem(), SystemPriorities.animate );
			engine.addSystem( new HudSystem(), SystemPriorities.animate );
			engine.addSystem( new RenderSystem( container ), SystemPriorities.render );
			engine.addSystem( new AudioSystem(), SystemPriorities.render );
			
			creator.createWaitForClick();
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
