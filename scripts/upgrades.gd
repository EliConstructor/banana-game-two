extends VBoxContainer

@export var upgrades: Array[Upgrade]
var item_button = preload("res://uielements/item_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add buttons
	for upgrade in upgrades:
		if item_button.can_instantiate():
			var button = item_button.instantiate()
			button.item = upgrade
			add_child(button)
			button.update_all()
		else:
			push_error("Couldn't instantiate upgrade button.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
