--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.overworld.player")
local world = require("game.overworld.world")
local text= require("calls.text")

-- Calls objects --
local text = require("calls.text")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj,nof)
  text = {}
  -- Calls objects --
  text = require("calls.text")
  
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj
  inFile = file
  pong=nof
  endedNow = false

  file = fileName
  sceneNof = 1

  audio.startBGM("game/text_txt/bgm/main.xm")

  text.initialize()
  player.initialize(screenObj, world, audio, input)
  world.initialize(screenObj, player, input, text, endedNow,pong)

  text.parser("game/overworld/script1.txt", 1)

  player.posx = 0
end

-- Drawer --
function init.draw()
  world.draw()
  player.draw() 
  if text ~= nil then
    if not(text.ended(1,sceneNof)) and not endedNow then
      text.draw(sceneNof, 1, true)
    elseif world.drawTransition then
      screen.drawAnimation(11,0,0)
    end
  end
end

-- Pong Updater --
function init.update(dt)
  if not endedNow then
    -- Action to go to next scene with delay --arrumar issovvvvvvvvv
    if input.getKey("return") or input.getGamepadKey("a") or input.getClick() or input.toggle("lctrl") or input.toggleGamepad("x") then
      -- Ends game when script ends, else goes to next scene --
      if text.ended(1,sceneNof) then
        input.toggled = false
      elseif input.pressed == true then
        sceneNof = text.nextScene(sceneNof)
      end
    end

    if text.ended(1, sceneNof) then
      input.toggled = false
      sceneNof = 1
      endedNow = true
    end
  else
    player.update(dt)
    world.update(dt)
  end
end

-- Returns itself --
return init
