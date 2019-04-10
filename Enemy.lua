Enemy = Object:extend()

function Enemy:new(x1, y1)
	self.x = x1
	self.y = y1
	self.maxrange = 3
	self.range = self.maxrange
	self.w = 20
	self.h = 20
	self.hp = 100
	--self.sprite = love.graphics.newImage("Butterfly.png")
	self.powers = {

	}
end

function Enemy:update(dt)
	self.x = self.x + 20
	self.range=self.range-1
	if self.range<=0 then
		self.range = self.maxrange
		return true
	end
	return false
end

function Enemy:keypressed(key)
	if key=="w" then
		self.y = self.y-20
	elseif key=="a" then
		self.x = self.x-20
	elseif key=="s" then
		self.y = self.y+20
	elseif key=="d" then
		self.x = self.x+20
	else
		self.range = self.range+1
	end
	self.range=self.range-1
	if self.range<=0 then
		self.range = self.maxrange
		return true
	end
	return false
end

function Enemy:isDead()
	return self.hp<=0
end

function Enemy:draw()
	love.graphics.setColor(1, 1, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	--love.graphics.draw(self.sprite, self.x, self.y, 0, self.w/self.sprite:getWidth(), self.h/self.sprite:getHeight())
end
