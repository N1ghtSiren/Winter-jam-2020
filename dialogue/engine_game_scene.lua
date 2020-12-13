game_scene = {}

local currentScene = nil

local methods = {}
methods.__index = methods

function methods:destroy()
    self.background:removeSelf()
    self.textbg:removeSelf()
    self.text:removeSelf()
    self.skip:removeSelf()

    indexer.remove("scenes", self)
    local c = indexer.gettable("chars")
    for k, v in pairs(c) do
        v:destroy()
    end
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
    self.text.text = text
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

    obj.textbg = display.newRect(level_layers[2], 0, 570, 1280, 150)
    obj.textbg.isVisible = true
    obj.textbg:setFillColor(0.3, 0.3, 0.3, 0.4)
    obj.textbg:addEventListener("touch", ontouch)

    obj.text = display.newText(level_layers[3], "Тестовый диалог", 10, 580, fontMain, 30)
    
    local function onSkip(event)
        if(event.phase~="began")then return end
        obj.stage = obj.maxstage
        obj:update()
        return true
    end

    obj.skip = display.newImageRect(level_layers[2], "content/images/button_skip.png", 250, 50)
    setAnchor(obj.skip, 1, 1)
    obj.skip.x, obj.skip.y = 1280, 570
    obj.skip:addEventListener("touch", onSkip)


    setmetatable(obj, methods)
    obj:create()

    return obj
end

function game_scene.getCurrent()
    return currentScene or false
end