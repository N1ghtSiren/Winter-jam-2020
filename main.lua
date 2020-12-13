fontMain = native.newFont("content/comicsans.ttf")

display.setDefault("anchorX", 0)
display.setDefault("anchorY", 0)

require("mylib")
require("indexer")
require("fps")

require("progress")

require("dialogue.characters.chardb")
require("dialogue.game_scenes.scenedb")

composer = require("composer")
composer.loadScene("scenes.mainmenu")
composer.loadScene("scenes.level")

require("dialogue.engine_character")
require("dialogue.engine_game_scene")

composer.gotoScene("scenes.mainmenu")

