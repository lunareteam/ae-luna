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

  screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
end

-- Function to draw score --
function player.draw()
  if world.walking then
    screen.drawAnimation(2,player.posx, player.posy-player.height+10)
  else
    screen.drawAnimation(1,player.posx, player.posy-player.height+10)
  end
end

function player.update()
  if world.posx<400 then
    player.posx=world.posx
  elseif world.posx>1200 then
    player.posx=800-(1600-world.posx)
  end

  if love.keyboard.isDown("w") and player.posy>=430 then
    player.direction1=1

  elseif player.posy<=320 then
      player.direction1=0

  end

  print(600-floor-10-player.height," ", player.posy)
  if player.direction1==1 then
    -- This condition makes the player not pass the border limits --

    if player.posy>=600-floor+10-player.height then
      player.posy = player.posy - 10
    end
    -- l to go down as player 2 --
  else 

      if player.posy<=430-10 then
        player.posy = player.posy + 10
  
      end

  end
end

return player
