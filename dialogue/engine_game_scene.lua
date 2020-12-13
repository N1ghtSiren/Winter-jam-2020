game_scene = {}
local parentGroup_background = level_layers[0]
local parentGroup_text_background = level_layers[2]
local parentGroup_text = level_layers[3]

local currentScene = nil

local methods = {}
methods.__index = methods

function methods:destroy()
    self.background:removeSelf()
    self.textbg:removeSelf()
    self.text:removeSelf()

    indexer.remove("scenes", self)
    indexer.reset("chars")

    if(currentScene == self)then
        currentScene = nil
    end

    self = nil
end

function methods:showtextbg(flag)
    self.textbg.isVisible = flag
end

function methods:setText(text)
    self.text.text = textCutter(text, 135)
end

function methods:play()
    currentScene = self
    self:update()
end

function game_scene.new(id)
    local obj = scenedb.get(id)

    local canUpdate = true
    local function ontouch(event)
        if(event.phase~="began")then return end

        if(canUpdate)then
            obj:update()
            canUpdate = false
            timer.performWithDelay(1000, function()
                canUpdate = true
            end)

        end

        return true
    end

    obj.index = indexer.add("scenes", obj)

    obj.textbg = display.newRect(parentGroup_text_background, 0, 570, 1280, 150)
    obj.textbg.isVisible = true
    obj.textbg:setFillColor(0.3, 0.3, 0.3, 0.4)
    obj.textbg:addEventListener("touch", ontouch)

    obj.text = display.newText(parentGroup_text, "Тестовый диалог", 10, 580, fontMain, 30)
    
    setmetatable(obj, methods)
    obj:create()

    return obj
end

function game_scene.getCurrent()
    return currentScene or false
end