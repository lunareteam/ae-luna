local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj)
  screen = screenObj
  player = playerObj

  -- world pos --
  world.posx=0
  jogo=1
  world.width=1600
  world.scene=1
  shoes=0

  world.walking = false
  floorImg = love.graphics.newImage("game/sprites/floor.png")
  houseImg = love.graphics.newImage("game/overworld/sprites/house.png")
  treeImg = love.graphics.newImage("game/sprites/tree.png")
  sunImg = love.graphics.newImage("game/sprites/sun.png")
  cloudImg = love.graphics.newImage("game/sprites/cloud.png")
  screen.parseAnimation("game/overworld/sprites/well.png", 160, 200, 4)
  screen.parseAnimation("game/overworld/sprites/gansozzz.png", 46, 128, 5)
  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 6)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 7)
  screen.parseAnimation("game/overworld/sprites/shop.png",800, 600, 8)
  screen.parseAnimation("game/overworld/sprites/vitrine.png",32, 32, 9)
  scaleHouse = 1
  place = 160
  world.pong=0
  set = false
  time = 0
  pressed = false
end
  

-- Function to draw score --
function world.draw()
  if world.scene==1 then
    -- Blue sky --
    love.graphics.setColor( 0,255,230,255)
    love.graphics.rectangle("fill", 0, 0, 800, 600)

    -- Normal colors --
    love.graphics.setColor( 255,255,255,255)

    screen.drawAnimation(7, 600-world.posx*0.2, 5)
    screen.drawAnimation(6, 650-world.posx*0.3, -160)
    for i=0, 20 do
      love.graphics.draw(treeImg, i*100-world.posx, 600-floor-260)
    end
    love.graphics.draw(houseImg,800-world.posx,600-floor-(houseImg:getHeight()*scaleHouse)+(scaleHouse*90), 0, scaleHouse)
    screen.drawAnimation(4,800-world.posx+650,600-floor-200)
    screen.drawAnimation(5,800-world.posx+400,600-floor-128)

    for i=0, 14 do
      love.graphics.draw(floorImg, place*i-world.posx, 600-floor, 0, 0.38)
    end
  elseif world.scene==2 then
    screen.drawAnimation(8,0,0)
    if shoes==0 then
      screen.drawAnimation(9,400-16,300)
    end
  end
end
  
function world.update()
  world.walking = false
  if scene==1 then
    if love.keyboard.isDown("return")--[[input.getKey("return") --[[and 800-world.posx+400 < player.posx+150+46 and 800-world.posx+400 > player.posx-150 ]] then
      --[[if not pressed then
       --[[ screen.parseAnimation("game/overworld/sprites/gansoawaking.png", 46, 128, 5)
        audio.playSFX("game/overworld/sfx/quak.ogg")
          --pressed = true
      end]]

      if world.posx>=460 and world.posx<= 520  then
        scene=2
        world.posx=0
        player.posx=0
        world.width=800
      end
    end
  elseif scene==2 then
    if input.getKey("return") then
      if world.posx<90 and world.posx>0 then
        scene=1
        world.posx=445
        player.posx=395
        world.width=1600
      end
    end
  end
  if screen.getLoop(5) == 1 and pressed and jogo==0 then
        loader.changeGame("pong")
        closer=1
  end

  if jogo==1 then
    world.walking = false
    if world.scene==1 then
      if love.keyboard.isDown("return")--[[input.getKey("return") --[[and 800-world.posx+400 < player.posx+150+46 and 800-world.posx+400 > player.posx-150 ]] then
        if world.posx>=460 and world.posx<= 520  then
          world.scene=2
          world.posx=0
          player.posx=0
          world.width=800
        elseif world.posx>=645 and world.posx<= 690 then
          world.scene=2
          world.posx=750
          player.posx=750
          world.width=800
        end
      end
    elseif world.scene==2 then
      if love.keyboard.isDown("return") then
        if world.posx<90 and world.posx>0 then
          world.scene=1
          world.posx=445
          player.posx=395
          world.width=1600
        elseif world.posx>=700 and world.posx<750 then
          world.scene=1
          world.posx=705
          player.posx=405
          world.width=1600
          if world.pong==0 then
            if not pressed then
              screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
              screen.parseAnimation("game/overworld/sprites/gansoawaking.png", 46, 128, 5)
              audio.playSFX("game/overworld/sfx/quak.ogg")
              pressed = true
              jogo=0
            end
          end
        end
      end
    end
    if love.keyboard.isDown("d") and world.posx<world.width-player.vely-player.width and ((not(world.posx==535 ))or (world.scene==2))then
      world.posx=world.posx+player.vely
      if changed then
        changed = false
        screen.parseAnimation("game/overworld/sprites/andandor.png", 46, 126, 2)
        screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
        screen.parseAnimation("game/overworld/sprites/charjumpr.png", 46, 128, 3)
      end
      world.walking = true
    elseif love.keyboard.isDown("a") and world.posx>player.vely and( (not(world.posx==645) )or (world.scene==2))then
      world.posx=world.posx-player.vely
      if not changed then
        changed = true
        screen.parseAnimation("game/overworld/sprites/andandol.png", 46, 126, 2)
        screen.parseAnimation("game/overworld/sprites/stillL.png", 46, 126, 1)
        screen.parseAnimation("game/overworld/sprites/charjumpl.png", 46, 128, 3)
      end
      world.walking = true
    end
  end
end

return world
  