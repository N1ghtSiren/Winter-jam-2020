local scene = composer.newScene()
level_layers = {}
--[[
layers of things
0 - background
1 - chars
2 - ui
3 - text background
4 - text
5 - menuButtons
]]

function scene:create(event)
    local sceneGroup = self.view

    for i = 0, 5 do
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

return scene