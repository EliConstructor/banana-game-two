extends Button

@onready var main = $/root/Main
@onready var priceLabel: Label = $Container/Info/Price
@onready var countLabel: Label = $Container/Info/Count
@onready var nameLabel: Label = $Container/Info/Name
@onready var iconRect: TextureRect = $Container/Icon
@onready var shade: TextureRect = $Shade
@onready var container: HBoxContainer = $Container
@onready var locked_label: Label = $LockedLabel

var item: Item

func _on_pressed():
	if item.amount + 1 > item.max_amount and item.max_amount > 0:
		return
	if main.bananas >= item.get_price():
		main.bananas = main.bananas - item.get_price()
		item.amount = item.amount + 1
		update_labels()

func _process(delta):
	if item is Producer:
		tooltip_text = item.description % str(snapped(item.get_base_production(), 0.01))
	
	update_labels()
	
	# Max amount disable
	if item.amount + 1 > item.max_amount and item.max_amount > 0:
		disabled = true
		shade.visible = true
	else:
		disabled = false
		shade.visible = false
	
	# Locked disable
	if item.locked:
		disabled = true
		locked_label.visible = true
		container.visible = false
	else:
		disabled = false
		locked_label.visible = false
		container.visible = true

func update_labels():
	priceLabel.text = "Price: " + str(round(item.get_price())) + " bananas"
	if item.amount + 1 > item.max_amount and item.max_amount > 0:
		countLabel.text = str(item.amount) + " owned (max)"
	else:
		countLabel.text = str(item.amount) + " owned"

func update_all():
	update_labels()
	nameLabel.text = item.name
	iconRect.texture = item.icon
	tooltip_text = item.description
