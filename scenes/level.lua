local scene = composer.newScene()
sceneLevel = scene
level_layers = {}

local treeSpawner = nil
local objects = {}
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

function scene.level1_intro()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end

    local game_scene = game_scene.new("level_1_intro")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene.level2_intro()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    
    local game_scene = game_scene.new("level_2_intro")
    game_scene:play()

    composer.gotoScene("scenes.level")
end

function scene.level3_intro()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    
    local game_scene = game_scene.new("level_3_intro")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene.level4_intro()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    
    local game_scene = game_scene.new("level_4_intro")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene.level5_intro()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    
    local game_scene = game_scene.new("level_5_intro")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene.finale()
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    
    local game_scene = game_scene.new("finale")
    game_scene:play()
    composer.gotoScene("scenes.level")
end

function scene:endLevel()
    if(treeSpawner~=nil)then
        timer.cancel(treeSpawner)
        treeSpawner = nil
    end

    for k = #objects, 1, -1 do
        local obj = objects[k]
        obj:removeSelf()
        table.remove(objects, k)
        obj = nil
    end

    for i = 0, 3 do
        level_layers[i]:removeSelf()
        level_layers[i] = newGroup(self.view)
        level_layers[i]:toFront()
    end

    indexer.reset("level1")
end

function scene:level1()
    --clear scene
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    composer.gotoScene("scenes.level")
    if(progress.isOnlyMovies())then
        self.level2_intro()
        return
    end
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local dbgtext2 = nil

    local player = {
        speed = 2,
        line = 0,
        dist = 0,
        finish = 90,
        gifts = 0,
    }
    
    dbgtext2 = display.newText(level_layers[2], "путь: "..player.dist.."/"..player.finish, 0, 690, fontMain, 30 )
    setAnchor(dbgtext2, 0, 1)

    local dist = 3
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

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local function addRow()
        print(#objects)

        if(#objects>350 or dist>=player.finish)then return end
        for l = -2, 2 do
            local n = math.random(0,5)
            if(n<=3)then
                --nothing
            elseif(n==4)then
                local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.type = "tree"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            elseif(n==5)then
                local obj = display.newImageRect(level_layers[1], "content/images/gift.png", 256, 256)
                obj.isVisible = true
                obj.type = "gift"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        for k, i in pairs({-4, -3, 3, 4}) do
            local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
            obj.isVisible = true
            obj.line = i
            obj.type = "tree"
            obj.dist = dist
            obj.alpha = 0
            obj.x, obj.y = -1000, -1000
            setAnchor(obj, 0.5, 1)
            setScale(obj, 0.01, 0.01)
            obj:setFillColor(0.6, 0.6, 0.6, 1);
            obj:toBack()
            table.insert(objects, obj)
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(500, addRow, -1)
    end

    --scale - 3.5 ~ 2
    local viewDist = 5
    local function onFrame(deltaTime)
        local isVisible = nil

        for k = #objects, 1, -1 do
            local obj = objects[k]
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<viewDist and onScreen)then
                if(obj.type=="tree")then
                    setScale(obj,3.5-getPercent(obj.dist, viewDist))

                elseif(obj.type=="gift")then
                    setScale(obj,1-getPercent(obj.dist, viewDist))

                end

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, viewDist))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --collision
            if(obj.dist<=0 and obj.line == player.line)then
                if(obj.type=="tree")then
                    player.gifts = math.max(0, player.gifts - 5)
                    dbgtext.text = "подарки: "..player.gifts
                elseif(obj.type=="gift")then
                    player.gifts = player.gifts + 1
                    dbgtext.text = "подарки: "..player.gifts
                end
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
            if(obj)then
            --fade out
                if(obj.dist<0)then
                    obj.alpha = obj.alpha - 0.02*player.speed
                    if(obj.alpha<=0)then
                        obj:removeSelf()
                        table.remove(objects, k)
                        obj = nil
                    end
                
                --fade in
                elseif(obj.dist<viewDist and obj.dist>0 and obj.alpha<1)then
                    obj.alpha = obj.alpha + 0.02*player.speed

                end
            end
        end

        --win
        player.dist = player.dist + player.speed*deltaTime
        dbgtext2.text = "путь: "..round(player.dist).."/"..player.finish
        if(player.dist/player.finish>=1)then
            self:endLevel()
            progress.setmaxlvl(2)
            progress.save()
            timer.performWithDelay(100, function()
                progress.setmaxlvl(2)
                progress.save()
                sceneLevel:level2_intro()
            end)    
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    
    dbgtext = display.newText(level_layers[2], "подарки: "..player.gifts, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)
    

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            if(player.line>-2)then
                player.line = player.line - 1
            end

        elseif(event.keyName=="right" or event.keyName=="d")then
            if(player.line<2)then
                player.line = player.line + 1
            end
        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

