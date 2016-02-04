-- Intializes the top button GUI element for the given player
function gui_init(player)
	if not player.gui.top["fdp-gui-button"] and player.force.technologies["automated-construction"] then
		player.gui.top.add{
			type  = "button",
			name  = "fdp-gui-button",
			style = "fdp-gui-button-"..global["config"][player.name]["mode"]
		}
	end

	if global["config"][player.name]["eyedropping"] then
		player.gui.top["fdp-gui-button"].style = "fdp-gui-button-eyedropper"
	end
end

-- Hides the left frame GUI element
function gui_hide_frame(player)
	local gui_frame = player.gui.left["fdp-gui-frame"]
	if gui_frame then
		gui_frame.destroy()
	end
end

-- Shows the left frame GUI element
function gui_show_frame(player)
	local gui_frame = player.gui.left.add{
		type      = "frame",
		caption   = {"fdp-gui-frame-caption"},
		name      = "fdp-gui-frame",
		direction = "vertical"
	}

	local mode_grid = gui_frame.add{
		type      = "flow",
		name      = "fdp-gui-mode-grid",
		direction = "horizontal"
	}
	mode_grid.add{
		type    = "label",
		name    = "fdp-gui-mode-label",
		caption = {"fdp-gui-mode-label"}
	}
	mode_grid.add{type = "label", caption = "  "}
	mode_grid.add{
		type    = "checkbox",
		name    = "fdp-gui-normal-checkbox",
		caption = {"fdp-gui-normal-checkbox"},
		state   = global["config"][player.name]["mode"] == "normal"
	}
	mode_grid.add{type = "label", caption = "  "}
	mode_grid.add{
		type    = "checkbox",
		name    = "fdp-gui-target-checkbox",
		caption = {"fdp-gui-target-checkbox"},
		state   = global["config"][player.name]["mode"] == "target"
	}
	mode_grid.add{type = "label", caption = "  "}
	mode_grid.add{
		type    = "checkbox",
		name    = "fdp-gui-exclude-checkbox",
		caption = {"fdp-gui-exclude-checkbox"},
		state   = global["config"][player.name]["mode"] == "exclude"
	}

	if global["config"][player.name]["mode"] ~= "normal" then
		local filter_table = gui_frame.add{
			type    = "table",
			name    = "fdp-gui-filter-table",
			colspan = 8
		}
		local filter = global["config"][player.name]["filter"]
		for i = 1, (#filter + 1) do
			local style = filter[i] or "style"
			filter_table.add{
				type  = "checkbox",
				name  = "fdp-gui-filter-"..i,
				style = "fdp-icon-"..style,
				state = false
			}
		end

		local tmp_grid = gui_frame.add{
			type      = "flow",
			direction = "horizontal"
		}
		tmp_grid.add{
			type    = "label",
			caption = "                                                                                                                                                                                                                                                                    ",
			style   = "fdp-mini-label"
		}

		local button_grid = gui_frame.add{
			type      = "flow",
			name      = "fdp-gui-button-grid",
			direction = "horizontal"
		}
		local style = global["config"][player.name]["eyedropping"] and "deactivate" or "activate"
		button_grid.add{
			type  = "button",
			name  = "fdp-gui-eyedropper-button",
			style = "fdp-button-eyedropper-"..style
		}
		button_grid.add{
			type  = "button",
			name  = "fdp-gui-clear-button",
			style = "fdp-button-clear"
		}
	end
end

-- Refreshes the GUI elements (top button and left frame)
function gui_refresh(player)
	local gui_button = player.gui.top["fdp-gui-button"]
	if gui_button then
		if not global["config"][player.name]["eyedropping"] then
			gui_button.style = "fdp-gui-button-"..global["config"][player.name]["mode"]
		else
			gui_button.style = "fdp-gui-button-eyedropper"
		end
	else
		gui_init(player)
	end

	local gui_frame = player.gui.left["fdp-gui-frame"]
	if gui_frame then
		gui_hide_frame(player)
		gui_show_frame(player)
	end
end

-- Called when the player clicks the gui button
script.on_event(FDP_EVENTS.on_gui_clicked, function(event)
	if event.player.gui.left["fdp-gui-frame"] then
		gui_hide_frame(event.player)
	else
		gui_show_frame(event.player)
	end
end)

-- Called when the player changes the mode
script.on_event(FDP_EVENTS.on_mode_changed, function(event)
	global["config"][event.player.name]["mode"] = event.mode
	gui_refresh(event.player)
end)

-- Called when the player clicks a filter icon
script.on_event(FDP_EVENTS.on_button_filter_clicked, function(event)
	if not event.player.cursor_stack.valid_for_read then
		table.remove(global["config"][event.player.name]["filter"], event.index)
	else
		if is_in_filter(event.player, event.player.cursor_stack.name) then
			event.player.print({"fdp-error-duplicate"})
		else
			table.remove(global["config"][event.player.name]["filter"], event.index)
			table.insert(global["config"][event.player.name]["filter"], event.index, event.player.cursor_stack.name)
		end
	end
	gui_refresh(event.player)
end)

-- Called when the player clicks the eyedropper button
script.on_event(FDP_EVENTS.on_button_eyedropper_clicked, function(event)
	global["config"][event.player.name]["eyedropping"] = not global["config"][event.player.name]["eyedropping"]
	gui_refresh(event.player)
end)

-- Called when the player clicks the clear button
script.on_event(FDP_EVENTS.on_button_clear_clicked, function(event)
	global["config"][event.player.name]["filter"] = {}
	gui_refresh(event.player)
end)