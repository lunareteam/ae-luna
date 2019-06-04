--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.overworld.player")
local world = require("game.overworld.world")

-- Calls objects --
local text = require("calls.text")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  text = {}
  -- Calls objects --
  text = require("calls.text")

  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  file = fileName
  sceneNof = 1

  audio.startBGM("game/text_txt/bgm/main.xm")

  text.initialize()
  player.initialize(screenObj, world, audio)
  world.initialize(screenObj, player)

  text.parser("game/overworld/script1.txt", 1)
end

-- Drawer --
function init.draw()
  world.draw()
  player.draw()

  if text ~= nil and not text.ended(1,sceneNof) then
    text.draw(sceneNof, 1, true)
  end
end

-- Pong Updater --
function init.update()
  if not text.ended(1,sceneNof) then
    player.posx = 0

    -- Action to go to next scene with delay --
    if input.getKey("return") or input.getClick() or input.toggle("lctrl") then
      -- Ends game when script ends, else goes to next scene --
      if text.ended(1,sceneNof) then
        input.toggled = false
      elseif input.pressed == true then
        print(sceneNof)
        sceneNof = text.nextScene(sceneNof)
      end
    end
  end

  if text.ended(1,sceneNof) then
    player.update()
    world.update()
  end
end

-- Returns itself --
return init
