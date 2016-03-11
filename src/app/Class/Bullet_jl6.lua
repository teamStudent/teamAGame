--
-- Author: Your Name
-- Date: 2016-03-11 10:55:33
--
Bullet_jl6=class("Bullet_jl6", function()
	return display.newSprite("GameScene/bullet_jl.png")
end)

function Bullet_jl6:ctor()
	self.tag=100
	self.firepower=200
	self.isMove=false
end

return Bullet_jl6