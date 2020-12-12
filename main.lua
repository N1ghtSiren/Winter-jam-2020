fontMain = native.newFont("content/comicsans.ttf")

display.setDefault("anchorX", 0)
display.setDefault("anchorY", 0)

require("mylib")
require("indexer")

composer = require("composer")
composer.loadScene("scenes.mainmenu")
composer.loadScene("scenes.level")

require("engine.game_scene")
require("engine.character")

require("characters.chardb")
require("game_scenes.scenedb")

composer.gotoScene("scenes.mainmenu")