local scene = composer.newScene()
local group = {}
local objects = {}
local flakes = {}
local treeSpawner = nil
--[[
layers of things
0 - background
1 - falling snow
2 - ui / buttons
]]

function scene:create(event)
    local sceneGroup = self.view
    local text_command_name = nil
    local text_command_1 = nil
    local text_command_2 = nil
    local text_gameName = nil
    local button = nil
    local garland = nil

    local function listener(event)
        if(event.phase~="began")then return end

        if(event.target.id==0)then
            sceneLevel:level1_intro()
        end
    end

    for i = 0, 3 do
        group[i] = newGroup(sceneGroup)
    end

    text_command_name = display.newText(group[3], "Hat Dealers", 10, 10, fontMain, 40)
    text_command_1 = display.newText(group[3], "N1ght Siren", 10, 80, fontMain, 30)
    text_command_2 = display.newText(group[3], "Софи", 10, 110, fontMain, 30)

    text_gameName = display.newText(group[3], "Продам Гараж", 650, 10, fontMain, 70)
    setAnchor(text_gameName, 0.5, 0)

    button = display.newImageRect(group[3], "content/images/mainmenu_button_1.png", 150, 50)
    button.x, button.y = 10, 660
    button.id = 0
    button.isVisible = true
    button:addEventListener("touch", listener)
    
    group[3].alpha = 0
    timer.performWithDelay(10000,function()
        transition.to(group[3], {alpha=1, time=1500, transition=easing.linear})
    end)
end

function scene:hide(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end
    self:endAnimation()
end

function scene:show(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end

    self:startAnimation()
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("show", scene)

function scene:startAnimation()
    local dist = 3

    --objects start
    local lines = {
        [-5] = {sx = 60, sy = 300, ex = -640, ey = 360,},
        [-4] = {sx = 176, sy = 300, ex = -384, ey = 360,},
        [-3] = {sx = 292, sy = 300, ex = -128, ey = 360,},
        [-2] = {sx = 408, sy = 300, ex = 128, ey = 360,},
        [-1] = {sx = 524, sy = 300, ex = 384, ey = 360,},
        [0] = {sx = 640, sy = 300, ex = 640, ey = 360,},
        [1] = {sx = 756, sy = 300, ex = 896, ey = 360,},
        [2] = {sx = 872, sy = 300, ex = 1152, ey = 360,},
        [3] = {sx = 988, sy = 300, ex = 1408, ey = 360,},
        [4] = {sx = 1104, sy = 300, ex = 1664, ey = 360,},
        [5] = {sx = 1220, sy = 300, ex = 1920, ey = 360,},
    }

    local function getPointOnLine(lineN, percent)
        local lx = lines[lineN].ex-lines[lineN].sx
        local ly = lines[lineN].ey-lines[lineN].sy

        return lines[lineN].sx+lx*percent, lines[lineN].sy+ly*percent
    end

    local player = {speed = 0.2, dist = 0}
    local viewdist = 9

    local function onFrame(deltaTime)
        if(scene.view.isVisible==false)then return end
        local setScale, getPercent = setScale, getPercent

        for k = #objects, 1, -1 do
            local obj = objects[k]
            setScale(obj, 1)

            obj.x, obj.y = getPointOnLine(obj.line, 1-getPercent(obj.dist, player.dist+viewdist-1))

            obj.dist = obj.dist - player.speed*deltaTime

            if(obj.dist<player.dist+viewdist)then
                obj.alpha = obj.alpha + 0.02
            end

            if(obj.y>1120 or obj.x<-100 or obj.x>1380)then
                obj:removeSelf()
                table.remove(objects, k)
                obj = nil
            end
        end

        player.dist = player.dist + player.speed*deltaTime
    end

    onFrame(0.016)
    indexer.add("mainmenu", onFrame)

    transition.to(player, { speed = 0.6 , time=10000, transition=easing.linear})
    timer.performWithDelay(10000, function()
        if(scene.view.isVisible==false)then return end
        for i = -5, 5 do
            transition.to(lines[i], { ey = 1500, time=15000, transition=easing.linear})
        end
    end)

    local function addRow()
        if(#objects>200)then return end
        for l = -5, 5 do
            if(math.random(0,5)==0)then
                --nothing
            else
                local obj = display.newImageRect(group[1], "content/images/tree.png", 150, 300)
                obj.isVisible = true
                obj.line = l
                obj.dist = dist
                obj.alpha = 0.2
                obj.x, obj.y = -1000, -1000
                setAnchor(obj, 0.5, 1)
                setScale(obj, 0.01, 0.01)
                obj:toBack()
                table.insert(objects, obj)
            end
        end
        dist = dist + 1
        collectgarbage()
        collectgarbage()
    end

    if(treeSpawner==nil)then
        treeSpawner = timer.performWithDelay(200, addRow, -1)
    end
    --snow

    local snowlines = {}
    for i = 1, 100 do
        local n = math.random(-100, 100)
        snowlines[i] = deepcopy(lines[math.random(-5,5)])
        snowlines[i].sx = snowlines[i].sx + n
        snowlines[i].ex = snowlines[i].ex + n
        snowlines[i].sy = 0
        snowlines[i].ey = 720
    end

    local function getPointOnLine2(lineN, percent)
        local lx = snowlines[lineN].ex - snowlines[lineN].sx
        local ly = snowlines[lineN].ey - snowlines[lineN].sy

        return snowlines[lineN].sx+lx*percent, snowlines[lineN].sy+ly*percent
    end

    local function onFrame(deltaTime)
        if(scene.view.isVisible==false)then return end

        local obj = display.newImageRect(group[2], "content/images/snow.png", 6, 6)
        obj.line = math.random(1, 100)
        obj.lifetime = 0
        table.insert(flakes, obj)

        for k = #flakes, 1, -1 do
            local obj = flakes[k]
            obj.x, obj.y = getPointOnLine2(obj.line, getPercent(obj.lifetime, 120))
            obj.lifetime = obj.lifetime + 1

            if(obj.lifetime>=120)then
                obj:removeSelf()
                table.remove(flakes, k)
                obj = nil
            end
        end
    end

    timer.performWithDelay(11000, function()
        if(scene.view.isVisible==false)then return end
        indexer.add("mainmenu", onFrame)
    end)

end

function scene:endAnimation()
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

    for k = #flakes, 1, -1 do
        local obj = flakes[k]
        obj:removeSelf()
        table.remove(flakes, k)
        obj = nil
    end
            
    indexer.reset("mainmenu")
end

return scene