extends VBoxContainer

@export var upgrades: Array[Upgrade]
var item_button = preload("res://uielements/item_button.tscn")

@onready var main = $/root/Main

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
	# Unlock if necessary
	for upgrade in upgrades:
		if main.bananas > upgrade.basePrice and upgrade.auto_unlock:
			upgrade.locked = false

func get_upgrade_of_type(target):
	for upgrade in upgrades:
		if upgrade == target:
			return upgrade
