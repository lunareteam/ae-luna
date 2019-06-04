--[[The visual novel based part of the game]]--
-- Makes itself an object --
local vn = {}

-- Calls objects --
local text = require("calls.text")

-- Initializer function --
function vn.initialize(screenObj, audioObj, inputObj, loaderObj, file)
  -- Loads called objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj
  -- Properties variables --
  alpha = 0       -- Alpha value
  fadeInTime = 0  -- Fade in timer
  inFile = file
  game1=0

  textbox = love.graphics.newImage("game/bg/textbox.jpg")

  -- Song initializer
  audio.startBGM("game/text_txt/bgm/main.xm")

  scene = 1

  if love.filesystem.getInfo("game/text_txt/va/"..file.."/"..scene..".ogg") then
    audio.playSFX("game/text_txt/va/"..file.."/"..scene..".ogg")
  end

  -- Initializes script reader --
  text.initialize()
  text.parser("game/text_txt/script".. file ..".txt", 1)
end

-- VN's draw function --
function vn.draw()
  -- Blue sky --
  love.graphics.setColor( 0,255,230,255)
  love.graphics.rectangle("fill", 0, 0, 800, 600)

  -- Normal colors --
  love.graphics.setColor( 255,255,255,255)

  --[[ Draws characters ]]--
  -- Draw Chars --
  if not(char1 == nil) then
    love.graphics.draw(char1, 800/2/2/2/2 , 600/2/2/2, 0, 0.3)
  end
  if not(char2 == nil) then
    love.graphics.draw(char2, 800/2/2/2*2+800/2/2/2/2 , 600/2/2/2, 0, 0.3)
  end

  text.draw(scene, 1)
end

-- VN's update function --
function vn.update()
  -- Action to go to next scene with delay --
  if input.getKey("return") or input.getClick() or input.toggle("lctrl") then
    -- Ends game when script ends, else goes to next scene --
    if text.ended(1,scene) then
      input.toggled = false
      audio.stopBGM()
      action = loadstring(text.string(1,scene+1))
      action()
    elseif input.pressed == true then
      scene = text.nextScene(scene)

      if love.filesystem.getInfo("game/text_txt/va/"..inFile.."/"..scene..".ogg") then
        audio.playSFX("game/text_txt/va/"..inFile.."/"..scene..".ogg")
      end
      
      -- Parse chars --
      pos = string.find(text.string(1,scene), ",", 1, true)
      if pos ~= nil then
        if not(string.sub(text.string(1,scene), 1, pos-1) == "nil") then
          char1 = love.graphics.newImage("game/text_txt/chars/" .. string.sub(text.string(1,scene), 1, pos-1).. ".png")
        else
          char1 = nil
        end
        if not(string.sub(text.string(1,scene), pos+1) == "nil") then
          char2 = love.graphics.newImage("game/text_txt/chars/" .. string.sub(text.string(1,scene), pos+1).. ".png")
        else
          char2 = nil
        end
      end
    end
  end
end

-- Returns itself --
return vn