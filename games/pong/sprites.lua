local sprites = {}

function sprites.initialize()
  -- Image init --
  bg = love.graphics.newImage("images/bg.png")
  bg.width = bg:getWidth()
  bg.height = bg:getHeight()
end

return sprites
