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
function ShScene:init()
	Shnumber=ShData.getShNum()
	-- if Shnumber==1 then
	-- 	print("jl")
	-- 	else if Shnumber==2 then
	-- 		print("sz")
	-- 	else
	-- 		print("bsz")
	-- 	end
	-- end
	-- local map=Shnumber.."-".."map"..".tmx"
	-- self.tiledMap=cc.TMXTiledMap:create(map)
	-- self.tiledMap:addTo(self)





end




















return ShScene