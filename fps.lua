local frametime = display.newText("", 1280, 0, native.systemFont, 16 )
frametime:setFillColor(0, 1, 0, 1)
setAnchor(frametime, 1, 0) 

local fps = display.newText("", 1280, 20, native.systemFont, 16 )
fps:setFillColor(0, 1, 0, 1)
setAnchor(fps, 1, 0) 

local t = 0
function OnFrame(e)
    local lastframetime = round(e.time-t)
    frametime.text = "frametime: "..lastframetime.."ms"
    fps.text = "fps: "..round(1000/lastframetime)
    t = e.time
    
    --functions to be called each frame
    local funcs = indexer.gettable("mainmenu")
    for _, v in pairs(funcs)do
        v(lastframetime * 0.001)
    end

    local funcs = indexer.gettable("level1")
    for _, v in pairs(funcs)do
        v(lastframetime * 0.001)
    end
    
    --
end

Runtime:addEventListener("enterFrame", OnFrame)