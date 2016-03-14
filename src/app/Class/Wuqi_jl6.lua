--
-- Author: Your Name
-- Date: 2016-03-11 10:48:38
--
Wuqi_jl6=class("Wuqi_jl6", function()
	return display.newSprite("yilidanTD.png")
end)

function Wuqi_jl6:ctor()
	self:init()
end

function Wuqi_jl6:init()
	self:setTag(100)
	self:setScale(0.4)
	self.currentLevel=1
	self.up_level=1
	self.make=80
	self.scope=1000
	self.firepower=200
	self.attack=true
	self.attackSpeed=0.5
	self.upMake=90
	self.removeMake=64
	self.totalMake=80
end

return Wuqi_jl6