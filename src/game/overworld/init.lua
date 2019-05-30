--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.overworld.player")
local world = require("game.overworld.world")

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
end

-- Drawer --
function init.draw()
  player.draw()
  world.draw()
end

-- Pong Updater --
function init.update()
  player.update()
  world.update()

  if input.getKey("return") then
    loader.changeGame("pong")
  end
end

-- Returns itself --
return init
