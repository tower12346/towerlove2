function love.load()
	Object = require "classic"
	local name = require "Player"
	local name = require "Enemy"
	love.keyboard.setKeyRepeat(false)
	players = {
		{
			Player(300, 300),
			Player(400, 400),
			Player(300, 400)
		}
	}
	enemies = {
		{
			Enemy(100, 100),
			Enemy(200, 200)
		}
	}
	playerphase = true
	lasttx = 1
	pindex = 1
	eindex = 1
	player = Player(1, 500)
	t = 0
end

function love.update(dt)
	t = t + dt
	if playerphase == false then
		while t>0.5 do
			if enemies[lasttx][eindex]:update(dt) then
				eindex = eindex + 1
			end

			if enemies[lasttx][eindex]==nil then
				eindex = 1
				pindex = 1
				playerphase = true
			end

			checkeverything()
			t = 0
		end
	end
end


function love.keypressed(key, scancode, isrepeat)
	if key=='0' then
		love.load()
	end

	if playerphase == false then
		return
	end

	if players[lasttx][pindex]:keypressed(key) then
		pindex = pindex + 1
	end

	if players[lasttx][pindex]==nil then
		pindex = 0
		playerphase = false
	end

	checkeverything()
end

function checkeverything()
	for i, v in ipairs (players[lasttx]) do
  	if players[lasttx][i]:isDead() then
			table.remove(players[lasttx], i)
		end
  end

	for i, v in ipairs (enemies[lasttx]) do
		if enemies[lasttx][i]:isDead() then
			table.remove(enemies[lasttx], i)
		end
	end
end

function love.draw()
  for i, v in ipairs (players[lasttx]) do
  	players[lasttx][i]:draw()
  end
	for i, v in ipairs (enemies[lasttx]) do
  	enemies[lasttx][i]:draw()
  end
end
