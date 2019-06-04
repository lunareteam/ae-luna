--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.overworld.player")
local world = require("game.overworld.world")
local text= require("calls.text")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj,file)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj
  inFile = file
  

  audio.startBGM("game/text_txt/bgm/main.xm")

  player.initialize(screenObj, world, audio)
  world.initialize(screenObj, player)
  text.initialize()
  text.parser("game/overworld/script1.txt", 1)
  scene=1
end

-- Drawer --
function init.draw()
  world.draw()
  player.draw()
  if text ~= nil then
    if not text.ended(1) then
      text.draw(scene,1,true)
    end
  end 
end

-- Pong Updater --
function init.update()
  player.update()
  world.update()

  if text ~= nil then
    -- Action to go to next scene with delay --
    if input.getKey("return") or input.getClick() or input.toggle("lctrl") then
      -- Ends game when script ends, else goes to next scene --
      if (text.ended(1)) then
        text = nil

      elseif input.pressed == true then
        scene = text.nextScene(scene)
        print()
      end
    end
  end
end

-- Returns itself --
return init
