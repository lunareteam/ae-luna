--[[Player inside game]]--
-- Makes itself an object --
local player = {}
-- Initializer --
function player.initialize(screenObj,worldObj, audioObj, inputObj, gooseObj, nof)
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
  pao = {}
  paes = 0
  for i=1,3,1 do
    pao[i]={x=nil,y=nil}
  end
  
  if nof==nil then
    player.score1=5
  else
    player.score1=nof
  end
  player.score2=5
  player.jumping = false

  bulletPlayer = {nil, nil, nil, nil, nil, nil}
  n=1

  screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
  screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 2)
  screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 3)
  screen.parseAnimation("game/flyganso/sprites/pao .png", 32, 20, 11)
 
end


-- Function to draw score --
function player.draw()
  for i=1,3,1 do
    if pao[i].x ~= nil and pao[i].y~=nil then
        screen.drawAnimation(11, pao[i].x, pao[i].y)
    end
  end
  if  not(player.posy==600-floor-10)  then
    screen.drawAnimation(3,player.posx, player.posy-player.height+10)
  elseif world.walking then
    screen.drawAnimation(3,player.posx, player.posy-player.height+10)
  else
    screen.drawAnimation(3,player.posx, player.posy-player.height+10)
  end
end
function paokill()
  for i=1,3,1 do
      if pao[i].x~=nil and pao[i].y~= nil then
          if pao[i].x>800  or pao[i].y>600 or  pao[i].y<0 then
              pao[i].x=nil
              --paes=paes-1
              pao[i].y=nil
              if i==1 then
                pao[i].x=pao[i+1].x
                pao[i].y=pao[i+1].y
                pao[i+1].x=pao[i+2].x
                pao[i+1].y=pao[i+2].y
                pao[i+2].x=nil
                pao[i+2].y=nil
                elseif i==2 then
                  pao[i].x=pao[i+1].x
                  pao[i].y=pao[i+1].y
                  pao[i+1].x=nil
                  pao[i+1].y=nil
        
                else
                  pao[i].x=nil
                  pao[i].y=nil
                end
          elseif pao[i].x<goose.posx+goose.width and pao[i].x>goose.posx and pao[i].y>goose.posy and  pao[i].y<goose.posy+goose.height then
              player.score2=player.score2-1
              if i==1 then
              pao[i].x=pao[i+1].x
              pao[i].y=pao[i+1].y
              pao[i+1].x=pao[i+2].x
              pao[i+1].y=pao[i+2].y
              pao[i+2].x=nil
              pao[i+2].y=nil
              elseif i==2 then
                pao[i].x=pao[i+1].x
                pao[i].y=pao[i+1].y
                pao[i+1].x=nil
                pao[i+1].y=nil
      
              else
                pao[i].x=nil
                pao[i].y=nil
              end
              --paes=paes-1
          end
      end
  end

  for i=1, #bulletPlayer do
    --print("player",i, bulletPlayer[i])
    if bulletPlayer[i] ~= nil then
      bulletPlayer[i].draw()
    end
  end
end

function paoSpawn(paes)
  if paes<4 then
        pao[paes]={x=player.posx+player.width,y=player.posy-80}

          screen.parseAnimation("game/flyganso/sprites/charpao.png", 46, 128, 3)

        --paes=paes+1
  end
end
function paocont(paes)
  paes=1
  for i=1,3,1 do
 
    if pao[i].x~=nil or pao[i].y~= nil then
       paes=paes+1
        
    end
  end
  return paes
end
function player.update()
  paokill()
  
  if input.getKey("return") or input.getGamepadKey("a") then
    paes=paocont(paes)
    --print (paes)
    paoSpawn(paes)
  elseif( (not love.keyboard.isDown("return") or input.getGamepadKey("a")) or paes==3 )and screen.getLoop(3)==1 then
    screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 3)
  end

  for i=1,3,1 do
    if pao[i].x~=nil and pao[i].y~= nil then
        pao[i].x=pao[i].x+5
    end
  end
  if world.posx<400 then
    player.posx=world.posx
  elseif world.posx>400 then
    player.posx=800-(800-world.posx)
  end
  if input.isDown("w") or input.isGamepadDown("dpup") then
    if player.posy-10 >= player.height then
      player.posy = player.posy - 10
    end
  elseif (input.isDown("s") or input.isGamepadDown("dpdown")) then
    if player.posy+15 <= 600-floor then
      player.posy = player.posy + 10
      if player.posy==306 then
        player.posy=312
      end
    end
  end
end

return player
