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
	self:initData()
	local bg = display.newSprite("StartScene/bg.png")
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScale(scaleX,scaleY)
	bg:setPosition(cc.p(display.cx,display.cy))
	self:addChild(bg)

	-- local bb = Enermy:new()
	-- bb:setPosition(100,100)
	-- self:addChild(bb, 3)


    -- 开始按钮
	self._startButton = cc.ui.UIPushButton.new({normal="StartScene/play.png"},{scale9=true})
	                   :onButtonClicked(function(event)
                   	   display.replaceScene(SelectScene.new())
                       end)
                       :pos(display.cx, display.cy-30)
                       :addTo(self)
                       :setScale(1.5)
    -- 签到按钮
    self._awardButton = cc.ui.UIPushButton.new({normal="StartScene/award1.png",pressed="StartScene/award2.png"},{scale9=true})
     					:onButtonClicked(function(event)
     					-- display.replaceScene(AwardScene.new(),"pageTurn",1.2)
     						local date = os.date("%d")
							local month = os.date("%m")
							local year = os.date("%Y")
							print(tonumber(date))
     					if 	 tonumber(date)~=cc.UserDefault:getInstance():getIntegerForKey("date") then
     							cc.UserDefault:getInstance():setIntegerForKey("date",date)
     							display.replaceScene(AwardScene.new(),"pageTurn",1.2)
     				    else 
     				    	if  tonumber(month)~=cc.UserDefault:getInstance():getIntegerForKey("month") then
     							cc.UserDefault:getInstance():setIntegerForKey("date",date)
     							display.replaceScene(AwardScene.new(),"pageTurn",1.2)
							else
								if  tonumber(year)~=cc.UserDefault:getInstance():getIntegerForKey("year") then
     							cc.UserDefault:getInstance():setIntegerForKey("year",date)
     							display.replaceScene(AwardScene.new(),"pageTurn",1.2)
						
								end
							end
						end		
     					end)
     					:pos(display.cx-10, display.cy-170)
     					:addTo(self)
     					:setScale(0.9)

    --成就按钮
    self._startButton = cc.ui.UIPushButton.new({normal="chengJiu.jpg"},{scale9=true})
	                   :onButtonClicked(function(event)
                   	   display.replaceScene(AchieveScene.new())
                       end)
                       :pos(display.cx, display.cy-90)
                       :addTo(self)
                       -- :setScale(1.5)
                       

	
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
-- 创建数据初始化方法
function StartScene:initData()

	if cc.UserDefault:getInstance():getBoolForKey("isSet")==false then
		-- 创建存储本地的时间，对后面的签到进行判断
		local date = os.date("%d")
		local month = os.date("%m")
		local year = os.date("%Y")
		
		cc.UserDefault:getInstance():setIntegerForKey("date", -1)
		print("date",cc.UserDefault:getInstance():getIntegerForKey("date"))
		cc.UserDefault:getInstance():setIntegerForKey("month",month)
		print("month",cc.UserDefault:getInstance():getIntegerForKey("month"))
		cc.UserDefault:getInstance():setIntegerForKey("year",year)
		print("year",cc.UserDefault:getInstance():getIntegerForKey("year"))

		cc.UserDefault:getInstance():setBoolForKey("isSet",true)
		--添加是否为第一次签到的数据存储
		-- cc.UserDefault:getInstance():setBoolForKey("isAward", false)
		--不同卡牌类型数目的初始化
		cc.UserDefault:getInstance():setIntegerForKey("kapai1num", 0)
		cc.UserDefault:getInstance():setIntegerForKey("kapai2num", 0)
		cc.UserDefault:getInstance():setIntegerForKey("kapai3num", 0)
		cc.UserDefault:getInstance():setIntegerForKey("kapai4num", 0)
		cc.UserDefault:getInstance():setIntegerForKey("kapai5num", 0)
	end
end

function StartScene:onEnter()
    audio.playMusic("music/fight.mp3",true)

end

function StartScene:onExit()
  
end



return StartScene