hpclothes = {}

hpclothes.update_player_visuals = function(player, texture)
    if not player then return end
    
    local name = player:get_player_name()
    hpclothes.current_tex[name] = texture

    if minetest.get_modpath('3d_armor') then
        local skin = armor:get_player_skin(name)
        if texture then skin = skin.."^"..texture end

        armor.textures[name].skin = skin
        armor:update_player_visuals(player)
    else
        local skin = 'clothes_character.png'
        if texture then skin = skin.."^"..texture end

        player_api.set_textures(player, skin)
    end
end

hpclothes.get_player_texture = function(player)
    if not player then return end
    local name = player:get_player_name()
    return hpclothes.current_tex[name]
end