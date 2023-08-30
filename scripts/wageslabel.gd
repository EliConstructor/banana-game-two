extends Label

@onready var event_manager = $/root/Main/EventManager

func _process(delta):
	text = "Paying " + str(event_manager.get_total_wages()) + " bananas per second in wages to workers"
	if event_manager.robot_workers.amount > 0:
		visible = false
