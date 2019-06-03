--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.flyganso.player")
local world = require("game.flyganso.world")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  audio.startBGM("game/text_txt/bgm/main.xm")

  player.initialize(screenObj, world, audio)
  world.initialize(screenObj, player)

  treeImg = love.graphics.newImage("game/sprites/tree.png")
  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 4)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 6)
end

-- Drawer --
function init.draw()
    -- Blue sky --
    love.graphics.setColor( 0,255,230,255)
    love.graphics.rectangle("fill", 0, 0, 800, 600)
  
    -- Normal colors --

  world.draw()
  player.draw()
end

-- Pong Updater --
function init.update()
  player.update()
  world.update()
end

-- Returns itself --
return init
