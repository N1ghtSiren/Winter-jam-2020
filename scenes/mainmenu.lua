local scene = composer.newScene()
--[[
layers of things
0 - background
1 - falling snow
2 - ui / buttons
]]

function scene:create(event)
    local sceneGroup = self.view
    local text_gameName = nil
    local button = nil
    local group = {}
    local scene_

    local function listener(event)
        if(event.phase~="began")then return end

        if(event.target.id==0)then
            composer.gotoScene("scenes.level")
            scene_ = game_scene.new("scene1")
            scene_:play()
        end
    end

    for i = 0, 2 do
        group[i] = newGroup(sceneGroup)
    end

    text_gameName = display.newText(group[2], "Тестовый диалог", 10, 10, fontMain, 40)

    button = display.newImageRect(group[2], "content/images/mainmenu_button_1.png", 150, 50)
    button.x, button.y = 10, 660
    button.id = 0
    button:addEventListener("touch", listener)
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

return scene