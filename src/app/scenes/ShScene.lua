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
local scheduler=require(cc.PACKAGE_NAME..".scheduler")
function ShScene:init()
	Shnumber=ShData.getShNum()
	totalNumber2=Data2.SCENE2[Shnumber].number
	self.money=Data2.SCENE2[Shnumber].money

	 local map1="map/"..Shnumber.."-".."map"..".tmx"
     print("MAP",map1)
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
   self.wuqi6Point=self.hero:getObject("wuqi6")
   self.wuqi7Point=self.hero:getObject("wuqi7")
   self.wuqi8Point=self.hero:getObject("wuqi8")
   self.wuqi9Point=self.hero:getObject("wuqi9")



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
      scheduler.unscheduleGlobal(self.remove)
     local stopLayer = StopLayer.new()
     stopLayer:setPosition(cc.p(0,0))
     self:addChild(stopLayer,3)
     end)
     stopBtn:setPosition(cc.p(display.width-30, display.height-30))
     stopBtn:setScale(0.4)
     self:addChild(stopBtn)

     local trees=display.newSprite("tree.png")
     trees:pos(display.left+30, display.top-23)
     trees:setScale(0.3)
     trees:addTo(self.tiledMap)
     self.treeLabel = cc.ui.UILabel.new({
       
        text=cc.UserDefault:getInstance():getIntegerForKey("TREE"),
        color = cc.c3b(250, 250, 5),
        size = 20,
    })
    :align(display.CENTER, display.left+60, display.top-20)
    :addTo(self.tiledMap,1)


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
     self.upTag=0
end

