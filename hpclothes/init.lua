-- if not minetest.get_modpath('3d_armor') then
    dofile(minetest.get_modpath("hpclothes").."/clothes.lua")
    dofile(minetest.get_modpath("hpclothes").."/dresser.lua")

    --[[ 
        outfit inventory
        - standardize clothing inventory imgs with player_inv.png
        - prevent placement of non-clothes

        - compatibility with other clothing mods
            - 3d-armor
    ]]

    if minetest.get_modpath('unified_inventory') then 
        dofile(minetest.get_modpath('hpclothes').."/ui.lua")
    else
        dofile(minetest.get_modpath("hpclothes").."/sfinv.lua")
    end

    minetest.register_on_joinplayer(function(player)
        player_api.set_textures(player, {'character.png'})

        -- Outfit Inventory (formspec)
        local player_inv = player:get_inventory()

        if player_inv:get_list('outfit') == nil then
            player_inv:set_size("outfit", 1)
            minetest.log('action', 'Created inventory list \"outfit\"')
        else
            local node = player_inv:get_stack('outfit', 1)

            if node:is_empty() == false then
                local img_name = node:to_string():gsub('hpclothes:','clothes_')..'.png'
                player_api.set_textures(player, {'character.png^'..img_name})
            end
        end

        -- trash button (formspec)
        local trash = minetest.create_detached_inventory('trash', {
            on_put = function(inv, listname, index, stack, player)
                inv:set_stack(listname, index, "")
            end
        })

        trash:set_size("main", 1)
    end)
-- end