extends Node

@onready var main = $/root/Main
@onready var upgrades = $/root/Main/GUIColumns/UpgradesColumn/ScrollContainer/Upgrades
@onready var revolution_info = $/root/Main/RevolutionInfo
var workers = preload("res://upgrades/worker.tres")
var robot_workers = preload("res://upgrades/robotic_workers.tres")

var workers_payed = false

func _ready():
	workers = upgrades.get_upgrade_of_type(workers)
	robot_workers = upgrades.get_upgrade_of_type(robot_workers)

func _process(delta):
	if main.bananas >= 1_000_000 and workers.amount >= 10 and !workers_payed:
		# Trigger banana revolution
		revolution_info.visible = true
	else:
		revolution_info.visible = false
	
	# Pay workers
	if workers_payed and robot_workers.amount <= 0:
		main.bananas = main.bananas - get_total_wages() * delta

func get_total_wages():
	return workers.amount * 10


