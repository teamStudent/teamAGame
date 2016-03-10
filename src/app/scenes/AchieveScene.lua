--[[
   游戏主场景

]]

--lua的类概念语法模式
local AchieveScene = class("AchieveScene", function()
    return display.newScene("AchieveScene")
end)

--new函数的lua或js语言的标准入口点回调
function AchieveScene:ctor()
	-- cc.ui.UILabel.new({
 --            UILabelType = 2, text = "Hello, World", size = 64})
 --        :align(display.CENTER, display.cx, display.cy)
 --        :addTo(self)

    self:init()
end

function AchieveScene:init()
	

	--背景
	local bg = display.newSprite("bg222.jpg")
  	bg:pos(display.cx, display.cy)
  	self:addChild(bg)

  	--返回
  	local backBtn = cc.ui.UIPushButton.new({normal="back.png"},{scale9=true})
	backBtn:onButtonClicked(function(event)
		display.replaceScene(StartScene.new())
	end)
	backBtn:pos(display.left+50, display.top-50)
	self:addChild(backBtn, 1)

  	--成就
	self.achment=cc.ui.UILabel.new({
      text ="成就",
      color = cc.c3b(250, 250, 5),
      size = 32,
    })
 	 :addTo(self)
  	self.achment:setAnchorPoint(cc.p(0.5,0))
  	self.achment:setPosition(cc.p(display.width/2,display.height*3/4))


	self._layer1=display.newColorLayer(cc.c4b(100,100,250,0))
    self._layer1:setAnchorPoint(cc.p(0,0))
    self._layer1:pos(display.width/4, display.height/4)
    self._layer1:setContentSize(cc.size(display.width/2,display.height*3/4))

    self._scroll2=cc.ScrollView:create(cc.size(display.width/2,display.height/2), self._layer1)
    self._scroll2:setDirection(1)
    self._scroll2:setContentOffsetInDuration(cc.p(0,-display.height/4),0.1)
    self._scroll2:setPosition(cc.p(display.width/4,display.height/4))
    self:addChild(self._scroll2)

	
	for i=1,6 do
	--底片
	local item1 = cc.Sprite:create("bg111.png")
	item1:setPosition(cc.p(display.width/4,display.height/16+(i-1)*display.height/8))
	self._scroll2:addChild(item1)

	--金币图标
	local item2 = cc.Sprite:create("GameScene/money.png")
	item2:setPosition(cc.p(item2:getContentSize().width/2,display.height/16+(i-1)*display.height/8))
	self._scroll2:addChild(item2)

	--数值
	self.shuzhi=cc.ui.UILabel.new({
      text ="1000",
      color = cc.c3b(250, 250, 5),
      size = 32,
    })
 	 :addTo(self._scroll2)
  	self.shuzhi:setAnchorPoint(cc.p(0,0))
  	self.shuzhi:setPosition(cc.p(0,(i-1)*display.height/8))

  	--目标
  	local mubiao
  	if i==1 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死600个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  	self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))	
  	end
  	if i==2 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死500个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  		self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))
  	end
  	if i==3 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死400个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  		self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))
  	end
  	if i==4 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死300个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  		self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))
  	end
  	if i==5 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死200个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  		self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))
  	end
  	if i==6 then
  		mubiao=cc.ui.UILabel.new({
      	text ="目标：杀死100个怪物",
      	color = cc.c3b(250, 250, 5),
      	size = 32,
    })
  		self._scroll2:addChild(mubiao)
  	mubiao:setAnchorPoint(cc.p(0,0))
  	mubiao:setPosition(cc.p(display.width/8,display.height/16+(i-1)*display.height/8))
  	end
  	

	end
end

function AchieveScene:onEnter()
end

function AchieveScene:onExit()
end

return AchieveScene
