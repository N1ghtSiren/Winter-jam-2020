progress = {}

local json = require( "json" )

local path = system.pathForFile( "progress.pog", system.DocumentsDirectory)

print("path:",path)

local data = {
    options = {
        music = true,
        onlyMovies = false,
    },
    level = 0,
    gameCompleted = false,
}

function progress.load()
    local f = io.open(path,"r")

    if(not f)then print("no saves found") return end

    local content = f:read("*all")
    f:close()

    local encoded = json.decode(content)

    if(encoded==nil)then return end

    data.options = deepcopy(encoded.options)
    data.level = encoded.level
    data.gameCompleted = encoded.gameCompleted
end

function progress.save()
    local f = io.open(path,"w+")
    if(f==nil)then print("error in file creation") return end

    local encoded = json.encode(data, {indent=true})
    f:write(encoded)
    f:close()

    return
end

function progress.isOnlyMovies()
    return data.options.onlyMovies
end

function progress.setOnlyMovies(flag)
    data.options.onlyMovies = flag
end

function progress.isGameCompleted()
    return data.gameCompleted
end

function progress.setGameCompleted()
    data.gameCompleted = true
end

function progress.getmaxlvl()
    return data.level
end

function progress.setmaxlvl(n)
    if(data.level<n)then
        data.level = n
    end
end

progress.load()