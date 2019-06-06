local text = {}

function text.initialize()
  line = 1

  -- Properties variables --
  alpha = 0       -- Alpha value
  fadeInTime = 0  -- Fade in timer

  file = {}

  textbox = love.graphics.newImage("game/bg/textbox.jpg")
end

-- Parser --
function text.parser(string, nof)
  -- Reads script and inserts into table --
  file[nof] = {scriptAll = {}, scriptImg = {}, scriptNames = {}, scriptText = {}}
  for line in love.filesystem.lines(string) do
    table.insert(file[nof].scriptAll, line)
  end
  
  -- Parses file --
  for i=1, #file[nof].scriptAll do
    pos = string.find(file[nof].scriptAll[i], ":", 1, true)
    if not(pos == nil) then
      table.insert(file[nof].scriptNames, string.sub(file[nof].scriptAll[i], 1, pos-1) )
      file[nof].scriptAll[i] = string.sub(file[nof].scriptAll[i], pos+1)
    end
    pos = string.find(file[nof].scriptAll[i], ":", 1, true)
    if not(pos == nil) then
      table.insert(file[nof].scriptText, string.sub(file[nof].scriptAll[i], 1, pos-1) )
      file[nof].scriptAll[i] = string.sub(file[nof].scriptAll[i], pos+1)
    else
      table.insert(file[nof].scriptText, string.sub(file[nof].scriptAll[i], 1) )
    end

  end
end

function text.string(nof, nof2)
  return file[nof].scriptAll[nof2]
end

function text.names(nof, nof2)
  return file[nof].scriptNames[nof2]
end

function text.textScr(nof, nof2)
  return file[nof].scriptText[nof2]
end

function text.ended(nof,line)

  print(#file[nof].scriptAll, line)
  if #file[nof].scriptText == line+1 then

    return true
  end
  return false
end

function text.draw(line, nof, up)
  if up then
    pos = 0.5
  else
    pos = 3
  end

  -- Draw textbox --
  love.graphics.draw(textbox, 800*0.05, 600/2/2*pos-30, 0, 1)

  -- Draws vn text --
  if not (file[nof].scriptNames[line] == "nil") then
    love.graphics.print({{255, 0, 0,alpha},file[nof].scriptNames[line]}, 800*0.075, 600/2/2*pos-10, 0, 0.3)

  end

  love.graphics.printf({{0, 0, 0,alpha}, file[nof].scriptText[line]}, 800*0.25, 600/2/2*pos-10, 1400, "center", 0, 0.3)

  text.fadeIn()
  
  -- Draws text space and prints text asking for input --
  if up then
    love.graphics.print({{0, 255, 0, 1},"<Press Return>"}, 800-185, textbox:getHeight()+10, 0, 0.3)
  else
    love.graphics.print({{0, 255, 0, 1},"<Press Return>"}, 800-185, 600-80, 0, 0.3)
  end
end

-- Goes to next scene --
function text.nextScene(line)
  line=line+1         -- Goes to next scene
  alpha = 0             -- Resets alpha value
  return line
end

-- Fades text --
function text.fadeIn()
  if love.timer.getTime() <= fadeInTime+0.35 then
    alpha = alpha+0.05
  else
    fadeInTime = love.timer.getTime()
  end
end

return text