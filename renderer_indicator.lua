local obj = {}

local renderer = {}

renderer.rectangle = function(x, y, w, h, clr, fill, radius)
	local alpha = 255
	if clr[4] then
		alpha = clr[4]
	end
	draw.Color(clr[1], clr[2], clr[3], alpha)
	if fill then
		draw.FilledRect(x, y, x + w, y + h)
	else
		draw.OutlinedRect(x, y, x + w, y + h)
	end
	if fill == "s" then
		draw.ShadowRect(x, y, x + w, y + h, radius)
	end
end

renderer.gradient = function(x, y, w, h, clr, clr1, vertical)
	local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
	local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]

	if a and a1 == nil then
		a, a1 = 255, 255
	end

	if vertical then
		if clr[4] ~= 0 then
			if a1 and a ~= 255 then
				for i = 0, h do
					renderer.rectangle(x, y + h - i, w, 1, {r1, g1, b1, i / h * a1}, true)
				end
			else
				renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
			end
		end
		if a2 ~= 0 then
			for i = 0, h do
				renderer.rectangle(x, y + i, w, 1, {r, g, b, i / h * a}, true)
			end
		end
	else
		if clr[4] ~= 0 then
			if a1 and a ~= 255 then
				for i = 0, w do
					renderer.rectangle(x + w - i, y, 1, h, {r1, g1, b1, i / w * a1}, true)
				end
			else
				renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
			end
		end
		if a2 ~= 0 then
			for i = 0, w do
				renderer.rectangle(x + i, y, 1, h, {r, g, b, i / w * a}, true)
			end
		end
	end
end

local Indicator = {
	text = "",
	font = "",
	color = {255, 255, 255, 255},
	visible = true
}

local i = 0
function Indicator:New(text, font, color, visible)
	i = i + 1
	obj[i] = {}
	setmetatable(obj[i], self)
	self.__index = self
	self.text = text or ""
	self.font = font or ""
	self.color = color or {255, 255, 255, 255}
	self.visible = visible

	return obj[i]
end

function Indicator:Add(text, font, color, visible)
	local a = Indicator:New(text, color, visible)
	a:SetText(text)
	a:SetFont(font)
	a:SetColor(color)
	a:SetVisible(visible)
	return a
end

function Indicator:SetText(text)
	self.text = text
end

function Indicator:SetFont(font)
	self.font = font
end

function Indicator:SetColor(color)
	self.color = color
end

function Indicator:SetVisible(vis)
	self.visible = vis
end

local segoe_font = draw.CreateFont("Segoe UI", 30, 600)

callbacks.Register(
	"Draw",
	"Draw Indicators",
	function()
		local lp = entities.GetLocalPlayer()
		if not lp then
			return
		end
		if not lp:IsAlive() then
			return
		end

		local screen_size_w, screen_size_h = draw.GetScreenSize()

		local temp = {}

		local y = screen_size_h / 1.4105 - #temp * 37

		for i = 1, #obj do
			if obj[i].visible then
				table.insert(temp, obj[i])
			end
		end

		for i = 1, #temp do
			local __ind = temp[i]
			if __ind.visible then
				if __ind.font == "" then
					draw.SetFont(segoe_font)
				else
					draw.SetFont(__ind.font)
				end
				local text_w, text_h = draw.GetTextSize(__ind.text)
				renderer.gradient(16 + (text_w / 2) + 1, y - (text_h * 0.3), text_w / 2, text_h + text_h, {0, 0, 0, 50}, {0, 0, 0, 5}, nil)
				renderer.gradient(16, y - (text_h * 0.3), text_w / 2 + 0.5, text_h + text_h, {0, 0, 0, 5}, {0, 0, 0, 50}, nil)
				draw.Color(28, 28, 28, 50)
				draw.Color(unpack(__ind.color))
				draw.Text(15, y, __ind.text)
				y = y - 35
			end
		end
	end
)

--[[
renderer_indicator
syntax: renderer_indicator(r, g, b, a, text, font, Visible)

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

text - The text that will be drawn

font - Font used by indicator

Visible - Is the indicator visible

Return array [
	text
	font
	color{}
	visible
]

]]
function renderer_indicator(r, g, b, a, text, font, Visible)
	return Indicator:Add(text, font, {r, g, b, a}, Visible)
end

--Example
local font = draw.CreateFont("Verdana", 20)

local aimware = renderer_indicator(255, 0, 0, 255, "aim ware.net", font, true)
print(aimware["text"])
local min_dmg = renderer_indicator(143, 29, 214, 255, "dmg", "", true)

callbacks.Register(
	"Draw",
	function()
		local dmg = gui.GetValue("rbot.accuracy.weapon.shared.mindmg")
		min_dmg:SetText("min dmg: " .. ((dmg > 100) and ("HP+" .. (dmg - 100)) or dmg))
	end
)
