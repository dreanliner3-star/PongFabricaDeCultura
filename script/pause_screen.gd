extends Panel

var is_pausable:bool = false

func _ready() -> void: 
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused 


func _on_pause_button_pressed():
	if is_pausable == false:
		return
	get_tree().paused = false
	hide()


func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_main_stats_started():
	is_pausable = false
	set_process_unhandled_input(false)
