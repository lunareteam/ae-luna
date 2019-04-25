local game ={}

function game.initialize()
  game.game = nil
end

function game.name()
  return game.game
end

function game.newGame(name)
  game.game = name
end

function game.path()
  if game.name() == not nil then
    return "games." .. game.game .. ".init"
  else
    return "games.menu.init"
  end
end

return game
