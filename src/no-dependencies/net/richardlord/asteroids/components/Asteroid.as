package net.richardlord.asteroids.components
{
	import ash.fsm.EntityStateMachine;

	public class Asteroid
	{
		public var fsm : EntityStateMachine;

		public function Asteroid( fsm : EntityStateMachine )
		{
			this.fsm = fsm;
		}
	}
}
