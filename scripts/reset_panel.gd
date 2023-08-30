extends Panel

@onready var main = $/root/Main

func _on_yes_button_pressed():
	main.reset_game()
	visible = false

func _on_no_button_pressed():
	visible = false
