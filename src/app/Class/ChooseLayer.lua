--
-- Author: Your Name
-- Date: 2016-03-03 14:56:34
--
local ChooseLayer = class("ChooseLayer", function()
	return display.newLayer()
end)
function ChooseLayer:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))
	self:init()
end
function ChooseLayer:init()

	 local anode =display.newNode()
    anode:pos(0,0)
    self:addChild(anode)

	 jlItem = cc.ui.UIPushButton.new({normal="ChooseLayer/jl.png",pressed="ChooseLayer/jl.png"},{scale9=true})
	:onButtonClicked(function()
		ShData.setShNum(1)
		display.replaceScene(ShScene.new())
	end)
	:pos(display.width-50,display.height-50)
	:setScale(0.4)
	:addTo(anode)
	


	 szItem = cc.ui.UIPushButton.new({normal="ChooseLayer/sz.png",pressed="ChooseLayer/sz.png"},{scale9=true})
	:onButtonClicked(function()
		ShData.setShNum(2)
		display.replaceScene(ShScene.new())
		end)
	:pos(display.width-50,display.height-50)
	:setScale(0.4)
	:addTo(anode)
	

	 bsItem=cc.ui.UIPushButton.new({normal="ChooseLayer/dead.png",pressed="ChooseLayer/dead.png"}, {scale9=true})
	:onButtonClicked(function()
		ShData.setShNum(3)
		display.replaceScene(ShScene.new())
		end)
	:pos(display.width-50,display.height-50)
	:setScale(0.4)
	:addTo(anode)
	


	 closeItem=cc.ui.UIPushButton.new({normal="ChooseLayer/close.png",pressed="ChooseLayer/close.png"}, {scale9=true})
	:onButtonClicked(function()
		 self:reverseItem()
		end)
	:pos(display.width-50, display.height-50)
	:setScale(0.3)
    :addTo(anode)

    print(ret)

	jlItem:runAction(
			cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-130))
	)
	szItem:runAction(
		cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-200))
		)
	bsItem:runAction(
		cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-280))
		)
	closeItem:runAction(
		cc.MoveTo:create(0.5, cc.p(display.width-30,display.height-80))
		)

end

function ChooseLayer:reverseItem()
	jlItem:runAction(
			cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-50))
	)
	szItem:runAction(
		cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-50))
		)
	bsItem:runAction(
		cc.MoveTo:create(0.5,cc.p(display.width-50,display.height-50))
		)
	closeItem:runAction(
		cc.Sequence:create(
		cc.MoveTo:create(0.5, cc.p(display.width-50,display.height-50)),
		cc.CallFunc:create(function()
			self:removeSelf()
			end)
		)
	)





	end




return ChooseLayer