function ShScene:addEventListen()
    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
        if event.name=="began" then
            if self.upTag==2 then
                   self.upTag=1
                  self.scope:removeFromParent()      
              end
          for k1,v1 in pairs(self.cannon) do
              local rect1=self:newRect(v1)
              if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.upSprite=v1
                    self.upSpritePos=k1
                    self:upOrDownConnon()
              end
            for k,v in pairs(self.monster) do
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
local function createE()
    if self.number==nil then
          return
    end
    self.number=self.number+1
    if self.number>totalNumber2 then
        scheduler.unscheduleGlobal(self.handle1)
        self.handle1=nil
        self.number=1
        self.isWin=true
        return
    end
    self.enermyNumLabel:setString(self.number.."/"..totalNumber2)
    self.enemyCreateTime=1.5

   if Shnumer==2 then
      self.beginPoint=nil
      self.endPoint=nil
      self.endPoint= self.hero:getObject("end2")
      self.beginPoint= self.hero:getObject("begin2")
    else
      self.beginPoint=nil
      self.endPoint=nil
      self.endPoint= self.hero:getObject("end")
      self.beginPoint= self.hero:getObject("begin")
    end
    local function createMonster()
      if self.monsterNumber==10 then
        scheduler.unscheduleGlobal(self.handle)
        self.handle=nil
        self.monsterNumber=0
        return
      else
          local enermy=Enermy.new()
          self.moveSpeed=50
          
          if self.number==2 then
            enermy=nil
            enermy=Enermy2.new()
            self.moveSpeed=100
            self.enemyCreateTime=1.4
        elseif self.number==3 then
            enermy=nil
            enermy=Enermy3.new()
            self.moveSpeed=100
            self.enemyCreateTime=1.3
        elseif self.number==4 then
            enermy=nil
            enermy=Enermy4.new()
            self.moveSpeed=150
            self.enemyCreateTime=1.2
        elseif self.number==5 then
            enermy=nil
            enermy=Enermy5.new()
            self.moveSpeed=150
            self.enemyCreateTime=1.1
        elseif self.number==6 then
            enermy=nil
            enermy=Enermy6.new()
            self.moveSpeed=150
            self.enemyCreateTime=1.0
        elseif self.number==7 then
            enermy=nil
            enermy=Enermy7.new()
            self.moveSpeed=200
            self.enemyCreateTime=0.9
        elseif self.number==8 then
            enermy=nil
            enermy=Enermy8.new()
            self.moveSpeed=200
            self.enemyCreateTime=0.8
        elseif self.number==9 then
            enermy=nil
            enermy=Enermy9.new()
            self.moveSpeed=200
            self.enemyCreateTime=0.7
        elseif self.number==10 then
            enermy=nil
            enermy=Enermy10.new()
            self.moveSpeed=250
            self.enemyCreateTime=0.6
        elseif self.number==11 then
            enermy=nil
            enermy=Enermy11.new()
            self.moveSpeed=250
            self.enemyCreateTime=0.5
        elseif self.number==12 then
            enermy=nil
            enermy=Enermy12.new()
            self.moveSpeed=250
            self.enemyCreateTime=0.4
        elseif self.number==13 then
            enermy=nil
            enermy=Enermy13.new()
            self.moveSpeed=300
            self.enemyCreateTime=0.3
        elseif self.number==14 then
            enermy=nil
            enermy=Enermy14.new()
            self.moveSpeed=300
            self.enemyCreateTime=0.2
        elseif self.number==15 then
            enermy=nil
            enermy=Enermy15.new()
            self.moveSpeed=300
            self.enemyCreateTime=0.1
        end
          enermy:pos(self.beginPoint.x, self.beginPoint.y)
          enermy:addTo(self.tiledMap,1)
          self.monster[#self.monster+1]=enermy
          enermy:runAction(self:creatDongHua())
          self.monsterNumber=self.monsterNumber+1
        
      end
    end
    self.handle= scheduler.scheduleGlobal(createMonster,1.5)
end
self.handle1= scheduler.scheduleGlobal(createE,25)

end

function ShScene:createOneEnermy()
   if Shnumer==2 then
      self.beginPoint=nil
      self.endPoint=nil
      self.endPoint= self.hero:getObject("end2")
      self.beginPoint= self.hero:getObject("begin2")
    else
      self.beginPoint=nil
      self.endPoint=nil
      self.endPoint= self.hero:getObject("end")
      self.beginPoint= self.hero:getObject("begin")
    end
    local enermy
    local function createE()
        if self.monsterNumber==10 then
            scheduler.unscheduleGlobal(self.handle)
            self.handle=nil
            self.monsterNumber=0
            return
        end
         
        enermy=Enermy.new()
        self.moveSpeed=50
        enermy:pos(self.beginPoint.x, self.beginPoint.y)
        -- enermy.old_life=enermy.hp
        enermy:addTo(self.tiledMap,1)
        self.monster[#self.monster+1]=enermy
        enermy:runAction(self:creatDongHua())
        self.monsterNumber=self.monsterNumber+1
    end
    self.handle= scheduler.scheduleGlobal(createE,1.5)
end

function ShScene:angle(v1,v)
    local x = v1:getPositionX()-v:getPositionX()
    local y = v1:getPositionY()-v:getPositionY()
    
    if x>0 then
        if y==0 then
           return 90
        elseif y>0 then
            return math.atan(x/y)*180/3.14
        else
            return math.atan(x/y)*180/3.14+180
        end
    else
        if y>0 then
            return math.atan(x/y)*180/3.14
        elseif y==0 then
            return -90
        else
            return math.atan(x/y)*180/3.14-180
        end    
    end
end

 function ShScene:creatDongHua()
    local move={}
    local enermy=self.hero:getObjects()
    local i=1
    print("begin i=",i)
    local timee
    if Shnumber==2 then
       i=11
       print("shnumber=2",i)
       for k,v in pairs(enermy) do
        local name1="tag"..i
        if v.name==name1 then
            if i==11 then
                local x= self.beginPoint.x-v.x
                local y = self.beginPoint.y-v.y
                timee = math.sqrt(x*x+y*y)/self.moveSpeed
            else
                local str = "tag"..(i-1)
                local upv = self.hero:getObject(str)
                local x= upv.x-v.x
                local y = upv.y-v.y
                timee = math.sqrt(x*x+y*y)/self.moveSpeed
            end
            i=i+1

            move[#move+1]=cc.MoveTo:create(timee,cc.p(v.x,v.y))
        end
    end
    else
      i=1
        for k,v in pairs(enermy) do
        local name1="tag"..i
        if v.name==name1 then
            if i==1 then
                local x= self.beginPoint.x-v.x
                local y = self.beginPoint.y-v.y
                timee = math.sqrt(x*x+y*y)/self.moveSpeed
            else
                local str = "tag"..(i-1)
                local upv = self.hero:getObject(str)
                local x= upv.x-v.x
                local y = upv.y-v.y
                timee = math.sqrt(x*x+y*y)/self.moveSpeed
            end
            i=i+1

            move[#move+1]=cc.MoveTo:create(timee,cc.p(v.x,v.y))
        end
    end
end

   
    local str = "tag"..(i-1)
    local upv = self.hero:getObject(str)
    local x= upv.x-self.endPoint.x
    local y = upv.y-self.endPoint.y
    timee = math.sqrt(x*x+y*y)/self.moveSpeed
    move[#move+1]=cc.MoveTo:create(timee,cc.p(self.endPoint.x, self.endPoint.y))
    move[#move+1]=cc.CallFunc:create(function (event)
        event.isMove=false
    end)
    local seq = cc.Sequence:create(move)
    return seq
end

function ShScene:testTouch()
local money1 = display.newSprite("GameScene/money.png")
    money1:pos(self.wuqi1Point.x-2,display.bottom+75)
    money1:setScale(0.4)
    money1:addTo(self.tiledMap)
      --显示需要金币的数量
     cc.ui.UILabel.new({
      text = "80",
      color = cc.c3b(250, 250, 5),
      size = 15,
    })
    :pos(self.wuqi1Point.x+3,display.bottom+80)
    :addTo(self.tiledMap)

    local showWuqi1=display.newSprite("GameScene/showWuqi.png")
    showWuqi1:pos(self.wuqi1Point.x, self.wuqi1Point.y)
    showWuqi1:addTo(self.tiledMap,2)
    local wuqi1 = display.newSprite("GameScene/wuqi1.png")
    wuqi1:setScale(0.4)
    wuqi1:pos(showWuqi1:getContentSize().width/2,showWuqi1:getContentSize().height/2)
    wuqi1:addTo(showWuqi1)
    wuqi1:setTouchEnabled(true)
    wuqi1:setTouchSwallowEnabled(false)
    wuqi1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)   
        if event.name=="began" then
            self.showLayer:show()
            self.addSp=Wuqi1.new()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true
        elseif event.name=="moved" then
           self.addSp:pos(event.x, event.y) 
        elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end
        
    end)


    local money2 = display.newSprite("GameScene/money.png")
    money2:pos(self.wuqi2Point.x-4, display.bottom+75)
    money2:setScale(0.4)
    money2:addTo(self.tiledMap)
      --显示需要金币的数量
     cc.ui.UILabel.new({
      text = "100",
      color = cc.c3b(250, 250, 5),
      size = 15,
    })
    :pos(self.wuqi2Point.x+1, display.bottom+80)
    :addTo(self.tiledMap)

    local showWuqi2=display.newSprite("GameScene/showWuqi.png")
    showWuqi2:pos(self.wuqi2Point.x, self.wuqi2Point.y)
    showWuqi2:addTo(self.tiledMap,2)
    local wuqi2 = display.newSprite("GameScene/wuqi2.png")
    wuqi2:setScale(0.8)
    wuqi2:pos(showWuqi2:getContentSize().width/2,showWuqi2:getContentSize().height/2)
    wuqi2:addTo(showWuqi2)
    wuqi2:setTouchEnabled(true)
    wuqi2:setTouchSwallowEnabled(false)
    wuqi2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
      if event.name=="began" then
            self.addSp=Wuqi2.new()
            self.showLayer:show()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true

      elseif event.name=="moved" then
            self.addSp:pos(event.x, event.y)

       elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end
    end)

    local money3 = display.newSprite("GameScene/money.png")
    money3:pos(self.wuqi3Point.x-4, display.bottom+75)
    money3:setScale(0.4)
    money3:addTo(self.tiledMap)
      --显示需要金币的数量
     cc.ui.UILabel.new({
      text = "120",
      color = cc.c3b(250, 250, 5),
      size = 15,
    })
    :pos(self.wuqi3Point.x+1, display.bottom+80)
    :addTo(self.tiledMap)

    local showWuqi3=display.newSprite("GameScene/showWuqi.png")
    showWuqi3:pos(self.wuqi3Point.x, self.wuqi3Point.y)
    showWuqi3:addTo(self.tiledMap,2)
    local wuqi3 =  display.newSprite("GameScene/wuqi3.png")
    wuqi3:setScale(0.8)
    wuqi3:pos(showWuqi3:getContentSize().width/2,showWuqi3:getContentSize().height/2)
    wuqi3:addTo(showWuqi3)
    wuqi3:setTouchEnabled(true)
    wuqi3:setTouchSwallowEnabled(false)
    wuqi3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)   
        if event.name=="began" then
            self.addSp=Wuqi3.new()
            self.showLayer:show()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true
        elseif event.name=="moved" then
           self.addSp:pos(event.x, event.y) 
        elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end
        
    end)

    
    local money4 = display.newSprite("GameScene/money.png")
    money4:pos(self.wuqi4Point.x-4, display.bottom+75)
    money4:setScale(0.4)
    money4:addTo(self.tiledMap)
      --显示需要金币的数量
     cc.ui.UILabel.new({
      text = "200",
      color = cc.c3b(250, 250, 5),
      size = 15,
    })
    :pos(self.wuqi4Point.x+1, display.bottom+80)
    :addTo(self.tiledMap)

    local showWuqi4=display.newSprite("GameScene/showWuqi.png")
    showWuqi4:pos(self.wuqi4Point.x, self.wuqi4Point.y)
    showWuqi4:addTo(self.tiledMap,2)
    local wuqi4 =  display.newSprite("GameScene/wuqi4.png")
    wuqi4:setScale(0.8)
    wuqi4:pos(showWuqi4:getContentSize().width/2,showWuqi4:getContentSize().height/2)
    wuqi4:addTo(showWuqi4)
    wuqi4:setTouchEnabled(true)
    wuqi4:setTouchSwallowEnabled(false)
    wuqi4:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)   
        if event.name=="began" then
            self.addSp=Wuqi4.new()
            self.showLayer:show()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true
        elseif event.name=="moved" then
           self.addSp:pos(event.x, event.y) 
        elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end
        
    end)


    local money5 = display.newSprite("GameScene/money.png")
    money5:pos(self.wuqi5Point.x-4, display.bottom+75)
    money5:setScale(0.4)
    money5:addTo(self.tiledMap)
      --显示需要金币的数量
     cc.ui.UILabel.new({
      text = "300",
      color = cc.c3b(250, 250, 5),
      size = 15,
    })
    :pos(self.wuqi5Point.x+1, display.bottom+80)
    :addTo(self.tiledMap)

    local showWuqi5=display.newSprite("GameScene/showWuqi.png")
    showWuqi5:pos(self.wuqi5Point.x, self.wuqi5Point.y)
    showWuqi5:addTo(self.tiledMap,2)
    local wuqi5 = cc.Sprite:create("GameScene/wuqi5.png")
    wuqi5:pos(showWuqi5:getContentSize().width/2,showWuqi5:getContentSize().height/2)
    wuqi5:addTo(showWuqi5)
    wuqi5:setTouchEnabled(true)
    wuqi5:setTouchSwallowEnabled(false)
    wuqi5:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)   
        if event.name=="began" then
            self.showLayer:show()
            self.addSp=Wuqi5.new()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true
        elseif event.name=="moved" then
           self.addSp:pos(event.x, event.y) 
        elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end       
    end)

    local showWuqi6=display.newSprite("GameScene/showWuqi.png")
    showWuqi6:pos(self.wuqi6Point.x, self.wuqi6Point.y)
    showWuqi6:addTo(self.tiledMap,2)
    local wuqi6 = cc.Sprite:create("yilidanTD.png")
    wuqi5:pos(showWuqi6:getContentSize().width/2,showWuqi6:getContentSize().height/2)
    wuqi5:addTo(showWuqi6)
    wuqi5:setTouchEnabled(true)
    wuqi5:setTouchSwallowEnabled(false)
    wuqi5:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)   
        if event.name=="began" then
            self.showLayer:show()
            self.addSp=Wuqi_jl6.new()
            self.addSp:pos(event.x, event.y)
            self.addSp:setAnchorPoint(cc.p(0.5,0.5))
            self.addSp:addTo(self.tiledMap,2)
            return true
        elseif event.name=="moved" then
           self.addSp:pos(event.x, event.y) 
        elseif event.name=="ended" then
            self.showLayer:hide()
            local x= event.x/64
            local y = (640-event.y)/64
            local tileGid = self.showLayer:getTileGIDAt(cc.p(math.floor(x),math.floor(y)))
            if tileGid<=0 then
                self.addSp:removeFromParent()
                return
            end
            for k,v in pairs(self.cannon) do
                local rect1= self:newRect(v)
                if cc.rectContainsPoint(rect1,cc.p(event.x,event.y)) then
                    self.addSp:removeFromParent()
                    return
                end
            end
            if self.money-self.addSp.make<0 then
                self.addSp:removeFromParent()
                return
            end
            self.addSp:pos(math.floor(x)*64+32, math.floor(10-y)*64+32)
            self.cannon[#self.cannon+1]=self.addSp
            self.money=self.money-self.addSp.make
            self.moneyNumLabel:setString(self.money)
        end       
    end)
