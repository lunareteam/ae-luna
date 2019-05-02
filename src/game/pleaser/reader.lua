--[[The visual novel story]]--
-- Makes itself an object --
local reader = {}

function reader.initialize(nof)
  scene = nof
  scriptStr, scriptSize = love.filesystem.read("game/pleaser/script.txt")
  iteratedScript = {}
  reader.iterate()
end

function reader.iterate()
  
end

function reader.nextScene()
  scene=scene+1
  print("scene: " .. scene)
end

function reader.draw()
  love.graphics.print(iteratedScript[scene], 800*0.07, 600/2/2*3-10, 0, 1.2)
end

return reader
