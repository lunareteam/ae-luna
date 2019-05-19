--[[Game and objects loader]]--
-- Makes itself an object --
local loader = {}

-- Initializer function --
function loader.initialize(screenObj, audioObj, inputObj)
  -- Loads main objects for the game --
  screen = screenObj
  audio = audioObj
  input = inputObj

  if love.filesystem.getInfo("settings") then
    settings = love.filesystem.read("settings")
    volPos = string.find(settings, "volume=", 1, true)
    fullscreenPos = string.find(settings, "fullscreen=", 1, true)
    audio.volume = tonumber(string.sub(settings, volPos+7, fullscreenPos-1))
    if string.sub(settings, fullscreenPos+11) == "true" then
      screen.toggleFullscreen()
    end
  end

  loader.game = "menu"

  -- Starts the menu at the start --
  loader.changeGame("menu")
end

-- Loads game from save --
function loader.loadGame()
  if love.filesystem.getInfo("save") then
    save = love.filesystem.read("save")
    gamePos  = string.find(save, "game=", 1, true)
    nofPos   = string.find(save, "nof=", 1, true)
    scenePos = string.find(save, "scene=", 1, true)
    game  = string.sub(save, gamePos+5, nofPos-2)
    nof   = string.sub(save, nofPos+4, scenePos-2)
    scene = string.sub(save, scenePos+6, save:len()-1)


    if nof == "\n" then
      loader.changeGame(game)
    elseif scene == "\n"  then
      loader.changeGame(game, nof)
    else
      loader.changeGame(game, nof, scene)
    end
  end
end

-- Saves settings --
function loader.saveSettings()
  love.filesystem.write("settings", "volume=" .. audio.volume .. "\nfullscreen=" .. tostring(screen.isFullscreen()))
end

-- Returns game path --
function loader.gamePath()
  return "game." .. loader.game .. ".init"
end

-- Gameover screen --
function loader.gameover()
  audio.playSFX("game/text_txt/sfx/gameover.ogg")
  loader.changeGame("text_txt", 0)

end

-- Saves game --
function loader.saveGame(name, nof, scene)
  if not (name == "menu") then
    if nof == nil then
      love.filesystem.write("save", "game=" .. name .. "\nnof=" .. "nil" .. "\nscene=" .. "nil")
    elseif scene == nil then
      love.filesystem.write("save", "game=" .. name .. "\nnof=" .. nof .. "\nscene=" .. "nil")
    else
      love.filesystem.write("save", "game=" .. name .. "\nnof=" .. nof .. "\nscene=" .. scene)
    end
  end
end

-- Changes game object --
function loader.changeGame(name)
  loader.saveGame(name)
  loader.game = name
  print(loader.gamePath())
  game = require(loader.gamePath())
  game.initialize(screen, audio, input, loader)

end

-- Changes game object --
function loader.changeGame(name, nof)
  loader.saveGame(name,nof)
  loader.game = name
  print(loader.gamePath())
  game = require(loader.gamePath())
  game.initialize(screen, audio, input, loader, nof)

end

-- Changes game object --
function loader.changeGame(name, nof, scene)
  loader.saveGame(name,nof,scene)
  loader.game = name
  game = require(loader.gamePath())
  game.initialize(screen, audio, input, loader, nof, scene)
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
