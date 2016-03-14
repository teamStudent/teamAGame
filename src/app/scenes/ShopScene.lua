--
-- Author: Your Name
-- Date: 2016-03-09 14:32:26
--
local ShopScene=class("ShopScene", function()
	return display.newScene("ShopScene")
end)

function ShopScene:ctor()
	self:init()
end

function ShopScene:init()

	local tb = Data3.LOCK


	local bg=display.newSprite("bg.png")
	bg:pos(display.width/2, display.height/2)
	bg:addTo(self)

    self.layer=display.newColorLayer(cc.c4b(105,105,105,0))
    self.layer:setAnchorPoint(cc.p(0,0))
    self.layer:pos(0,0)
    self.layer:setContentSize(cc.size(display.width*2, display.height*4/5))


	self.scall=cc.ScrollView:create(cc.size(display.width, display.height*4/5),self.layer)
	self.scall:setDirection(0)
	self.scall:addTo(self)

	local tree=display.newSprite("tree.png")
	tree:pos(display.left+50, display.height-50)
	tree:setScale(0.5)
	tree:addTo(self)

	tree_label=cc.ui.UILabel.new({
		text=cc.UserDefault:getInstance():getIntegerForKey("TREE"),
		color=cc.c3b(200, 200, 50),
		size=20,
		})
	:align(display.CENTER, display.left+150, display.height-50)
	:addTo(self)


	local jl=display.newSprite("jl1.png")
	jl:setPosition(cc.p((display.left+display.cx)/2-120, display.cy+150))
	jl:setScale(0.2)
	jl:addTo(self.scall)

	local sz=display.newSprite("sz1.png")
	sz:setPosition(cc.p((display.left+display.cx)/2-120, display.cy))
    sz:setScale(0.2)
    sz:addTo(self.scall)

    local bs=display.newSprite("dead1.png")
    bs:setPosition(cc.p((display.left+display.cx)/2-120, display.cy-150))
    bs:setScale(0.2)
    bs:addTo(self.scall)

    local close=cc.ui.UIPushButton.new({normal="ChooseLayer/close.png",pressed="ChooseLayer/close.png"}, {scale9=true})
	           :onButtonClicked(function()
	           	display.replaceScene(StartScene:new(),"FadeBL",1.5)
	           	end)
	           :pos(display.width-50, display.height-50)
	           :setScale(0.5)
	           :addTo(self)


	for i=1,6 do
	if Data3.LOCK[ShData.getShNum()][i].lock==0 then
		print("jlLock",Data3.LOCK[ShData.getShNum()][i].lock)
		local jlspr = display.newSprite(Data2.getSpData(i).pic)
		jlspr:setPosition(cc.p((display.left+display.cx)/2-50+(i-1)*display.cx*2/3, display.cy+100))
		jlspr:setScale(0.4)
		jlspr:addTo(self.scall)
	else
		print("jlLock",Data3.LOCK[ShData.getShNum()][i].lock)
		local jlsp=cc.ui.UIPushButton.new({normal=Data2.getSpData(i).pic},{scale9=true})
		jlsp:onButtonClicked(function()
			ShData.setjlTDnumber(i)
			ShData.setszTDnumber(nil)
			ShData.setbsTDnumber(nil)
			print("JLTDNUMBER",ShData.getjlTDnumber())
			print("SZTDNUMBER",ShData.getszTDnumber())
			local jl_layer=NewTDLayer.new()
			jl_layer:setPosition(cc.p(0,0))
			jl_layer:addTo(self,10)
			end)
		jlsp:setPosition(cc.p((display.left+display.cx)/2-50+(i-1)*display.cx*2/3, display.cy+100))
		jlsp:setScale(0.4)
		jlsp:addTo(self.scall)
	end
	end


	for i=1,6 do
		local szsp=cc.ui.UIPushButton.new({normal=Data2.getSZData(i).pic},{scale9=true})
		szsp:onButtonClicked(function()
			ShData.setszTDnumber(i)
			ShData.setjlTDnumber(nil)
			ShData.setbsTDnumber(nil)
			print("JLTDNUMBER",ShData.getjlTDnumber())
			print("SZTDNUMBER",ShData.getszTDnumber())
			local sz_layer=NewTDLayer.new()
			sz_layer:setPosition(cc.p(0,0))
			sz_layer:addTo(self,10)
			end)
		szsp:setPosition(cc.p((display.left+display.cx)/2-50+(i-1)*display.cx*2/3, display.cy-50))
		szsp:setScale(0.5)
		szsp:addTo(self.scall)
	end

	for i=1,6 do
		local bssp=cc.ui.UIPushButton.new({normal=Data2.getBSData(i).pic},{scale9=true})
		bssp:onButtonClicked(function()
			ShData.setbsTDnumber(i)
			ShData.setjlTDnumber(nil)
			ShData.setszTDnumber(nil)
            print("BSTDNUMBER",ShData.getbsTDnumber())
            local bs_layer=NewTDLayer.new()
			bs_layer:setPosition(cc.p(0,0))
			bs_layer:addTo(self,10)
		end)
		bssp:setPosition(cc.p((display.left+display.cx)/2-50+(i-1)*display.cx*2/3, display.cy-200))
		bssp:setScale(0.6)
		bssp:addTo(self.scall)
	end




end



return ShopScene