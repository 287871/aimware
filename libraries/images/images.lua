--source code https://github.com/sapphyrus/gamesense-lua/blob/master/images.lua

local M = {}

local math_floor, draw_CreateTexture, common_RasterizeSVG, draw_SetTexture, draw_FilledRect =
    math.floor,
    draw.CreateTexture,
    common.RasterizeSVG,
    draw.SetTexture,
    draw.FilledRect

local image_class = {}
local image_mt = {
    __index = image_class
}

local cache = {}

function image_class:measure(width, height)
    if not width and not height then
        return self.width, self.height
    elseif not width then
        height = height or self.height
        local width = math_floor(self.width * (height / self.height))
        return width, height
    elseif not height then
        width = width or self.width
        local height = math_floor(self.height * (width / self.width))
        return width, height
    else
        return width, height
    end
end

function image_class:draw(x, y, width, height, scale)
    local width, height = self:measure(width, height)
    local id = width .. "_" .. height
    local texture = self.textures[id]
    if not texture then
        if not ({next(self.textures)})[2] then
            texture = draw_CreateTexture(common_RasterizeSVG(self.svg, scale or 1))
            if not texture then
                self.textures[id] = -1
                error("failed to load svg " .. self.name .. " for " .. width .. "x" .. height)
            else
                self.textures[id] = texture
            end
        else
            --right now we just choose a random texture (determined by the pairs order aka unordered)
            --todo: select the texture with the highest or closest resolution?
            texture = ({next(self.textures)})[2]
        end
    end
    if not texture or texture == -1 then
        return
    end

    draw_SetTexture(texture)
    draw_FilledRect(x, y, x + width, y + height)

    return width, height
end

function M.load(data)
    local result = {}

    if not cache[data] then
        local header = data[-1]
        for image_name, image_data in pairs(data) do
            if image_name ~= -1 then
                local image = setmetatable({}, image_mt)

                --initialize image object
                image.name = image_name
                image.width = image_data[1]
                image.height = image_data[2]

                image.svg = image_data[3]
                if header ~= nil and image.svg:sub(0, 5) ~= "<?xml" then
                    image.svg = header .. image.svg
                end

                image.textures = {}

                result[image_name] = image
            end
        end

        cache[data] = result
    else
        result = cache[data]
    end

    return result
end

return M
