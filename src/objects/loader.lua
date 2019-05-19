--[[Game and objects loader]]--
-- Makes itself an object --
local loader = {}

-- Creates game object --
local game = {}

-- Initializer function --
function loader.initialize(screenObj, audioObj, inputObj)
  -- Loads main objects for the game --
  screen = screenObj
  audio = audioObj
  input = inputObj

  -- Starts the menu at the start --
  loader.changeGame("menu")
end

-- Returns game path --
function loader.gamePath()
  return "game." .. loader.game .. ".init"
end

function loader.gameover()
  audio.playSFX("game/text_txt/sfx/gameover.ogg")
  loader.changeGame("text_txt", 0)
end

-- Changes game object --
function loader.changeGame(name)
  loader.game = name
  game = require(loader.gamePath())
  game.initialize(screen, audio, input, loader)
end

-- Changes game object --
function loader.changeGame(name, nof)
  loader.game = name
  game = require(loader.gamePath())
  game.initialize(screen, audio, input, loader, nof)
end

-- Game's draw function --
function loader.draw()
  game.draw()
end

-- Game's update function --
function loader.update()
  game.update()
end

-- Returns itself --
return loader
