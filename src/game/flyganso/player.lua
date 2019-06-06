--[[Player inside game]]--
-- Makes itself an object --
local player = {}

-- Initializer --
function player.initialize(screenObj,worldObj, audioObj, inputObj,gooseObj)
  screen = screenObj
  world = worldObj
  audio = audioObj
  goose = gooseObj
  input = inputObj

  -- Player pos --
  floor=160
  player.vely = 5
  player.direction1=0
  player.height = 128
  player.width = 46
  player.j=0
  player.posx= 400
  player.posy = 600-160-10
  player.score1=5
  player.score2=5
  player.jumping = false

  bulletPlayer = {nil, nil, nil, nil, nil, nil}
  n=1

  screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
  screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 2)
  screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 3)
end

-- Function to draw score --
function player.draw()
  if  not(player.posy==600-floor-10)  then
    screen.drawAnimation(3,player.posx, player.posy-player.height+10)
  elseif world.walking then
    screen.drawAnimation(2,player.posx, player.posy-player.height+10)
  else
    screen.drawAnimation(1,player.posx, player.posy-player.height+10)
  end

  for i=1, #bulletPlayer do
    --print("player",i, bulletPlayer[i])
    if bulletPlayer[i] ~= nil then
      bulletPlayer[i].draw()
    end
  end
end

function player.update()
  if input.getKey("return") then
    if bulletPlayer[n] == nil then
      bulletPlayer[n] = require("game.flyganso.bullet")
      bulletPlayer[n].initialize("player", player, goose)
    end

    --print(n)
    if n==6 then
      n=1
    else
      n = n+1
    end
  end

  for i=1, #bulletPlayer do
    if bulletPlayer[i] ~= nil then
      bulletPlayer[i].update()

      if bulletPlayer[i].hit() then
        player.score2 = player.score2-1
      end

      if bulletPlayer[i].hit() or bulletPlayer[i].outOfBounds() then
        bulletPlayer[i] = nil
      end
    end
  end

  if world.posx<400 then
    player.posx=world.posx
  elseif world.posx>400 then
    player.posx=800-(800-world.posx)
  end
  if input.isDown("w")then
    if player.posy-10 >= player.height then
      player.posy = player.posy - 10
    end
  elseif (input.isDown("s")) then
    if player.posy+15 <= 600-floor then
      player.posy = player.posy + 10
      if player.posy==306 then
        player.posy=312
      end
    end
  end
end

return player
