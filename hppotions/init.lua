dofile(minetest.get_modpath("hppotions").."/functions.lua")
dofile(minetest.get_modpath("hppotions").."/cauldron.lua")

-- Glass bottle
minetest.register_node("hppotions:glass_bottle", {
    description = "Glass Bottle",
    drawtype = "plantlike",

    tiles = {"glass_bottle_1.png"},
    inventory_image = "glass_bottle_1_inv.png",
    wield_image = "glass_bottle_1_inv.png",

    selection_box = {
        type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
    },

    groups = {cracky = 3, oddly_breakable_by_hand = 3, glass = 1, ingredient = 1, vessel = 1}
})

minetest.register_craft({
	output = 'hppotions:glass_bottle 10',
	recipe = {
		{'', 'default:glass', ''},
		{'default:glass', 'default:glass', 'default:glass'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})

--Register Potions
hppotions.register_potion('lightblue', 'Doxycide', nil)
hppotions.register_potion('brown', 'Gillyweed Solution', {
    
})
hppotions.register_potion('yellow', 'Pepperup Potion',
    function()
        minetest.do_item_eat(6, nil, itemstack, user, pt)
    end
)

hppotions.register_potion('purple', 'Polyjuice Potion', nil)
hppotions.register_potion('darkgreen', 'Essence of Dittany',
    function(itemstack, user, pt)
        minetest.do_item_eat(10, nil, itemstack, user, pt)
    end
)
hppotions.register_potion('red', 'Erumpent Potion', nil)
hppotions.register_potion('orange', 'Herbicide', nil)
hppotions.register_potion('grey', 'Invisibility Potion', nil)
hppotions.register_potion('lightgreen', 'Dragon Poison', nil)


hppotions.register_recipe('hppotions:potion_brown', {'group:vessels',"hpplants:gillyweed"})
hppotions.register_recipe('hppotions:potion_purple', {'group:vessels',"hpplants:aconite"})

-- Cabinet
minetest.register_node("hppotions:cabinet", {
    description = "Potions Cabinet",
    inventory_image = "potions_cabinet_inv.png",
    drawtype = "mesh",
    visual = "mesh",
    paramtype2 = "facedir",
    tiles = {"potions_cabinet.png"},
    mesh = "dresser.obj",
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    selectionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", 'Potions Cabinet')
        meta:set_string("formspec",
            "size[8,7.5]" ..
            "list[context;potions;0,0.5;8,2;]"..
            "list[current_player;main;0,3;8,4;]"..
            "button_exit[6,7;2,1;exit;Exit]")
		local inv = meta:get_inventory()
        inv:set_size("potions", 16)
    end,

    can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("potions")
    end,
    
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "potions" then
			if stack:get_definition().groups["potions"] == 1
            and to_stack:is_empty() then
                return 1
			else
				return 0
            end             
        end   
	end,
})