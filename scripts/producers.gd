extends VBoxContainer

@export var producers: Array[Producer]
var item_button = preload("res://uielements/item_button.tscn")

@onready var upgrades = $/root/Main/GUIColumns/UpgradesColumn/ScrollContainer/Upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add buttons
	for producer in producers:
		if item_button.can_instantiate():
			var button = item_button.instantiate()
			button.item = producer
			add_child(button)
			button.update_all()
			producer.upgrades = upgrades
		else:
			push_error("Couldn't instantiate producer button.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
