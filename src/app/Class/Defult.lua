--
-- Author: Your Name
-- Date: 2016-03-11 14:25:52
--
Defult=class("Defult", function()
	return display.newColorLayer(cc.c4f(0, 0, 0, 255))
end)

function Defult:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width, display.height))
	self:init()
end

function Defult:init()
	local bg=display.newSprite("NewTDLayer/kuang.png")
			:pos(display.cx, display.cy)
			:addTo(self)

	local font_label=cc.ui.UILabel.new({
			text="您不能购买此类物品，\n因为您没有足够材料去支付它",
			color=cc.c3b(79,79,79),
			size=25,
		})	
		:align(display.CENTER, display.cx, display.cy)
		:addTo(self)

	local back=cc.ui.UIPushButton.new({normal="NewTDLayer/okItem1.png",pressed="NewTDLayer/okItem2.png"}, {scale9=true})
				:onButtonClicked(function()
					self:removeSelf()
					end)
				:pos(display.cx, display.cy-bg:getContentSize().height/2+50)
				:setScale(0.5)
				:addTo(self)

end



return Defult
