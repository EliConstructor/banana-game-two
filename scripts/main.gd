extends Node

var game_version: int = 1
var loaded = false

@export var bananas: float = 0

@onready var producers = $GUIColumns/ProducersColumn/ScrollContainer/Producers
@onready var upgrades = $GUIColumns/UpgradesColumn/ScrollContainer/Upgrades
@onready var event_manager = $EventManager

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
	
	# Basic Data
	data["game_version"] = game_version
	data["bananas"] = bananas
	
	# Upgrades and producers
	for producer in producers.producers:
		data[producer.name + ".amount"] = producer.amount
		data[producer.name + ".locked"] = producer.locked
	for upgrade in upgrades.upgrades:
		data[upgrade.name + ".amount"] = upgrade.amount
		data[upgrade.name + ".locked"] = upgrade.locked
	
	# Event Data
	# Banana Revolution
	data["workers_payed"] = event_manager.workers_payed
	
	var file = FileAccess.open("user://save_data.json",FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file = null

func load_game():
	if !FileAccess.file_exists("user://save_data.json"):
		return
	var file = FileAccess.open("user://save_data.json",FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	
	# Basic Data
	bananas = data["bananas"]
	
	# Upgrades and producers
	for producer in producers.producers:
		if data[producer.name + ".amount"] != null:
			producer.amount = data[producer.name + ".amount"]
			producer.locked = data[producer.name + ".locked"]
	for upgrade in upgrades.upgrades:
		if data[upgrade.name + ".amount"] != null:
			upgrade.amount = data[upgrade.name + ".amount"]
			upgrade.locked = data[upgrade.name + ".locked"]
	
	# Event Data
	# Banana Revolution
	event_manager.workers_payed = data["workers_payed"]
	if event_manager.workers_payed:
		event_manager.revolution_info.wages_label.visible = true

