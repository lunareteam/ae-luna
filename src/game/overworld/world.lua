local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj, inputObj, textObj, ended,nof)
  screen = screenObj
  player = playerObj
  input = inputObj
  text   = textObj

  -- world pos --
  world.posx=0
  jogo=1
  world.width=1600
  world.scene=1
  clker=0
  shoes=0
  endedNow = ended
  player.pause=0

  world.awake = false
  world.drawTransition = false

  changedScene = false

  world.walking = false
  floorImg = love.graphics.newImage("game/sprites/floor.png")
  houseImg = love.graphics.newImage("game/overworld/sprites/house.png")
  tree1Img = love.graphics.newImage("game/sprites/tree1.png")
  tree2Img = love.graphics.newImage("game/sprites/tree2.png")
  sunImg = love.graphics.newImage("game/sprites/sun.png")
  cloudImg = love.graphics.newImage("game/sprites/cloud.png")
  skyImg = love.graphics.newImage("game/sprites/sky.png")
  screen.parseAnimation("game/overworld/sprites/well.png", 160, 200, 4)
  screen.parseAnimation("game/overworld/sprites/gansozzz.png", 46, 128, 5)
  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 6)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 7)
  screen.parseAnimation("game/overworld/sprites/shop.png",800, 600, 8)
  screen.parseAnimation("game/overworld/sprites/vitrine.png",32, 32, 9)
  screen.parseAnimation("game/overworld/sprites/seller.png", 126, 126, 10)
  screen.parseAnimation("game/sprites/transition.png",800,600,11)
  screen.parseAnimation("game/overworld/sprites/uparrow.png", 32, 32, 12)
  scaleHouse = 1
  place = 160
  world.pong=nof
  set = false
  time = 0
  pressed = false
end
  

-- Function to draw score --
function world.draw()
  if world.scene==1 then
    love.graphics.draw(skyImg,0-world.posx*0.3,-150)
    love.graphics.draw(skyImg,1600-world.posx*0.3,-150,0,-1,1)
    screen.drawAnimation(7, 600-world.posx*0.2, 5)

    screen.drawAnimation(6, 650-world.posx*0.3, -160)
    for i=0, 20 do
      if i == 1 or i == 2 or i == 5 or i == 9 or i == 10 or i == 11 or i == 15 or i == 17 or i == 18 or i == 20 then
        treeImg = tree1Img
      else
        treeImg = tree2Img
      end

      love.graphics.draw(treeImg, i*100-world.posx, 600-floor-260)
    end
    love.graphics.draw(houseImg,800-world.posx,600-floor-(houseImg:getHeight()*scaleHouse)+(scaleHouse*90), 0, scaleHouse)
    screen.drawAnimation(4,800-world.posx+650,600-floor-200)
    screen.drawAnimation(5,800-world.posx+400,600-floor-128)

    for i=0, 14 do
      love.graphics.draw(floorImg, place*i-world.posx, 600-floor, 0, 0.38)
    end

    if (world.posx>=460 and world.posx<= 520) or (world.posx>=645 and world.posx<= 690) then
      screen.drawAnimation(12, player.posx+3, player.posy-160)
    end
  elseif world.scene==2 then
    screen.drawAnimation(8,0,0)
    if shoes==0 then
      screen.drawAnimation(9,400-16,300)
    end
    screen.drawAnimation(10, 450, 600-floor-126)

    if (world.posx<90) or (world.posx>=700 and world.posx<750) then
      screen.drawAnimation(12, player.posx+3, player.posy-160)
    end
  end
end
function world.update(dt)
  world.walking = false

  if screen.getLoop(5) == 1 and pressed and jogo==0 then
    world.drawTransition = true
  end
  if screen.getLoop(11)==1 and pressed and jogo==0 then
    loader.changeGame("pong")
    closer=1
  end

  if jogo==1 then
    world.walking = false 
    if world.scene==1 then
      if world.posx<590 and world.posx>535 then
        world.posx=535
      elseif world.posx<630 and world.posx>550 then
        world.posx=630

      end
      if input.isDown("return") or input.isGamepadDown("dpup") or input.getAxis(2)<0--[[input.getKey("return") --[[and 800-world.posx+400 < player.posx+150+46 and 800-world.posx+400 > player.posx-150 ]] then
        if world.posx>=460 and world.posx<= 520  then
          world.changeScene(2)
          world.posx=90
          player.posx=0
          world.width=800
        elseif world.posx>=645 and world.posx<= 690 then
          world.changeScene(2)
          world.posx=700
          world.width=800
        end
      end
          if screen.getLoop(5) == 1 and player.posx>404 then
            player.pause=1
            screen.parseAnimation("game/pong/sprites/gansostop.png",46,128,5)
            audio.playSFX("game/overworld/sfx/quak.ogg")
            pressed = true
            jogo=0
    
            if not changedScene then
              text.initialize()
              text.parser("game/overworld/script3.txt", 1)
              endedNow = false
              changedScene = true
            end
          end
    elseif world.scene==2 then
      if shoes == 0 and changedScene == false and world.posx>300 then
        player.pause=1
        text.initialize()
        text.parser("game/overworld/script2.txt", 1)
        endedNow = false
        changedScene = true
      elseif shoes==0 --[[and player.posx == 300-30]] and world.posx>300 then
        shoes = 1
        player.pause=0
      end

      if input.isDown("return") or input.getGamepadKey("dpup") or input.getAxis(2)<0 then
        if world.posx<90 then
          world.changeScene(1)
          world.posx=445
          player.posx=395
          world.width=1600
        elseif world.posx>700  then
          world.changeScene(1)

          world.posx=705
          player.posx=405
          world.width=1600
          if world.pong=='0' or world.pong==0 then
            player.pause=1
            if not pressed then
              world.awake = true

              screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
              screen.parseAnimation("game/overworld/sprites/gansoawaking.png", 46, 128, 5)
            end
          end
        end
      end
    end

    if player.pause==0 and((input.isDown("d") or input.isGamepadDown("dpright") or input.getAxis(1)>0) and world.posx<world.width-player.vely-player.width and ((not(world.posx==535 ))or (world.scene==2)))and not(world.pong=='0' and world.posx==705 and shoes==1 and world.scene==1 )then
      world.posx= (world.posx+player.vely*dt*60)
      if changed then
        changed = false
        screen.parseAnimation("game/overworld/sprites/andandor.png", 46, 126, 2)
        screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
        screen.parseAnimation("game/overworld/sprites/charjumpr.png", 46, 128, 3)
      end
      world.walking = true
    elseif player.pause==0 and ((input.isDown("a") or input.isGamepadDown("dpleft") or input.getAxis(1)<0) and ((world.posx>player.vely and( (not(world.posx==630) )or (world.scene==2)))or (world.scene==2)and not(world.pong=='0' and world.posx==705 and shoes==1 and world.scene==1 ))) then
      world.posx= (world.posx-player.vely*dt*60)
      if not changed then
        changed = true
        screen.parseAnimation("game/overworld/sprites/andandol.png", 46, 126, 2)
        screen.parseAnimation("game/overworld/sprites/stillL.png", 46, 126, 1)
        screen.parseAnimation("game/overworld/sprites/charjumpl.png", 46, 128, 3)
      end
      world.walking = true
    end
  end
 -- print(scene)
end

function world.changeScene(nof)
  world.scene = nof
  changedScene = false
end

return world
  