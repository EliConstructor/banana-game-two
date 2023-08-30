extends Button

@onready var main = $/root/Main
@onready var priceLabel: Label = $Container/Info/Price
@onready var countLabel: Label = $Container/Info/Count
@onready var nameLabel: Label = $Container/Info/Name
@onready var iconRect: TextureRect = $Container/Icon

var item: Item

func _on_pressed():
	if main.bananas >= item.get_price():
		main.bananas = main.bananas - item.get_price()
		item.amount = item.amount + 1
		update_labels()

func _process(delta):
	if item is Producer:
		tooltip_text = item.description % str(snapped(item.get_base_production(), 0.01))

func update_labels():
	priceLabel.text = "Price: " + str(round(item.get_price())) + " bananas"
	countLabel.text = str(item.amount) + " owned"

func update_all():
	update_labels()
	nameLabel.text = item.name
	iconRect.texture = item.icon
	tooltip_text = item.description
