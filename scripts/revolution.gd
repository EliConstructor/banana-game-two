extends Panel

@onready var main = $/root/Main
@onready var event_manager = $/root/Main/EventManager
@onready var upgrades = $/root/Main/GUIColumns/UpgradesColumn/ScrollContainer/Upgrades
@onready var revolution_info = $/root/Main/RevolutionInfo
@onready var wages_label = $/root/Main/GUIColumns/BananaColumn/Wages
var worker = preload("res://upgrades/worker.tres")
var robot_workers = preload("res://upgrades/robotic_workers.tres")

# Accept the deal
func _on_option_1_pressed():
	event_manager.workers_payed = true
	upgrades.get_upgrade_of_type(robot_workers).locked = false
	wages_label.visible = true
	visible = false

# Cull workers
func _on_option_2_pressed():
	var workers = upgrades.get_upgrade_of_type(worker)
	workers.amount = workers.amount / 2
	visible = false
