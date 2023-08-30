extends Panel

@onready var main = $/root/Main
@onready var reset_panel = $/root/Main/ResetPanel

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		visible = !visible


func _on_save_button_pressed():
	main.save_game()
	visible = false

func _on_reset_button_pressed():
	reset_panel.visible = true
	visible = false
