minetest.register_node('hpdeco:hogwarts_crest', {
    description = "Hogwarts Crest",
    tiles = {"deco_hogwartscrest.png"},
	paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}
    },
    groups = {cracky = 2, oddly_breakable_by_hand = 3}
})