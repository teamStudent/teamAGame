--
-- Author: student
-- Date: 2015-07-27 17:30:04
--


local SelectScene = class("SelectScene",function()
	return display.newScene("SelectScene")
end)

function SelectScene:ctor()
	self:init()
end

function SelectScene:init()
   

	local bg = display.newSprite("SelectScene/bg.png")
	bg:pos(display.cx, display.cy)
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScale(scaleX,scaleY)
	self:addChild(bg)

	local backBtn = cc.ui.UIPushButton.new({normal="back.png"},{scale9=true})
	backBtn:onButtonClicked(function(event)
		display.replaceScene(StartScene.new())
	end)
	backBtn:pos(display.left+50, display.top-50)
	self:addChild(backBtn, 1)

	local enter = cc.ui.UIPushButton.new({normal="SelectScene/fb1.png",pressed="SelectScene/fb1.png"},{scale9=true})
	    :onButtonClicked(function()
		print("caonima")
		local chooseLayer = ChooseLayer.new()
		chooseLayer:setPosition(cc.p(0,0))
		self:addChild(chooseLayer,13)
		print("cao")
		end)
	   :setPosition(cc.p(display.width-50,display.height-50))
	   :setScale(0.5)
	   :addTo(self)


	
	local item1 = cc.ui.UIPushButton.new({normal="SelectScene/wei.png",pressed="SelectScene/wei.png"},{scale9=true})
	           :onButtonClicked(function()
	           	ModifyData.setSceneNumber(1)
	             display.replaceScene(SelectChapter.new())
	            end)
	           :pos(display.cx+25, (display.top+display.cy)/2)
	           :addTo(self)
	           :setScale(2)


	local item2 = cc.ui.UIPushButton.new({normal="SelectScene/shu.png",pressed="SelectScene/shu.png"},{scale9=true})
	           :onButtonClicked(function()
	           	ModifyData.setSceneNumber(2)
	           display.replaceScene(SelectChapter.new())
	            end)
	            :pos(display.cx-120, display.cy-40)
	            :addTo(self)
	            :setScale(2)

	local item3 = cc.ui.UIPushButton.new({normal="SelectScene/wu.png",pressed="SelectScene/wu.png"},{scale9=true})
	           :onButtonClicked(function()
	           	 ModifyData.setSceneNumber(3)
	           display.replaceScene(SelectChapter.new())
	            end)
	            :pos(display.cx+120, display.cy-110)
	            :addTo(self)
	            :setScale(2)


end
return SelectScene