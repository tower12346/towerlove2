Player = Object:extend()

function Player:new(x1, y1)
	self.x = x1
	self.y = y1
	self.maxrange = 3
	self.range = self.maxrange
	self.w = 20
	self.h = 20
	self.hpmax = 100
	self.hp = self.hpmax
	self.hph = 2
	--self.sprite = love.graphics.newImage("Butterfly.png")
	self.powers = {

	}
	self.isPlayer = true
	self.tx = lasttx
	worlds[self.tx]:add(self, self.x,self.y, self.w, self.h)
end

function Player:keypressed(key)
	local goalX, goalY= self.x, self.y
	if key=="w" then
		goalY = goalY-20
	elseif key=="a" then
		goalX = goalX-20
	elseif key=="s" then
		goalY = goalY+20
	elseif key=="d" then
		goalX = goalX+20
	else
		self.range = self.range+1
	end
	self.range=self.range-1

	local actualX, actualY, cols, len = worlds[self.tx]:move(self, goalX, goalY)
	self.x, self.y = actualX, actualY

	for i,v in ipairs (cols) do
		if cols[i].other.isEnemy then
	    cols[i].other:ouch(20)
		end
	end

	if self.range<=0 then
		self.range = self.maxrange
		return true
	end
	return false
end

function Player:isDead()
	return self.hp<=0
end

function Player:ouch(o)
	self.hp = self.hp - o
end

function Player:draw()
	if players[lasttx][pindex] == self then
		love.graphics.setColor(0, 1, 1)
	else
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y + self.h - self.hph, self.w, self.hph)
	love.graphics.setColor(1-self.hp/self.hpmax, self.hp/self.hpmax, 0)
	love.graphics.rectangle("fill", self.x, self.y + self.h - self.hph, self.w*(self.hp/self.hpmax), self.hph)
	--love.graphics.draw(self.sprite, self.x, self.y, 0, self.w/self.sprite:getWidth(), self.h/self.sprite:getHeight())
end
