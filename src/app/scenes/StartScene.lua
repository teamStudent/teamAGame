--
-- Author: student
-- Date: 2015-07-27 16:49:53
--
local StartScene=class("StartScene", function ()
	return display.newScene("StartScene")
end)

function StartScene:ctor(  )
	self:init()
end

function StartScene:init()
	local bg = display.newSprite("StartScene/startbg.png")
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScale(scaleX,scaleY)
	bg:setPosition(cc.p(display.cx,display.cy))
	self:addChild(bg)


    
	self._startButton = cc.ui.UIPushButton.new({normal="StartScene/Up.png"},{scale9=true})
	                   :onButtonClicked(function(event)
                   	   display.replaceScene(SelectScene.new())
                       end)
                       :pos(display.cx, display.cy-30)
                       :addTo(self)
                       :setScale(1.0)
                       
      local tittl=display.newSprite("StartScene/selectplane_plane3_title.png")
        tittl:setScale(2.0)
        :pos(display.cx,display.cy/2*3)
        :addTo(self)

        local move1=cc.MoveBy:create(0.5,cc.p(0,10))
        local move2=cc.MoveBy:create(0.5,cc.p(0,-10))
        local sequence1=cc.Sequence:create(move1,move2)
        transition.execute(tittl,cc.RepeatForever:create(sequence1))

	
	local music = cc.ui.UICheckBoxButton.new({off ="sound_off.png" ,on = "sound_on.png"})
	music:setPosition(cc.p(display.width-50, display.top-50))
	music:setScale(0.5)
	music:onButtonStateChanged(function(event)
		if event.state == "on" then
			audio.resumeMusic()
			ModifyData.setMusic(true)
		elseif  event.state == "off" then
			audio.pauseMusic()
			ModifyData.setMusic(false)
			
		end
	end)
	music:setButtonSelected(true)
	music:addTo(self)

end

function StartScene:onEnter()
    audio.playMusic("music/fight.mp3",true)

end

function StartScene:onExit()
  
end



return StartScene