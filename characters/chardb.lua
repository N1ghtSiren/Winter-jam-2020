chardb = {}

local chars = {}

local charnames = {
    "testchar",
}

function chardb.loadAll()
    local n = 1
    local maxn = #charnames

    for _,id in ipairs(charnames) do
        chars[id] = require("characters."..id)
        print("chars loaded: "..id.." | "..n.."/"..maxn)
        n = n + 1
    end
end

function chardb.get(id)
    if(chars[id])then
        return deepcopy(chars[id])
    end
    
    return false
end

chardb.loadAll()