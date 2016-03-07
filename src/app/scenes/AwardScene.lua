--
-- Author: Echo
-- Date: 2016-03-07 10:36:13

local AwardScene = class("AwardScene",function()
	return display.newScene("AwardScene")
end)

function AwardScene:ctor()
	self:init()
end

function AwardScene:init()
	local bg = display.newSprite("AwardScene/bg.png")
	bg:pos(display.cx, display.cy)
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScale(scaleX,scaleY)
	self:addChild(bg)
end

function AwardScene:onEnter()

end

function AwardScene:onExit()

end

return AwardScene