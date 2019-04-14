-- Dresser
minetest.register_node("hpclothes:dresser", {
    description = "Dresser",
    inventory_image = "clothes_dresser_inv.png",
    drawtype = "mesh",
    visual = "mesh",
    paramtype2 = "facedir",
    tiles = {"clothes_dresser.png"},
    mesh = "dresser.obj",
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    selectionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},

    on_construct = function(pos)
		local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,5.5]"..
            "list[context;clothes;0,0;8,1;]"..
            "list[current_player;main;0,1.5;8,4;]"..
            "button_exit[6,5.5;2,1;exit;Exit]")
		local inv = meta:get_inventory()
        inv:set_size("clothes", 8)
    end,

    can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("clothes")
    end,
    
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "clothes" then
			if stack:get_definition().groups["clothes"] == 1
			and to_stack:is_empty() then
                return 1
			else
				return 0
            end             
        end   
	end,
})

minetest.register_craft({
    output = "hpclothes:dresser",
    recipe = {
        {'group:wool', 'group:wool', ''},
        {'group:wood', 'group:wood', ''},
        {'group:wood', 'group:wood', ''}
    }
})