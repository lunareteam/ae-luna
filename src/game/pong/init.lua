--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --
local bar = require("game.pong.bar")
local ball = require("game.pong.ball")
local player = require("game.pong.player")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  audio.startBGM("game/pong/bgm/maintheme.ogg")

  treeImg = love.graphics.newImage("game/sprites/tree.png")
  player.initialize(screen, bar, ball)
  bar.initialize(screenObj, player)
  ball.initialize(screenObj, bar, player, audio)

  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 4)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 5)
end

-- Drawer --
function init.draw()
  -- Blue sky --
  love.graphics.setColor( 0,255,230,255)
  love.graphics.rectangle("fill", 0, 0, 800, 600)

  -- Normal colors --
  love.graphics.setColor( 255,255,255,255)

  screen.drawAnimation(5, 400, 5)
  screen.drawAnimation(4, 350, -160)
  for i=0, 5 do
    love.graphics.draw(treeImg, i*100, 600-floor-260)
  end
  bar.draw()
  ball.draw()
  player.draw()
end

-- Pong Updater --
function init.update()
  if player.score1 == 5 or love.keyboard.isDown('l') then
    player.score1 = 5
    loader.changeGame("flyganso", 2)
  elseif player.score2 == 5 or love.keyboard.isDown('k') then
    player.score2 = 5
    loader.gameover()
  end
  

  bar.update()
  ball.update()
  player.update()
end

-- Returns itself --
return init