end

function ShScene:attack(v1,v)


  if v1:getTag()==10 then
    local rotate=cc.RotateTo:create(0.01,self:angle(v1,v)+180)
    v1:runAction(rotate)
    bullet = Bullet1.new()
    bullet:setScale(0.5)
    bullet:setAnchorPoint(cc.p(0.5,0.5))
    bullet:setPosition(v1:getPositionX(),v1:getPositionY())
    bullet:setRotation(v1:getRotation())
    bullet:addTo(self.tiledMap,3) 

    local move=cc.MoveTo:create(0.2,cc.p(v:getPositionX(),v:getPositionY()))
    local func = cc.CallFunc:create(function (event)
    self.bullet[#self.bullet+1]=bullet
    event.isMove=false
    end)
    local seq = cc.Sequence:create(move,func) 
    bullet.isMove=true
    bullet.firepower=v1.firepower 
    bullet:runAction(seq)

  elseif v1:getTag()==20 then
    local rotate=cc.RotateTo:create(0.01,self:angle(v1,v)+180)
    v1:runAction(rotate)
    bullet = Bullet2.new()
    bullet:setAnchorPoint(cc.p(0.5,0.5))
    bullet:setPosition(v1:getPositionX(),v1:getPositionY())
    bullet:setRotation(v1:getRotation())
    local move=cc.MoveTo:create(0.2,cc.p(v:getPositionX(),v:getPositionY()))
    local func = cc.CallFunc:create(function(bullet)

    self.bullet[#self.bullet+1]=bullet
      bullet.isMove=false
    end)
    seq = cc.Sequence:create(move,func) 
    bullet.isMove=true
    bullet.firepower=v1.firepower
    bullet:addTo(self.tiledMap,3)  
    bullet:runAction(seq)

  elseif v1:getTag()==30 then
    local rotate=cc.RotateTo:create(0.01,self:angle(v1,v)+180)
    v1:runAction(rotate)
    bullet = Bullet3.new()
    bullet:setAnchorPoint(cc.p(0.5,0.5))
    bullet:setRotation(v1:getRotation())
    bullet:setPosition(v1:getPositionX(),v1:getPositionY())
    local move=cc.MoveTo:create(0.2,cc.p(v:getPositionX(),v:getPositionY()))
    local func = cc.CallFunc:create(function (bullet)    

    self.bullet[#self.bullet+1]=bullet
    bullet.isMove=false
    end)
    local seq = cc.Sequence:create(move,func) 
    bullet.isMove=true
    bullet.firepower=v1.firepower
    bullet:addTo(self.tiledMap,3)  
    bullet:runAction(seq)
  elseif v1:getTag()==50 then
       bullet = Bullet5.new()
       bullet:setScale(0.5)
       bullet:setPosition(v:getPositionX(),v:getPositionY()+65)
       bullet:setAnchorPoint(cc.p(0.5,0.5))
       self.bullet[#self.bullet+1]=bullet
       local delay=cc.DelayTime:create(2)

    local func = cc.CallFunc:create(function (event)
          
          self.bullet[#self.bullet+1]=bullet
          event.isMove=false
            
    end)
    

    local seq = cc.Sequence:create(delay,func) 
    bullet.isMove=true
    bullet.firepower=v1.firepower
    bullet:addTo(self.tiledMap,3)  
    bullet:runAction(seq)
        
  elseif v1:getTag()==40 then

        bullet = Bullet4.new()
        local move=cc.MoveTo:create(0.2,cc.p(v:getPositionX(),v:getPositionY()))

        local func = cc.CallFunc:create(function (bullet)

           self.bullet[#self.bullet+1]=bullet
            bullet.isMove=false
            
        end)

       local seq = cc.Sequence:create(move,func) 
        bullet:setScale(0.6)
        bullet.isMove=true
        bullet:setPosition(v1:getPositionX(),v1:getPositionY())
        bullet:addTo(self.tiledMap,3)  
        bullet:runAction(seq)
        bullet.firepower=v1.firepower 
  end
    
end

function ShScene:newRect(v)
    if v==nil then
       return cc.rect(0,0,0,0)
    end
    local size = v:getContentSize()
    local x = v:getPositionX()
    local y = v:getPositionY()
    local rect = cc.rect(x-size.width/2, y-size.height/2,size.width, size.height)
    return rect
end

function ShScene:updata()
local function attackEnermy()
        for k1,v1 in pairs(self.cannon) do
            for k,v in pairs(self.monster) do
                --计算敌人与炮塔的距离
                local x= v:getPositionX()-v1:getPositionX()
                local y= v:getPositionY()-v1:getPositionY()
                local s = math.sqrt(x*x+y*y)
                --如果距离小于武器的攻击范围，那么攻击
                if s<=v1.scope then 
                    if v1.attack==true then
                        v1.attack=false
                        local delay = cc.DelayTime:create(v1.attackSpeed)
                        local func= cc.CallFunc:create(function (even)
                            even.attack=true
                        end)
                    local seq = cc.Sequence:create(delay,func)
                        v1:runAction(seq)
                        self:attack(v1,v)
                    end
                    break
                end 
            end
        end 
        if self.isWin and #self.monster==0 then
            
            
             --修改数据
            self:modify()
            local Win = WinLayer.new()
            Win:setPosition(cc.p(0, 0))
            self:addChild(Win,3)
               

        end
    end
    self.handle2= scheduler.scheduleGlobal(attackEnermy,0.1)

end

function ShScene:removeUpdata()
    
local function remove_nomove()
        for k,v in pairs(self.monster) do
          local rect1= v:getBoundingBox()
          for k1,v1 in pairs(self.bullet) do
            if v1.tag==100 then
                    rect2=v1:getBoundingBox()

                    if cc.rectIntersectsRect(rect2,rect1) then

                        v.hp=v.hp-v1.firepower
                        v.life:setScaleX(v.hp/v.old_life)
                        v1:removeFromParent()
                        v1=nil
                        table.remove(self.bullet,k1)
                    end 
              elseif v1.tag==200 then
                    rect2=v1:getBoundingBox()
                    if cc.rectIntersectsRect(rect2,rect1) then
                        v.hp=v.hp-v1.firepower
                        v.life:setScaleX(v.hp/v.old_life)
                        v1:removeFromParent()
                        v1=nil
                        table.remove(self.bullet,k1)
                    end 
                elseif v1.tag==300 then
                    rect2=v1:getBoundingBox()
                    if cc.rectIntersectsRect(rect2,rect1) then
                        v.hp=v.hp-v1.firepower
                        v.life:setScaleX(v.hp/v.old_life)
                        v1:removeFromParent()
                        v1=nil
                        table.remove(self.bullet,k1)
                    end 
                elseif v1.tag==400 then
                    rect2=v1:getBoundingBox()
                    if cc.rectIntersectsRect(rect2,rect1) then
                        v.hp=v.hp-v1.firepower
                        v.life:setScaleX(v.hp/v.old_life)
                        -- v1:stopAllActions()
                        table.remove(self.bullet,k1)
                        v1:removeFromParent()
                        v1=nil
                        
                    end 
                elseif v1.tag==500 then
                    rect2=v1:getBoundingBox()
                    if cc.rectIntersectsRect(rect2,rect1) then
                        v.hp=v.hp-v1.firepower
                        v.life:setScaleX(v.hp/v.old_life)
                        table.remove(self.bullet,k1)
                        v1:removeFromParent()
                        v1=nil
                        
                    end 
                end
          end
        end

        for i=#self.monster,1,-1 do
            if  self.monster[i].isMove==false then
                    print("ISMOVE=",self.monster[i].isMove)
                    self.monster[i]:removeFromParent()
                    table.remove(self.monster,i)
                    v=nil
            end
            if self.monster[i]~=nil and self.monster[i].hp<=0 then
                self.money=self.money+self.monster[i].money
                self.moneyNumLabel:setString(self.money)
                self.killEnermyNumber=self.killEnermyNumber+1
                self.killEnermyNumLabel:setString(self.killEnermyNumber)
                self.monster[i]:removeFromParent()
                table.remove(self.monster,i)


                math.randomseed(os.time())
                local time = math.random()
                print("time",time)
                if time<=1 then
                   local sp=display.newSprite("tree.png")
                   sp:pos(display.width/2, display.height/2)
                   sp:setScale(0.5)
                   sp:addTo(self.tiledMap)

                   local dz=cc.MoveTo:create(0.5,cc.p(display.left+30, display.top-23))
                   local sc=cc.ScaleTo:create(0.5,0)
                   local ca=cc.CallFunc:create(function()
                   cc.UserDefault:getInstance():setIntegerForKey("TREE",cc.UserDefault:getInstance():getIntegerForKey("TREE")+1)
                   local num = cc.UserDefault:getInstance():getIntegerForKey("TREE")
                   self.treeLabel:setString(num)
                   end)
                   local seq=cc.Sequence:create(dz,sc,ca)
                   sp:runAction(seq)
                end
            end
        end
        for i=#self.bullet,1,-1 do
            if self.bullet[i].isMove==false  then
                self.bullet[i]:removeFromParent()
                table.remove(self.bullet,i)
               
            end
        end

    end
    self.remove= scheduler.scheduleGlobal(handler(self, remove_nomove),0.01)

end



















return ShScene