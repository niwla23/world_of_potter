local function register_clothes(name, desc, recipe)
    local node_name = "hpclothes:"..name
    minetest.register_craftitem(node_name, {
        description = desc,
        inventory_image = "clothes_"..name.."_inv.png",
        groups = {clothes=1},
    })
    
    minetest.register_craft({
        output = node_name,
        recipe = recipe
    })
end

register_clothes("school_hogwarts", "Standard School Clothes", {
    {"wool:brown"},
    {"wool:black"},
    {"wool:black"}
})

register_clothes("school_gryffindor", "Gryffindor School Clothes", {
    {"wool:red"},
    {"wool:black"},
    {"wool:black"}
})

register_clothes("school_ravenclaw", "Ravenclaw School Clothes", {
    {"wool:blue"},
    {"wool:black"},
    {"wool:black"}
})

register_clothes("school_hufflepuff", "Hufflepuff School Clothes", {
    {"wool:yellow"},
    {"wool:black"},
    {"wool:black"}
})

register_clothes("school_slytherin", "Slytherin School Clothes", {
    {"wool:dark_green"},
    {"wool:black"},
    {"wool:black"}
})

register_clothes("red_robe", "Red Wizard Robes", {
    {"wool:yellow"},
    {"wool:red"},
    {"wool:red"},
})

register_clothes("robe_beard", "Wizard Robes with Beard", {
    {"wool:white"},
    {"wool:red"},
    {"wool:red"},
})