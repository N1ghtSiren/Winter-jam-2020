local scene = composer.newScene()
sceneLevel = scene
level_layers = {}
--[[
layers of things
--game
0 - background / sky
1 - objects
2 - interface
3 - menu

--story
0 - background
1 - chars
2 - textbg
3 - text
]]

--[[
linear
0,0
]]

function scene:create(event)
    local sceneGroup = self.view

    for i = 0, 3 do
        level_layers[i] = newGroup(sceneGroup)
    end


end

function scene:hide(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end
end

function scene:show(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("show", scene)

function scene:stop()
    indexer.reset("level1")
end

function scene:level1_intro()
    local game_scene = game_scene.new("level_1_intro")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene:level1_outro()

end

function scene:level1()
    --clear scene
    game_scene.getCurrent():destroy()
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local player = {
        speed = 1,
        line = 2,
    }

    --background start

    line = display.newLine(level_layers[0], 0, 650, 1280, 650)
    line:setStrokeColor(0.8, 0.8, 0.8, 1)
    line.strokeWidth = 3
    --background end

    --objects start
    local lines = {
        [-2] = {sx = 128, sy = 650, ex = 0, ey = 720,},
        [-1] = {sx = 384, sy = 650, ex = 320, ey = 720,},
        [0] = {sx = 640, sy = 650, ex = 640, ey = 720,},
        [1] = {sx = 896, sy = 650, ex = 960, ey = 720,},
        [2] = {sx = 1152, sy = 650, ex = 1280, ey = 720,},
    }

    for i = -2, 2 do
        debuglines[i] = display.newLine(level_layers[0], lines[i].sx, lines[i].sy, lines[i].ex, lines[i].ey)
        debuglines[i]:setStrokeColor(0.3, 0, 0, 1)
        debuglines[i].strokeWidth = 3
    end

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    for i = 100, 1, -1 do
        objects[i] = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
        objects[i].isVisible = true
        objects[i].alpha = 0
        objects[i].line = math.random(1, 5)
        objects[i].dist = 5+2*i
        objects[i].x, objects[i].y = -1000, -1000
        setAnchor(objects[i], 0.5, 1)
        setScale(objects[i], 0.01, 0.01)
    end

    --scale - 3.5 ~ 2
    local function onFrame(deltaTime)
        local isVisible = nil

        for k, obj in pairs(objects) do
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<4.5 and onScreen)then
                setScale(obj,3.5-getPercent(obj.dist, 4.5))

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, 4.5))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --fade out
            if(obj.dist<0)then
                obj.alpha = obj.alpha - 0.02*player.speed
                if(obj.alpha<=0)then
                    obj:removeSelf()
                    objects[k] = nil
                end
            
            --fade in
            elseif(obj.dist<4.5 and obj.dist>0 and obj.alpha<1)then
                obj.alpha = obj.alpha + 0.02*player.speed

            end
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    dbgtext = display.newText("speed: "..player.speed, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            player.line = player.line - 1

        elseif(event.keyName=="right" or event.keyName=="d")then
            player.line = player.line + 1

        elseif(event.keyName=="up" or event.keyName=="w")then
            player.speed = player.speed + 1
            dbgtext.text = "speed: "..player.speed

        elseif(event.keyName=="down" or event.keyName=="s")then
            player.speed = player.speed - 1
            dbgtext.text = "speed: "..player.speed

        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

return scene