-- Plants Functions
hpplants = {}

function hpplants.register_plant(name, inv)
    local inv_name

    if inv == nil or inv == true then
        inv_name = name..'_inv'
    elseif inv == false then
        inv_name = name
    end

    local dname = name:gsub("^%l", string.upper)

    minetest.register_node("hpplants:"..name.."_plant", {
        description = dname.." Plant",
        drawtype = "plantlike",
        paramtype = "light",
        waving = 1,
        tiles = {name..".png"},
        inventory_image = name..".png",
        wield_image = name..".png",
        is_ground_content = false,
        drop = "plants:"..name,
        groups = {oddly_breakable_by_hand = 3, flammable = 2, plant = 1}
    })
    
    minetest.register_craftitem('hpplants:'..name, {
        description = dname,
        inventory_image = inv_name..".png",
        groups = {flammable = 2, ingredient = 1}
    })
end