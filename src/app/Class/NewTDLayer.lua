--
-- Author: Your Name
-- Date: 2016-03-10 11:38:27
--
local NewTDLayer=class("NewTDLayer", function()
	return display.newColorLayer(cc.c4b(105, 105, 105,100))
end)

function NewTDLayer:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))
	self:init()
end

function NewTDLayer:init()

	local anode =display.newNode()
    anode:pos(0,0)
    self:addChild(anode)

    local anode_sz =display.newNode()
    anode_sz:pos(0,0)
    self:addChild(anode_sz)

	local bg=display.newSprite("NewTDLayer/kuang.png")
	bg:pos(display.width/2, display.height/2)
	bg:addTo(anode)

	local close=cc.ui.UIPushButton.new({normal="ChooseLayer/close.png",pressed="ChooseLayer/close.png"}, {scale9=true})
	           :onButtonClicked(function()
	           	self:removeSelf()
	           	end)
	           :pos(display.cx+bg:getContentSize().width/2, display.cy+bg:getContentSize().height/2)
	           :setScale(0.5)
	           :addTo(anode,11)

	local TD_name=cc.ui.UILabel.new({
		text="Name:",
		color = cc.c3b(250, 0, 0),
        size = 25,
		})
	:align(display.CENTER, display.width/2-200, display.left+450)
	:addTo(anode,11)

	local TD_money=cc.ui.UILabel.new({
		text="Need More:",
		color=cc.c3b(250, 0, 0),
		size=25,
		})
	:align(display.CENTER, display.width/2-200, display.left+350)
	:addTo(anode,11)

	local TD_store=cc.ui.UILabel.new({
        text="History:",
        color=cc.c3b(250, 0, 0),
        size=25,
		})
	:align(display.CENTER, display.cx-200, display.left+250)
	:addTo(anode,11)



	local TDsure=cc.ui.UIPushButton.new({normal="NewTDLayer/okItem1.png",pressed="NewTDLayer/okItem2.png"}, {scale9=true})
			:onButtonClicked(function()
			 self:Buy()

				end)
			:pos(display.cx, display.cy-bg:getContentSize().height/2+50)
			:setScale(0.5)
			:addTo(anode)

	local display_table = {
		{	name = "暗夜精灵防御塔1--弓箭手"	,resource = "NEED   100*TREES"	,content = "暗夜精灵族培养出的金英弓箭手，\n准确的射击及高速的射击能让他\n们在所有猎手当中处于不败之地"					},
		{	name = "暗夜精灵防御塔2--月光井"	,resource = "NEED   300*TREES"	,content = "暗夜精灵族的标志性建筑物，\n利用月光积蓄能量，\n吸取天地精华的月光井，\n可以准确地找到目标并进行高速的\n射击,让对手无处可逃"					},
		{	name = "暗夜精灵防御塔3--远古意志"	,resource = "NEED   700*TREES"	,content = "暗夜精灵族人进行仪式召唤出来的\n来至远古的意志之树，举手投足\n都带动着天地灵力，被他盯上的人\n无一生还"					},
		{	name = "暗夜精灵防御塔4--风骑士古树",resource = "NEED   1000*TREES"	,content = "暗夜精灵族古老而神秘的种族--\n风骑士,风骑士古树则是风骑士团最\n具有智慧的数目,强大而神秘的魔法\n就是他们这一种族至今还能生存的\n根本所在"					},
		{	name = "暗夜精灵防御塔5--暗黑树精"	,resource = "NEED   1500*TREES"	,content = "从幽暗密林里走出来的邪恶树精，\n拥有着强大的魔法及极强的破坏能力，\n当你迷失深林深处的时候一定要当心\n一句话:\n”I CATCH YOU“ "					},
		{	name = "暗夜精灵防御塔6--暗影烈火"	,resource = "NEED   2000*TREES"	,content = "古老而强大的邪恶种族--暗影猎手，\n他们通过弄瞎自己的双眼来获得\n与恶魔交涉的机会从而变得无比强大，\n变身之后的暗影猎手会有超强的破坏\n能力及超音速的攻击速度，超越了\n恶魔的存在"					},
		
		{	name = "兽族防御塔1--弓箭塔"		,resource = "NEED   100*ORDERS"	,content = "兽人们用来防御的强力箭塔"					},
		{	name = "兽族防御塔2--兽栏"			,resource = "NEED   300*ORDERS"	,content = "兽人们躲起来并进行射击，\n可多重射击"					},
		{	name = "兽族防御塔3--投石车"		,resource = "NEED   700*ORDERS"	,content = "兽族强大的武器之一，\n破坏力极强，\n并附带范围性伤害"					},
		{	name = "兽族防御塔4--飞龙"			,resource = "NEED   1000*ORDERS",content = "兽人们通过与龙搏斗来俘获了\n凶险的飞龙为己所用，\n飞龙具有强大的破坏力，\n并具有范围性伤害自带毒物"					},
		{	name = "兽族防御塔5--牛头人"		,resource = "NEED   1500*ORDERS",content = "暗强大部落牛头人的酋长，\n具有范围性与毁灭性的高伤害，\n并且他的冲击破能达到巨大的范围"					},
		{	name = "兽族防御塔6--暗影猎手"		,resource = "NEED   2000*ORDERS",content = "纯粹的巫术，可以让敌人\n暂时变成动物并减速，\n闪电链具备破坏性伤害跟\n范围性巨伤害"					},
		
		{	name = "暗夜精灵防御塔1--通灵塔"	,resource = "NEED   100*TREES"	,content = "侍僧召唤出来的带着\n死气的幽灵建筑物"					},
		{	name = "暗夜精灵防御塔2--埋骨地"	,resource = "NEED   300*TREES"	,content = "带着死气的埋骨地，高破坏力\n以及有一定几率地将敌人拖入\n埋骨地"					},
		{	name = "暗夜精灵防御塔3--亡灵大厅"	,resource = "NEED   700*TREES"	,content = "侍僧召唤出来的王者大厅，高伤害\n而且有一定几率让敌人直接\n进入王者大厅"					},
		{	name = "暗夜精灵防御塔4--屠宰场"	,resource = "NEED   1000*TREES"	,content = "利用尸骨的尸气，高破坏能力\n以及尸气的剧毒而且还有\n一定几率直接秒杀"					},
		{	name = "暗夜精灵防御塔5--巫妖王"	,resource = "NEED   1500*TREES"	,content = "亡者里面的最强巫师，\n高破坏能力以及高必杀能力"					},
		{	name = "暗夜精灵防御塔6--不朽王座"	,resource = "NEED   2000*TREES"	,content = "极高的破坏能力以及极高的秒杀\n能力让它成为了恐怖的杀戮机器"					},
		


	}
		type_get = function()
		if ShData.getjlTDnumber() ~= nil  then
			return 1
		elseif ShData.getszTDnumber() ~= nil then
			return 2
		elseif ShData.getbsTDnumber() ~= nil then
			return 3
		else
			return -1
		end
	end

	for k,v in pairs (display_table) do 
		if  (ShData.getjlTDnumber() or ShData.getszTDnumber() or ShData.getbsTDnumber() ) + 6*(type_get() -1)  == k  then
			local TDname=cc.ui.UILabel.new({
				text=v.name,
				color=cc.c3b(250, 0, 0),
				size=25,
				})
	    	:align(display.CENTER, display.width/2+100, display.left+450)
	    	:addTo(anode,11)

	    	local TDmoney=cc.ui.UILabel.new({
	    		text=v.resource,
	    		color=cc.c3b(107,142,35),
	    		size=25,
	    		})
	    	:align(display.CENTER, display.cx+100, display.left+350)
	    	:addTo(anode,11)

	    	local TDstore=cc.ui.UILabel.new({
	    		text=v.content,
	    		color=cc.c3b(79,79,79),
	    		size=25,
	    		})
	    	:align(display.CENTER, display.cx+100, display.left+250)
	    	:addTo(anode,11)
		end
	end