function scene:level2()
    --clear scene
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    composer.gotoScene("scenes.level")
    if(progress.isOnlyMovies())then
        self.level3_intro()
        return
    end
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local dbgtext2 = nil

    local player = {
        speed = 3,
        line = 0,
        dist = 0,
        finish = 120,
        gifts = 0,
    }
    
    dbgtext2 = display.newText(level_layers[2], "путь: "..player.dist.."/"..player.finish, 0, 690, fontMain, 30 )
    setAnchor(dbgtext2, 0, 1)

    local dist = 3
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

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local function addRow()
        print(#objects)

        if(#objects>350 or dist>=player.finish)then return end
        for l = -2, 2 do
            local n = math.random(0,5)
            if(n<=3)then
                --nothing
            elseif(n==4)then
                local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.type = "tree"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            elseif(n==5)then
                local obj = display.newImageRect(level_layers[1], "content/images/gift.png", 256, 256)
                obj.isVisible = true
                obj.type = "gift"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        for k, i in pairs({-4, -3, 3, 4}) do
            local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
            obj.isVisible = true
            obj.line = i
            obj.type = "tree"
            obj.dist = dist
            obj.alpha = 0
            obj.x, obj.y = -1000, -1000
            setAnchor(obj, 0.5, 1)
            setScale(obj, 0.01, 0.01)
            obj:setFillColor(0.6, 0.6, 0.6, 1);
            obj:toBack()
            table.insert(objects, obj)
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(500, addRow, -1)
    end

    --scale - 3.5 ~ 2
    local viewDist = 5
    local function onFrame(deltaTime)
        local isVisible = nil

        for k = #objects, 1, -1 do
            local obj = objects[k]
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<viewDist and onScreen)then
                if(obj.type=="tree")then
                    setScale(obj,3.5-getPercent(obj.dist, viewDist))

                elseif(obj.type=="gift")then
                    setScale(obj,1-getPercent(obj.dist, viewDist))

                end

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, viewDist))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --collision
            if(obj.dist<=0 and obj.line == player.line)then
                if(obj.type=="tree")then
                    player.gifts = math.max(0, player.gifts - 5)
                    dbgtext.text = "подарки: "..player.gifts
                elseif(obj.type=="gift")then
                    player.gifts = player.gifts + 1
                    dbgtext.text = "подарки: "..player.gifts
                end
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
            if(obj)then
            --fade out
                if(obj.dist<0)then
                    obj.alpha = obj.alpha - 0.02*player.speed
                    if(obj.alpha<=0)then
                        obj:removeSelf()
                        table.remove(objects, k)
                        obj = nil
                    end
                
                --fade in
                elseif(obj.dist<viewDist and obj.dist>0 and obj.alpha<1)then
                    obj.alpha = obj.alpha + 0.02*player.speed

                end
            end
        end

        --win
        player.dist = player.dist + player.speed*deltaTime
        dbgtext2.text = "путь: "..round(player.dist).."/"..player.finish
        if(player.dist/player.finish>=1)then
            self:endLevel()
            progress.setmaxlvl(2)
            progress.save()
            timer.performWithDelay(100, function()
                progress.setmaxlvl(3)
                progress.save()
                sceneLevel:level3_intro()
            end)    
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    
    dbgtext = display.newText(level_layers[2], "подарки: "..player.gifts, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)
    

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            if(player.line>-2)then
                player.line = player.line - 1
            end

        elseif(event.keyName=="right" or event.keyName=="d")then
            if(player.line<2)then
                player.line = player.line + 1
            end
        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

