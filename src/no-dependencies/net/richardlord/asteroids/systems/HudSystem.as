package net.richardlord.asteroids.systems
{
	import ash.tools.ListIteratingSystem;

	import net.richardlord.asteroids.nodes.HudNode;

	public class HudSystem extends ListIteratingSystem
	{
		public function HudSystem()
		{
			super( HudNode, updateFunction );
		}
		
		private function updateFunction( node : HudNode, time : Number ) : void
		{
			node.hud.view.setLives( node.state.lives );
			node.hud.view.setScore( node.state.hits );
		}
	}
}
