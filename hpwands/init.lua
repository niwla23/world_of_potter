-- Wands

-- Default
minetest.register_tool("hpwands:wand_default", {
	description = "Normal Wand",
    inventory_image = "wand_default.png"
})

minetest.register_craft({
	output = 'hpwands:wand_default',
	recipe = {
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_tool("hpwands:wand_tan", {
	description = "Tan wand with hilt",
    inventory_image = "wand_tan.png"
})

minetest.register_tool("hpwands:wand_brown", {
	description = "Brown wand with hilt",
    inventory_image = "wand_brown.png"
})

minetest.register_tool("hpwands:wand_elder", {
	description = "The Elder Wand",
    inventory_image = "wand_elder.png"
})