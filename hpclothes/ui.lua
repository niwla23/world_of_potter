unified_inventory.register_button("outfit", {
	type = "image",
	image = "ui_outfit.png",
	tooltip = "Outfit"
})

unified_inventory.register_page("outfit", {
	get_formspec = function(player, perplayer_formspec)
        local formspec = "label[0,0;outfit]"..
            "image[0,0;1.5,3;player_inv.png]"..
            "list[current_player;outfit;3,0.5;1,1;]"..
            "listring[current_player;outfit]"..
            "list[detached:trash;main;5,3.4;1,1;]"..
            "image[5.06,3.5;0.8,0.8;trash_icon.png]"
		return {formspec=formspec}
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    minetest.log(formname)
    minetest.log(dump(fields))

    -- set outfit
    local player_inv = player:get_inventory()
    local node_name = player_inv:get_stack('outfit', 1):to_string()

    if player_inv:get_stack('outfit', 1):is_empty() then
        return hpclothes.update_player_visuals(player)
    end

    if node_name:sub(1, string.len('hpclothes:')) == 'hpclothes:' then
        local img_name = node_name:gsub('hpclothes:','clothes_')..'.png'
        hpclothes.update_player_visuals(player, img_name)
    end

    -- set formspec img
    local img_inv_name = node_name:gsub('hpclothes:','clothes_')..'_inv.png'

    unified_inventory.register_page("outfit", {
        get_formspec = function(player, perplayer_formspec)
            local formspec = "label[0,0;outfit]"..
                "image[0,0;1.5,3;player_inv.png^"..img_inv_name.."]"..
                "list[current_player;outfit;3,0.5;1,1;]"..
                "listring[current_player;outfit]"..
                "list[detached:trash;main;5,3.4;1,1;]"..
                "image[5.06,3.5;0.8,0.8;trash_icon.png]"
            return {formspec=formspec}
        end,
    })
    unified_inventory.set_inventory_formspec(player, "outfit")
end)