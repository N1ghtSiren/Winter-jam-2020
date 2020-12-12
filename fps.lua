local frametime = display.newText("", 600, 0, native.systemFont, 16 )
frametime:setFillColor(0, 1, 0, 1)

local fps = display.newText("", 600, 20, native.systemFont, 16 )
fps:setFillColor(0, 1, 0, 1)

local t = 0
function OnFrame(e)
    local lastframetime = e.time-t
    frametime.text = "frametime: "..round(lastframetime).."ms"
    fps.text = "fps: "..round(1000/lastframetime)
    t = e.time
end

Runtime:addEventListener("enterFrame", OnFrame)