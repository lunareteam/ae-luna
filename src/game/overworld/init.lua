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
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  text = {}
  -- Calls objects --
  text = require("calls.text")
  
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj
  inFile = file
  

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
  if text ~= nil and not( text.ended(1,sceneNof-1) )then
    if sceneNof<contLines("game/overworld/script1.txt")-1 or(sceneNof==contLines("game/overworld/script1.txt")-1 and not(input.getKey("return") or input.getClick() or input.toggle("lctrl"))) then
      text.draw(sceneNof, 1, true)
      player.posx = 0
      scene=1
    elseif sceneNof==contLines("game/overworld/script1.txt")-1 then
      sceneNof=sceneNof+1
    end
  end
end
function contLines(string) 
  lines=0
  for line in love.filesystem.lines(string) do
    lines=lines+1
  end
  return lines
end
-- Pong Updater --
function init.update()

  if not (text.ended(1,sceneNof)) then


    -- Action to go to next scene with delay --arrumar issovvvvvvvvv
    if (input.getKey("return") or input.getClick() or (input.toggle("lctrl") and sceneNof<contLines("game/overworld/script1.txt"))and sceneNof<=contLines("game/overworld/script1.txt"))or sceneNof==contLines("game/overworld/script1.txt") then
      -- Ends game when script ends, else goes to next scene --
      if text.ended(1,sceneNof) then
        input.toggled = false
      elseif input.pressed == true and sceneNof<contLines("game/overworld/script1.txt")+1 then
        sceneNof = text.nextScene(sceneNof)
      end
    end
  end
  if text.ended(1,sceneNof-2) then
    player.update()
    world.update()

  end
end

-- Returns itself --
return init
