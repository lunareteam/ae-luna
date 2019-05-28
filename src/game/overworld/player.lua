--[[Player inside game]]--
-- Makes itself an object --
local player = {}

-- Initializer --
function player.initialize(screenObj,worldObj, audioObj)
  screen = screenObj
  world = worldObj
  audio = audioObj

  -- Player pos --
  floor=160
  player.vely = 5
  player.direction1=0
  player.height = 128
  player.width = 46
  player.j=0
  player.posx= 400
  player.posy = 600-160-10
end

-- Function to draw score --
function player.draw()
  love.graphics.rectangle("line",player.posx, player.posy-player.height+5, player.width, player.height)
end

function player.update()
  if world.posx<400 then
    player.posx=world.posx
  elseif world.posx>1200 then
    player.posx=800-(1600-world.posx)
  end

  if love.keyboard.isDown("w") and player.posy>=600-player.height-floor then
    player.direction1=1
  else
    player.direction1=0
  end


  if player.direction1==1 then
    -- This condition makes the player not pass the border limits --
    if player.posy-10 >= 0 then
      player.posy = player.posy - 10
      
    end

    -- l to go down as player 2 -- 
    -- This condition makes the player not pass the border limits --
  elseif player.posy+player.height+10 <= 600-floor then
    player.posy = player.posy + 10
  end
end

return player