function scene:level3()
    --clear scene
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    composer.gotoScene("scenes.level")
    if(progress.isOnlyMovies())then
        self.level4_intro()
        return
    end
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local dbgtext2 = nil

    local player = {
        speed = 3,
        line = 0,
        dist = 0,
        finish = 150,
        gifts = 0,
    }
    
    dbgtext2 = display.newText(level_layers[2], "путь: "..player.dist.."/"..player.finish, 0, 690, fontMain, 30 )
    setAnchor(dbgtext2, 0, 1)

    local dist = 3
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

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local function addRow()
        print(#objects)

        if(#objects>350 or dist>=player.finish)then return end
        for l = -2, 2 do
            local n = math.random(0,5)
            if(n<=3)then
                --nothing
            elseif(n==4)then
                local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.type = "tree"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            elseif(n==5)then
                local obj = display.newImageRect(level_layers[1], "content/images/gift.png", 256, 256)
                obj.isVisible = true
                obj.type = "gift"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        for k, i in pairs({-4, -3, 3, 4}) do
            local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
            obj.isVisible = true
            obj.line = i
            obj.type = "tree"
            obj.dist = dist
            obj.alpha = 0
            obj.x, obj.y = -1000, -1000
            setAnchor(obj, 0.5, 1)
            setScale(obj, 0.01, 0.01)
            obj:setFillColor(0.6, 0.6, 0.6, 1);
            obj:toBack()
            table.insert(objects, obj)
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(500, addRow, -1)
    end

    --scale - 3.5 ~ 2
    local viewDist = 5
    local function onFrame(deltaTime)
        local isVisible = nil

        for k = #objects, 1, -1 do
            local obj = objects[k]
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<viewDist and onScreen)then
                if(obj.type=="tree")then
                    setScale(obj,3.5-getPercent(obj.dist, viewDist))

                elseif(obj.type=="gift")then
                    setScale(obj,1-getPercent(obj.dist, viewDist))

                end

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, viewDist))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --collision
            if(obj.dist<=0 and obj.line == player.line)then
                if(obj.type=="tree")then
                    player.gifts = math.max(0, player.gifts - 5)
                    dbgtext.text = "подарки: "..player.gifts
                elseif(obj.type=="gift")then
                    player.gifts = player.gifts + 1
                    dbgtext.text = "подарки: "..player.gifts
                end
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
            if(obj)then
            --fade out
                if(obj.dist<0)then
                    obj.alpha = obj.alpha - 0.02*player.speed
                    if(obj.alpha<=0)then
                        obj:removeSelf()
                        table.remove(objects, k)
                        obj = nil
                    end
                
                --fade in
                elseif(obj.dist<viewDist and obj.dist>0 and obj.alpha<1)then
                    obj.alpha = obj.alpha + 0.02*player.speed

                end
            end
        end

        --win
        player.dist = player.dist + player.speed*deltaTime
        dbgtext2.text = "путь: "..round(player.dist).."/"..player.finish
        if(player.dist/player.finish>=1)then
            self:endLevel()
            progress.setmaxlvl(2)
            progress.save()
            timer.performWithDelay(100, function()
                progress.setmaxlvl(4)
                progress.save()
                sceneLevel:level4_intro()
            end)    
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    
    dbgtext = display.newText(level_layers[2], "подарки: "..player.gifts, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)
    

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            if(player.line>-2)then
                player.line = player.line - 1
            end

        elseif(event.keyName=="right" or event.keyName=="d")then
            if(player.line<2)then
                player.line = player.line + 1
            end
        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

