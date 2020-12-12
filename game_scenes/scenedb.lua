scenedb = {}

local scenes = {}

local scenenames = {
    "scene1",
}

function scenedb.loadAll()
    local n = 1
    local maxn = #scenenames

    for _,id in ipairs(scenenames) do
        scenes[id] = require("game_scenes."..id)
        print("scenes loaded: "..id.." | "..n.."/"..maxn)
        n = n + 1
    end
end

function scenedb.get(id)
    if(scenes[id])then
        return deepcopy(scenes[id])
    end
    
    return false
end

scenedb.loadAll()