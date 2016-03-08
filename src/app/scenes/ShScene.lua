--
-- Author: Your Name
-- Date: 2016-03-07 10:17:29
--
ShScene=class("ShScene", function (  )
	return display.newScene("ShScene")
end)

function ShScene:ctor()
	self:init()
end

local Shnumber
local totalNumber2
function ShScene:init()
	Shnumber=ShData.getShNum()
	totalNumber2=Data2.SCENE2[Shnumber].number
	self.money=Data2.SCENE2[Shnumber].money
	-- if Shnumber==1 then
	-- 	print("jl")
	-- 	else if Shnumber==2 then
	-- 		print("sz")
	-- 	else
	-- 		print("bsz")
	-- 	end
	-- end

	 local map1="map/"..Shnumber.."-".."map"..".tmx"
	 self.monsterNumber=0 --怪物数
	 self.number=0 --波束
	 self.killEnermyNumber=0 -- 杀敌数
	 self.isWin=false
	 self.tiledMap=cc.TMXTiledMap:create(map1)
	 self.tiledMap:addTo(self)
	 self.hero=self.tiledMap:getObjectGroup("obj1")
	 self.layer=self.tiledMap:getLayer("layer1")
	 self.showLayer=self.tiledMap:getLayer("showLayer1")
	 self.showLayer:hide()


	 self.wuqi1Point=self.hero:getObject("wuqi1")
	 self.wuqi2Point=self.hero:getObject("wuqi2")
	 self.wuqi3Point=self.hero:getObject("wuqi3")
	 self.wuqi4Point=self.hero:getObject("wuqi4")
	 self.wuqi5Point=self.hero:getObject("wuqi5")


	 local rain=cc.ParticleRain:createWithTotalParticles(2000)
	 rain:pos(display.cx, display.top)
	 rain:addTo(self.tiledMap)
	 

	 local moneySp=display.newSprite("GameScene/money.png")
     moneySp:pos(display.left+150, display.top-23)
     moneySp:setScale(0.8)
     moneySp:addTo(self.tiledMap)
     self.moneyNumLabel=cc.ui.UILabel.new({
     text =self.money,
     color = cc.c3b(250, 250, 5),
     size = 20,
     })
     :align(display.CENTER, display.left+200, display.top-20)
     :addTo(self.tiledMap,1)


     local killEnermySp=display.newSprite("GameScene/dao.png")
     killEnermySp:pos(display.cx, display.top-20)
     killEnermySp:setScale(0.8)
     killEnermySp:addTo(self.tiledMap)
     self.killEnermyNumLabel=cc.ui.UILabel.new({
      text =self.killEnermyNumber,
      color = cc.c3b(250, 250, 5),
      size = 20,
     })
     :align(display.CENTER, display.cx+35, display.top-20)
     :addTo(self.tiledMap,1)


     local enermyNumSp=display.newSprite("GameScene/qizi.png")
     enermyNumSp:pos(display.cx+250, display.top-20)
     enermyNumSp:setScale(0.8)
     enermyNumSp:addTo(self.tiledMap)
     self.enermyNumLabel=cc.ui.UILabel.new({
      text =self.number.."/"..totalNumber2,
      color = cc.c3b(250, 250, 5),
      size = 20,
     })
     :align(display.CENTER, display.cx+285, display.top-20)
     :addTo(self.tiledMap,1)


     local stopBtn = cc.ui.UIPushButton.new({normal = "GameScene/stopBtn.png"}, {scale9 = true})
     stopBtn:onButtonClicked(function(event)
     cc.Director:getInstance():pause()
     local stopLayer = StopLayer.new()
     stopLayer:setPosition(cc.p(0,0))
     self:addChild(stopLayer,3)
     end)
     stopBtn:setPosition(cc.p(display.width-30, display.height-30))
     stopBtn:setScale(0.4)
     self:addChild(stopBtn)


      --添加大炮
     self.cannon={}
     --敌人表
     self.monster={}
     --子弹
     self.bullet={}
     --时间调度，开始出怪
     self:createOneEnermy()
     self:createEnermy()
     --初始化道具
     self:testTouch()
     -- 时间调度，怪进入塔的攻击范围之内，开始攻击
     self:updata()
     --时间调度，清除已完成动作的
     self:removeUpdata()
     self:addEventListen()
end

function ShScene:addEventListen()
    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
        if event.name=="began" then
          for k1,v1 in pairs(self.cannon) do
              local rect1=self:newRect(v1)
              for k,v in pairs(table_name) do
                local rect1=self:newRect(v)
              if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                  local x=v:getPositionX()-v1:getPositionX()
                  local y=v:getPositionY()-v1:getPositionY()
                  local s=math.sqrt(x*x+y*y)

                  if s<=v1.scope then
                     if v1.attack==true then
                         v1.attack=false
                         local delay = cc.DelayTime:create(v1.attackSpeed)
                         local func = cc.CallFunc:create(function(event)
                            event.attack=true
                            end)
                         local seq = cc.Sequence:create(delay,func)
                        v1:runAction(seq)
                        self:attack(v1,v)
                     end
                     break
                  end
               end                  
             end
          end
          return true
        end     
    end)
end

function ShScene:createEnermy()


end

function ShScene:createOneEnermy()



end

function ShScene:testTouch()


end

function ShScene:updata()

end

function ShScene:removeUpdata()


end



















return ShScene