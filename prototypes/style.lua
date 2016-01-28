data:extend({
	{
		type = "font",
		name = "filtered-deconstruction-planner-small-font",
		from = "default",
		size = 14
	}
})

data.raw["gui-style"].default["filtered-deconstruction-planner-small-button"] = {
	type = "button_style",
	parent = "default",
	font = "filtered-deconstruction-planner-small-font"
}

data.raw["gui-style"].default["filtered-deconstruction-planner-button"] = {
	type = "button_style",
	parent = "button_style",
	width = 33,
	height = 33,
	top_padding = 6,
	right_padding = 6,
	bottom_padding = 6,
	left_padding = 0,
	font = "filtered-deconstruction-planner-small-font",
	default_graphical_set =
    {
        type = "monolith",
        monolith_image =
        {
            filename = "__filtered-deconstruction-planner__/graphics/gui.png",
            priority = "extra-high-no-scale",
            width = 32,
            height = 32,
            x = 64
        }
    },
    hovered_graphical_set =
    {
        type = "monolith",
        monolith_image =
        {
            filename = "__filtered-deconstruction-planner__/graphics/gui.png",
            priority = "extra-high-no-scale",
            width = 32,
            height = 32,
            x = 96
        }
    },
    clicked_graphical_set =
    {
        type = "monolith",
        monolith_image =
        {
            filename = "__filtered-deconstruction-planner__/graphics/gui.png",
            width = 32,
            height = 32,
            x = 96
        }
    }
}