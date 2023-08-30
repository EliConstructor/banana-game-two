extends Node

var game_version: int = 1
var loaded = false

@export var bananas: float = 0

@onready var producers = $GUIColumns/ProducersColumn/ScrollContainer/Producers
@onready var upgrades = $GUIColumns/UpgradesColumn/ScrollContainer/Upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !loaded:
		load_game()
		loaded = true
	bananas = bananas + get_total_production() * delta
	if Input.is_action_just_pressed("summonbananas"):
		bananas = bananas + 100000
	if Input.is_action_just_pressed("savegame"):
		save_game()

func get_total_production():
	var total = 0
	for producer in producers.producers:
		total = total + producer.get_production()
	return total

func save_game():
	print("SAVING")
	var data = {}
	data["game_version"] = game_version
	data["bananas"] = bananas
	for producer in producers.producers:
		data[producer.name + ".amount"] = producer.amount
	for upgrade in upgrades.upgrades:
		data[upgrade.name + ".amount"] = upgrade.amount
	
	var file = FileAccess.open("user://save_data.json",FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file = null

func load_game():
	if !FileAccess.file_exists("user://save_data.json"):
		return
	var file = FileAccess.open("user://save_data.json",FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	for producer in producers.producers:
		if data[producer.name + ".amount"] != null:
			producer.amount = data[producer.name + ".amount"]
	for upgrade in upgrades.upgrades:
		if data[upgrade.name + ".amount"] != null:
			upgrade.amount = data[upgrade.name + ".amount"]
	bananas = data["bananas"]

