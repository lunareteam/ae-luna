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
  return "games." .. game.game .. ".init"
end

return game
