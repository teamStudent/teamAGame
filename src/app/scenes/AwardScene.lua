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
		back.isTouch = false

		back:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
		back:setTouchEnabled(true)
		back:setScaleX(-1)
		back:addNodeEventListener(
		cc.NODE_TOUCH_EVENT, 
		function(event)
			if event.name == "began" then
				if back.isTouch then
					return
				end
				local action = cc.OrbitCamera:create(0.3,1,0,0,90,0,5)
				local action2 = cc.OrbitCamera:create(0.75,1,0,90,180,5,-10)
				local action3 = cc.OrbitCamera:create(0.4,1,0,270,90,-5,5)
				local action4 = cc.OrbitCamera:create(0.65,1,0,360,90,0,5)
				local action5 = cc.EaseElasticOut:create(cc.OrbitCamera:create(1.5,1,0,450,90,5,-5),0.6) 
				back.isTouch = true
				back.isBack = true
				local str_a = "AwardScene/back.png"
				local str_b = "AwardScene/kapai"..ran..".png"
				local cardChange =  function ()
					if not back.isBack then
						back.isBack = true
						local cache = cc.Director:getInstance():getTextureCache():addImage(str_a) 
						back:setTexture(cache)
						
					else
						local cache = cc.Director:getInstance():getTextureCache():addImage(str_b) 
						back.isBack = false
						back:setTexture(cache)
					end
				end
				local seq1 = cc.Sequence:create(
					action,
					cc.CallFunc:create (cardChange),
					action2,
					cc.CallFunc:create (cardChange),
					action3,
					action4,
					cc.CallFunc:create (cardChange),
					action5
					)
				back:runAction(seq1)

				local str = string.format("kapai%dnum", ran)
				cc.UserDefault:getInstance():setIntegerForKey(str, cc.UserDefault:getInstance():getIntegerForKey(str)+1)
				print(str,cc.UserDefault:getInstance():getIntegerForKey(str))

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