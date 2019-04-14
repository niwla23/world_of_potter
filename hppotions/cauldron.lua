-- Cauldron
minetest.register_node('hppotions:cauldron', {
    description = "Cauldron",
    inventory_image = 'cauldron_inv.png',
    drawtype = "mesh",
    visual = 'mesh',
    paramtype2 = "facedir",
    tiles = {"potions_cauldron.png"},
    mesh = "cauldron.obj",
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", 'Cauldron')
        meta:set_string("formspec",
            "size[8,9]" ..
            "list[context;src;2,0.5;2,2;]"..
            "list[context;dst;5,0.5;2,2;]"..
            "list[current_player;main;0,4;8,4;]"..
            "button_exit[6,8;2,1;exit;Exit]")
		local inv = meta:get_inventory()
        inv:set_size("src", 4)
        inv:set_size('dst', 1)
    end,

    can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("src") and inv:is_empty('dst')
    end,
    
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "src" or listname == 'dst' then
			if stack:get_definition().groups["ingredient"] == 1
            and to_stack:is_empty() then
                return 1
			else
				return 0
            end             
        end   
    end,
    
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        hppotions.handle_craft(pos)
    end,

    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        if listname == 'src' then
            hppotions.handle_craft(pos)
        elseif listname == 'dst' then
            hppotions.remove_item_on_craft(pos)
        end
    end,

    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        hppotions.handle_craft(pos)
    end
})