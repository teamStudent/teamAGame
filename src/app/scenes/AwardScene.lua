--
-- Author: Echo
-- Date: 2016-03-07 10:36:13
-- 类的常见创建
local AwardScene = class("AwardScene",function()
	return display.newScene("AwardScene")
end)
-- 构造函数
function AwardScene:ctor()
	self:init()
end
-- 初始化
function AwardScene:init()
	--不同卡牌类型数目的初始化
	cc.UserDefault:getInstance():setIntegerForKey("kapai1num", 0)
	cc.UserDefault:getInstance():setIntegerForKey("kapai2num", 0)
	cc.UserDefault:getInstance():setIntegerForKey("kapai3num", 0)
	cc.UserDefault:getInstance():setIntegerForKey("kapai4num", 0)
	cc.UserDefault:getInstance():setIntegerForKey("kapai5num", 0)
	-- 背景
	local bg = display.newSprite("AwardScene/bg.png")
	bg:pos(display.cx, display.cy)
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScale(scaleX,scaleY)
	self:addChild(bg)
    -- 返回按钮
	local backBtn = cc.ui.UIPushButton.new({normal="back.png"},{scale9=true})
	backBtn:onButtonClicked(function(event)
		display.replaceScene(StartScene.new())
	end)
	backBtn:pos(display.left+50, display.top-50)
	self:addChild(backBtn, 1)
    -- 宝箱
	local baoxiang = cc.ui.UIPushButton.new({normal="AwardScene/baoxiang1.png",pressed="AwardScene/baoxiang2.png"},{scale9=true})
	baoxiang:onButtonClicked(function(event)
		--
	end)
	baoxiang:pos(display.cx, display.cy+75)
	self:addChild(baoxiang, 1)
	-- 真随机数种子设置
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    --创建卡牌
	for i=1,5 do
		local back = display.newSprite("AwardScene/back.png")
		back:pos(display.cx-300+150*(i-1), display.cy-150)
		self:add(back)
		-- 创建一个变量来存储卡牌的类型
		local ran=math.random(1,5)
		local front = display.newSprite("AwardScene/kapai"..ran..".png")
		front:pos(display.cx-300+150*(i-1), display.cy-150)
		front:setVisible(false)
		self:add(front)

		back:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
		back:setTouchEnabled(true)
		back:addNodeEventListener(
		cc.NODE_TOUCH_EVENT, 
		function(event)
			if event.name == "began" then
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
				back:runAction(cc.Spawn:create(orbit1,seq1))
				front:runAction(cc.Spawn:create(orbit2,seq2))
				if ran==1 then
					cc.UserDefault:getInstance():setIntegerForKey("kapai1num", cc.UserDefault:getInstance():getIntegerForKey("kapai1num")+1)
					print(cc.UserDefault:getInstance():getIntegerForKey("kapai1num"))
				elseif ran==2 then
					cc.UserDefault:getInstance():setIntegerForKey("kapai2num", cc.UserDefault:getInstance():getIntegerForKey("kapai2num")+1)
					print(cc.UserDefault:getInstance():getIntegerForKey("kapai2num"))
				elseif ran==3 then
					cc.UserDefault:getInstance():setIntegerForKey("kapai3num", cc.UserDefault:getInstance():getIntegerForKey("kapai3num")+1)
					print(cc.UserDefault:getInstance():getIntegerForKey("kapai3num"))
				elseif ran==4 then
					cc.UserDefault:getInstance():setIntegerForKey("kapai4num", cc.UserDefault:getInstance():getIntegerForKey("kapai4num")+1)
					print(cc.UserDefault:getInstance():getIntegerForKey("kapai4num"))
				else
					cc.UserDefault:getInstance():setIntegerForKey("kapai5num", cc.UserDefault:getInstance():getIntegerForKey("kapai5num")+1)
					print(cc.UserDefault:getInstance():getIntegerForKey("kapai5num"))
				end
				return true
			end
		end)
    end
end

function AwardScene:onEnter()

end

function AwardScene:onExit()

end

return AwardScene