function scene:level4()
    --clear scene
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    composer.gotoScene("scenes.level")
    if(progress.isOnlyMovies())then
        self.level5_intro()
        return
    end
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local dbgtext2 = nil

    local player = {
        speed = 3,
        line = 0,
        dist = 0,
        finish = 200,
        gifts = 0,
    }
    
    dbgtext2 = display.newText(level_layers[2], "путь: "..player.dist.."/"..player.finish, 0, 690, fontMain, 30 )
    setAnchor(dbgtext2, 0, 1)

    local dist = 3
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

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local function addRow()
        print(#objects)

        if(#objects>350 or dist>=player.finish)then return end
        for l = -2, 2 do
            local n = math.random(0,5)
            if(n<=3)then
                --nothing
            elseif(n==4)then
                local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.type = "tree"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            elseif(n==5)then
                local obj = display.newImageRect(level_layers[1], "content/images/gift.png", 256, 256)
                obj.isVisible = true
                obj.type = "gift"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        for k, i in pairs({-4, -3, 3, 4}) do
            local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
            obj.isVisible = true
            obj.line = i
            obj.type = "tree"
            obj.dist = dist
            obj.alpha = 0
            obj.x, obj.y = -1000, -1000
            setAnchor(obj, 0.5, 1)
            setScale(obj, 0.01, 0.01)
            obj:setFillColor(0.6, 0.6, 0.6, 1);
            obj:toBack()
            table.insert(objects, obj)
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(500, addRow, -1)
    end

    --scale - 3.5 ~ 2
    local viewDist = 5
    local function onFrame(deltaTime)
        local isVisible = nil

        for k = #objects, 1, -1 do
            local obj = objects[k]
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<viewDist and onScreen)then
                if(obj.type=="tree")then
                    setScale(obj,3.5-getPercent(obj.dist, viewDist))

                elseif(obj.type=="gift")then
                    setScale(obj,1-getPercent(obj.dist, viewDist))

                end

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, viewDist))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --collision
            if(obj.dist<=0 and obj.line == player.line)then
                if(obj.type=="tree")then
                    player.gifts = math.max(0, player.gifts - 5)
                    dbgtext.text = "подарки: "..player.gifts
                elseif(obj.type=="gift")then
                    player.gifts = player.gifts + 1
                    dbgtext.text = "подарки: "..player.gifts
                end
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
            if(obj)then
            --fade out
                if(obj.dist<0)then
                    obj.alpha = obj.alpha - 0.02*player.speed
                    if(obj.alpha<=0)then
                        obj:removeSelf()
                        table.remove(objects, k)
                        obj = nil
                    end
                
                --fade in
                elseif(obj.dist<viewDist and obj.dist>0 and obj.alpha<1)then
                    obj.alpha = obj.alpha + 0.02*player.speed

                end
            end
        end

        --win
        player.dist = player.dist + player.speed*deltaTime
        dbgtext2.text = "путь: "..round(player.dist).."/"..player.finish
        if(player.dist/player.finish>=1)then
            self:endLevel()
            progress.setmaxlvl(2)
            progress.save()
            timer.performWithDelay(100, function()
                progress.setmaxlvl(5)
                progress.save()
                sceneLevel:level5_intro()
            end)    
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    
    dbgtext = display.newText(level_layers[2], "подарки: "..player.gifts, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)
    

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            if(player.line>-2)then
                player.line = player.line - 1
            end

        elseif(event.keyName=="right" or event.keyName=="d")then
            if(player.line<2)then
                player.line = player.line + 1
            end
        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

