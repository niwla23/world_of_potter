hppotions = {}
hppotions.recipes = {}

function hppotions.register_potion(color, name, use)
    --[[ 
        __Variables__
        color: color of potions
        name: name of potion
        node_name: name of potion node
     ]]

    local node_name = "hppotions:potion_"..color

    minetest.register_node(node_name, {
        description = name,
        drawtype = "plantlike",
    
        tiles = {"glass_bottle_1.png^potion_"..color..".png"},
        inventory_image = "glass_bottle_1_inv.png^potion_"..color.."_inv.png",
        wield_image = "glass_bottle_1_inv.png^potion_"..color.."_inv.png",
    
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
        },
    
        groups = {cracky = 3, oddly_breakable_by_hand = 1, potion = 1},
        on_use = use
    })
end

function hppotions.register_recipe(output, input)
    table.insert(hppotions.recipes, -1, {
       ["input"] = input,
       ["output"] = output
    })
    return hppotions.recipes[-1]
end

-- equate two tables
local function same(t1, t2)
    for k, v in pairs(t1) do
        if t2[k] ~= v then
            return false
        end
    end

    for k, v in pairs(t2) do
        if t1[k] ~= v then
            return false
        end
    end
    
    return true
end

function hppotions.get_recipe(input)
    -- find recipes
    -- if input is part of group, substitute group
    -- if recipes exists, return output
    for i, v in pairs(hppotions.recipes) do
        local recipe = v.input

        for j, w in pairs(input) do
            -- if ingredient is a vessel...
            local is_vessel = minetest.get_item_group(w, 'vessel')
            if is_vessel == 1 then
                -- ...substitute group:vessel
                input[j] = 'group:vessels'
            end
        end

        if same(input, recipe) then
            return v.output or nil
        end

    end
end

function hppotions.handle_craft(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local src = inv:get_list('src')
    local src_list = { src[1]:get_name(), src[2]:get_name(), src[3]:get_name(), src[4]:get_name() }
    local input = {}

    -- strip blank values
    for i, v in ipairs(src_list) do
        if v ~= '' then
            table.insert(input, v)
        end
    end

    local output = hppotions.get_recipe(input)
    if output == nil then return end
    -- add item to dst
    inv:add_item('dst', ItemStack(output))
end

function hppotions.remove_item_on_craft(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local src = inv:get_list('src')
    local src_list = { src[1]:get_name(), src[2]:get_name(), src[3]:get_name(), src[4]:get_name() }

    -- strip blank values
    for i, v in ipairs(src_list) do
        if v ~= '' then
            inv:remove_item('src', ItemStack(v))
        end
    end
end