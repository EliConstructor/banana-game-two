extends TextureButton

@onready var main = $/root/Main
@onready var upgrades = $/root/Main/GUIColumns/UpgradesColumn/ScrollContainer/Upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bananas_per_click = get_bananas_per_click()
	if bananas_per_click == 1:
		tooltip_text = "Harvest " + str(bananas_per_click) + " banana"
	else:
		tooltip_text = "Harvest " + str(bananas_per_click) + " bananas"


func _on_pressed():
	main.bananas = main.bananas + get_bananas_per_click()

func get_bananas_per_click():
	var bananas_per_click = 1
	for upgrade in upgrades.upgrades:
		if upgrade is ClickBoostUpgrade:
			if upgrade.type == ClickBoostUpgrade.CLICK_BOOST_TYPE.ADDITION:
				bananas_per_click = bananas_per_click + upgrade.modifier * upgrade.amount
			elif upgrade.type == ClickBoostUpgrade.CLICK_BOOST_TYPE.MULTIPLIER:
				bananas_per_click = bananas_per_click * pow(upgrade.modifier, upgrade.amount)
	return bananas_per_click