function scene:level5()
    --clear scene
    if(game_scene.getCurrent())then
        game_scene.getCurrent():destroy()
    end
    composer.gotoScene("scenes.level")
    if(progress.isOnlyMovies())then
        self.finale()
        return
    end
    --
    local line = nil
    local debuglines = {}
    local objects = {}
    local dbgtext = nil
    local dbgtext2 = nil

    local player = {
        speed = 4,
        line = 0,
        dist = 0,
        finish = 100,
        gifts = 0,
    }
    
    dbgtext2 = display.newText(level_layers[2], "путь: "..player.dist.."/"..player.finish, 0, 690, fontMain, 30 )
    setAnchor(dbgtext2, 0, 1)

    local dist = 3
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

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local function addRow()
        print(#objects)

        if(#objects>350 or dist>=player.finish)then return end
        for l = -2, 2 do
            local n = math.random(0,5)
            if(n<=3)then
                --nothing
            elseif(n==4)then
                local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.type = "tree"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            elseif(n==5)then
                local obj = display.newImageRect(level_layers[1], "content/images/gift.png", 256, 256)
                obj.isVisible = true
                obj.type = "gift"
                obj.line = l
                obj.dist = dist
                obj.alpha = 0
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        for k, i in pairs({-4, -3, 3, 4}) do
            local obj = display.newImageRect(level_layers[1], "content/images/tree.png", 150, 300)
            obj.isVisible = true
            obj.line = i
            obj.type = "tree"
            obj.dist = dist
            obj.alpha = 0
            obj.x, obj.y = -1000, -1000
            setAnchor(obj, 0.5, 1)
            setScale(obj, 0.01, 0.01)
            obj:setFillColor(0.6, 0.6, 0.6, 1);
            obj:toBack()
            table.insert(objects, obj)
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(500, addRow, -1)
    end

    --scale - 3.5 ~ 2
    local viewDist = 5
    local function onFrame(deltaTime)
        local isVisible = nil

        for k = #objects, 1, -1 do
            local obj = objects[k]
            local onScreen = nil

            if(obj.line == player.line -2 or obj.line == player.line-1 or obj.line == player.line or obj.line == player.line+1 or obj.line == player.line+2)then
                obj.isVisible = true
                onScreen = true
            else
                obj.isVisible = false
                onScreen = false
            end

            if(obj.dist<viewDist and onScreen)then
                if(obj.type=="tree")then
                    setScale(obj,3.5-getPercent(obj.dist, viewDist))

                elseif(obj.type=="gift")then
                    setScale(obj,1-getPercent(obj.dist, viewDist))

                end

                obj.x, obj.y = getPointOnLine(obj.line-player.line, 1-getPercent(obj.dist, viewDist))
            end

            obj.dist = obj.dist - player.speed*deltaTime

            --collision
            if(obj.dist<=0 and obj.line == player.line)then
                if(obj.type=="tree")then
                    player.gifts = math.max(0, player.gifts - 5)
                    dbgtext.text = "подарки: "..player.gifts
                elseif(obj.type=="gift")then
                    player.gifts = player.gifts + 1
                    dbgtext.text = "подарки: "..player.gifts
                end
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
            if(obj)then
            --fade out
                if(obj.dist<0)then
                    obj.alpha = obj.alpha - 0.02*player.speed
                    if(obj.alpha<=0)then
                        obj:removeSelf()
                        table.remove(objects, k)
                        obj = nil
                    end
                
                --fade in
                elseif(obj.dist<viewDist and obj.dist>0 and obj.alpha<1)then
                    obj.alpha = obj.alpha + 0.02*player.speed

                end
            end
        end

        --win
        player.dist = player.dist + player.speed*deltaTime
        dbgtext2.text = "путь: "..round(player.dist).."/"..player.finish
        if(player.dist/player.finish>=1)then
            self:endLevel()
            progress.setmaxlvl(2)
            progress.save()
            timer.performWithDelay(100, function()
                progress.setmaxlvl(6)
                progress.save()
                sceneLevel:finale()
            end)    
        end
    end

    onFrame(0.016)
    indexer.add("level1", onFrame)
    
    --background end

    --controls start
    
    dbgtext = display.newText(level_layers[2], "подарки: "..player.gifts, 0, 720, fontMain, 30 )
    setAnchor(dbgtext, 0, 1)
    

    local function keyPressed(event)
        if(event.phase~="down")then return false end

        if(event.keyName=="left" or event.keyName=="a")then
            if(player.line>-2)then
                player.line = player.line - 1
            end

        elseif(event.keyName=="right" or event.keyName=="d")then
            if(player.line<2)then
                player.line = player.line + 1
            end
        end

        return false
    end

    Runtime:addEventListener("key", keyPressed)

    --controls end
end

return scene