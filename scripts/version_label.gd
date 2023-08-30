extends Label

@onready var main = $/root/Main

func _ready():
	text = "v" + str(main.game_version)