end

function NewTDLayer:Buy()
	local type_table={

		{name="100"},
		{name="300"},
		{name="700"},
		{name="1000"},
		{name="1500"},
		{name="2000"},

}
	for k,v in pairs(type_table) do
		if (ShData.getjlTDnumber() or ShData.getszTDnumber() or ShData.getbsTDnumber())==k and cc.UserDefault:getInstance():getIntegerForKey("TREE")-v.name>0 then
			print("KIND:",v.name)
			print("shuzi",cc.UserDefault:getInstance():getIntegerForKey("TREE"))
			cc.UserDefault:getInstance():setIntegerForKey("TREE",cc.UserDefault:getInstance():getIntegerForKey("TREE")-v.name)
			local user=cc.UserDefault:getInstance():getIntegerForKey("TREE")
			tree_label:setString(user)
			Data3.LOCK[ShData.getShNum()][k].lock=0
			self:removeSelf()
			cc.Director:getInstance():replaceScene(StartScene.new())
		end

		if (ShData.getjlTDnumber() or ShData.getszTDnumber() or ShData.getbsTDnumber())==k and cc.UserDefault:getInstance():getIntegerForKey("TREE")-v.name<0 then
			local over=Defult.new()
			over:setPosition(cc.p(0,0))
			over:addTo(self)
		end
	end

		-- local over=Defult.new()
		-- over:setPosition(cc.p(0,0))
		-- over:addTo(self)
end


return NewTDLayer