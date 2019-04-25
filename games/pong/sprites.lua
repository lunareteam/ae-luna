local sprites = {}

function sprites.initialize()

end

function sprites.load()
  -- Image init --
  bg = love.graphics.newImage("images/bg.png")
  bg.width = bg:getWidth()
  bg.height = bg:getHeight()
end

return sprites
