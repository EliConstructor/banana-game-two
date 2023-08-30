extends Resource
class_name Item

@export var name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var basePrice: int
@export var priceMultiplier: float
@export var locked: bool = true
@export var auto_unlock: bool = true
@export var max_amount: int = -1

var amount: int = 0

func get_price():
	return basePrice * pow(priceMultiplier, amount)
