package net.richardlord.asteroids.nodes
{
	import ash.core.Node;

	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.components.Hud;

	public class HudNode extends Node
	{
		public var state : GameState;
		public var hud : Hud;
	}
}
