for _, player in pairs(game.players) do
	player.force.reset_recipes()
	player.force.reset_technologies()

	if player.force.technologies["automated-construction"].researched then
		player.force.recipes["filtered-deconstruction-planner"].enabled = true
	end
end