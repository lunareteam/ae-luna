--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.flyganso.player")
local world = require("game.flyganso.world")
local goose = require("game.flyganso.goose")
local object = require("objects.object")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj,nof)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj
  audio.startBGM("game/text_txt/bgm/main.xm")

  player.initialize(screenObj, world, audio, input, goose, object)
  world.initialize(screenObj, player, input, goose)
  goose.initialize(screenObj, player,world, object)


  treeImg = love.graphics.newImage("game/sprites/tree1.png")
  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 4)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 6)
end

-- Drawer --
function init.draw()
  world.draw()
  player.draw()
  goose.draw()
  love.graphics.setColor( 0,255,0,255)
  love.graphics.rectangle("fill",(800/2)/2-10-30-90, 30, 20*(player.score1), 20)
  love.graphics.setColor( 255,0,0,255)
  love.graphics.rectangle( "fill", (800/2)+((800/2)/2)+50, 30, 20*(player.score2), 20 )
  love.graphics.setColor( 255,255,255,255)
end

-- Pong Updater --
function init.update()
  goose.update()
  player.update()
  world.update()

end

-- Returns itself --
return init
