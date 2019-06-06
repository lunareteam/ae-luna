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

  audio.startBGM("game/pong/bgm/maintheme.wav")

  tree1Img = love.graphics.newImage("game/sprites/tree1.png")
  tree2Img = love.graphics.newImage("game/sprites/tree2.png")
  skyImg = love.graphics.newImage("game/sprites/sky.png")
  player.initialize(screen, bar, ball)
  bar.initialize(screenObj, player)
  ball.initialize(screenObj, bar, player, audio)

  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 4)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 5)
end

-- Drawer --
function init.draw()
  love.graphics.draw(skyImg,0,-150)

  screen.drawAnimation(5, 400, 5)
  screen.drawAnimation(4, 350, -160)
  for i=0, 5 do
    if i == 1 or i == 3 or i == 5 then
      treeImg = tree1Img
    else
      treeImg = tree2Img
    end

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
    loader.changeGame("text_txt", 2)
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
