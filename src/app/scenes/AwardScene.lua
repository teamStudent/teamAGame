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

	local back = display.newSprite("AwardScene/back.png")
	back:pos(display.cx-270, display.cy-150)
	self:add(back)

	local front = display.newSprite("AwardScene/kapai1.png")
	front:pos(display.cx-270, display.cy-150)
	front:setVisible(false)
	self:add(front)

	
	local seq1=cc.Sequence:create(cc.DelayTime:create(0.5),
								  cc.Show:create(),
								  cc.DelayTime:create(1.0),
								  cc.Hide:create())
	local orbit1 = cc.OrbitCamera:create(2.0,1,0,0,360,0,0)
	
	local  seq2=cc.Sequence:create(cc.DelayTime:create(0.5),
								   cc.Hide:create(),
								   cc.DelayTime:create(1.0),
								   cc.Show:create())


	local orbit2 = orbit1:clone()

	back:runAction(cc.RepeatForever:create(cc.Spawn:create(orbit1,seq1)))

	front:runAction(cc.RepeatForever:create(cc.Spawn:create(orbit2,seq2)))



end

function AwardScene:onEnter()

end

function AwardScene:onExit()

end

return AwardScene