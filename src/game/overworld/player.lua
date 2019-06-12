--[[Player inside game]]--
-- Makes itself an object --
local player = {}

-- Initializer --
function player.initialize(screenObj,worldObj, audioObj, inputObj)
  screen = screenObj
  world = worldObj
  audio = audioObj
  input = inputObj

  -- Player pos --
  floor=160
  player.vely = 5
  player.direction1=0
  player.height = 128
  player.width = 46
  player.j=0
  player.posx= 400
  player.posy = 435

  player.jumping = false

  screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
  screen.parseAnimation("game/overworld/sprites/andandor.png", 46, 128, 2)
  screen.parseAnimation("game/overworld/sprites/charjumpr.png", 46, 128, 3)
end

-- Function to draw score --
function player.draw()
  if player.jumping then
    screen.drawAnimation(3,player.posx, player.posy-player.height+10)
  elseif world.walking then
    screen.drawAnimation(2,player.posx, player.posy-player.height+10)
  else
    screen.drawAnimation(1,player.posx, player.posy-player.height+10)
  end
end

function player.update(dt)
  --print(world.posx)
  if world.posx<400 then
    player.posx=world.posx
  elseif world.posx>world.width-400  then
    player.posx=800-(world.width-world.posx)
  end

  if (input.isDown("w") or input.isGamepadDown("a"))and player.posy>=435 then
    player.direction1=1
    player.jumping = true
  elseif player.posy<=320 then
    player.direction1=0
    player.jumping = false
  end


  if player.direction1==1 then
    -- This condition makes the player not pass the border limits --

    if player.posy>=600-floor-player.height then
      player.posy =  (player.posy - 500*dt)
    end
    -- l to go down as player 2 --
  else 

      if player.posy<=435 then
        player.posy =  (player.posy + 500*dt)
        if player.posy>435 then
          player.posy=435
        end
  
      end

  end
end

return player
