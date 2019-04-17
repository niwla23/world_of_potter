local outfit_formspec = "image[0,0;1.5,3;player_inv.png]"..
    "list[current_player;outfit;3,0.5;1,1;]"..
    "listring[current_player;main]"..
    "listring[current_player;outfit]"..
    "list[detached:trash;main;5,3.4;1,1;]"..
    "image[5.06,3.5;0.8,0.8;trash_icon.png]"..
    "image[0,4.7;1,1;gui_hb_bg.png]"..
    "image[1,4.7;1,1;gui_hb_bg.png]"..
    "image[2,4.7;1,1;gui_hb_bg.png]"..
    "image[3,4.7;1,1;gui_hb_bg.png]"..
    "image[4,4.7;1,1;gui_hb_bg.png]"..
    "image[5,4.7;1,1;gui_hb_bg.png]"..
    "image[6,4.7;1,1;gui_hb_bg.png]"..
    "image[7,4.7;1,1;gui_hb_bg.png]"

sfinv.register_page("sfinv:outfit", {
    title = "Outfit",
    get = function(self, player, context)
        return sfinv.make_formspec(player, context, outfit_formspec, true)
    end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "" and formname ~= "outfit" then
        return
    end

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

    sfinv.override_page("sfinv:outfit", {
        title = "Outfit",
        get = function(self, player, context)
            return sfinv.make_formspec(player, context,
                outfit_formspec:gsub('player_inv.png', "player_inv.png^"..img_inv_name)
            , true)
        end
    })
end)