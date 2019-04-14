dofile(minetest.get_modpath("hpclothes").."/clothes.lua")
dofile(minetest.get_modpath("hpclothes").."/dresser.lua")

minetest.register_on_joinplayer(function(player)
    player_api.set_textures(player, {'character.png'})

    local player_inv = player:get_inventory()

    if player_inv:get_list('outfit') == nil then
        player_inv:set_size("outfit", 1)
        minetest.log('action', 'Created inventory list \"outfit\"')
    else
        minetest.log('info', dump(player_inv:get_list('outfit')))
    end
end)

sfinv.register_page("sfinv:outfit", {
    title = "Outfit",
    get = function(self, player, context)
        local name = player:get_player_name()
        return sfinv.make_formspec(player, context,
            "image[0,0;2,3;player_inv.png]"..
            "list[current_player;outfit;3,0.5;1,1;]"..
            "listring[current_player;main]"..
            "listring[current_player;outfit]"..
            "image[0,4.7;1,1;gui_hb_bg.png]"..
            "image[1,4.7;1,1;gui_hb_bg.png]"..
            "image[2,4.7;1,1;gui_hb_bg.png]"..
            "image[3,4.7;1,1;gui_hb_bg.png]"..
            "image[4,4.7;1,1;gui_hb_bg.png]"..
            "image[5,4.7;1,1;gui_hb_bg.png]"..
            "image[6,4.7;1,1;gui_hb_bg.png]"..
            "image[7,4.7;1,1;gui_hb_bg.png]"
        , true)
    end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "" then
        return
    end

    local player_inv = player:get_inventory()
    local node_name = player_inv:get_stack('outfit', 1):to_string()

    if node_name:sub(1, string.len('hpclothes:')) == 'hpclothes:' then
        local img_name = node_name:gsub('hpclothes:','clothes_')..'.png'
        player_api.set_textures(player, {'character.png^'..img_name})
    end
end)