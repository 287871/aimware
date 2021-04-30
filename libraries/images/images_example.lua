--source code https://github.com/sapphyrus/gamesense-lua/blob/master/images_example.lua

local images_lib = require "libraries/images/images"
local images_icons = images_lib.load(require("libraries/images/imagepack_icons"))

callbacks.Register(
    "Draw",
    function()
        --Starting x and y
        local x, y = 590, 15

        local i = 1

        --loop through all elements in images_icons
        for name, image in pairs(images_icons) do
            --calculate x and y of the current image
            local x_i, y_i = x + math.floor(((i - 1) / 16)) * 125, y + (i % 16) * 30

            --draw the image, only specify the height (width is calculated automatically to match the aspect ratio)
            local width, height = image:draw(x_i, y_i, nil, 16)

            --draw image name
            draw.Text(x_i, y_i + 16, name)

            i = i + 1
        end
    end
)
