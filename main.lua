function love.load()
	Object = require "classic"
	local name = require "Player"
	love.keyboard.setKeyRepeat(false)
	tilemap2d = {
		{
			Player(300, 300),
			Player(400, 400),
			Player(300, 400)
		}
	}
	lasttx = 1
	pindex = 1
	player = Player(1, 500)
end

--function love.update(dt)
function love.keypressed(key, scancode, isrepeat)
	if key=='0' then
		love.load()
	end

	if tilemap2d[lasttx][pindex]:keypressed(key) then
		pindex = pindex + 1
	end

	if tilemap2d[lasttx][pindex]==nil then
		pindex = 1
	end

	for i, v in ipairs (tilemap2d[lasttx]) do
  	if tilemap2d[lasttx][i]:isDead() then
			table.remove(tilemap2d[lasttx], i)
		end
  end

end

function love.draw()
  for i, v in ipairs (tilemap2d[lasttx]) do
  	tilemap2d[lasttx][i]:draw()
  end
end
