extends CharacterBody2D

@onready var ball: CharacterBody2D = $"../Ball"


func _physics_process(delta: float) -> void:
	var ballDirection = global_position.direction_to(ball.global_position)
	
	if ballDirection.y >= 0:
		velocity.y = 300
	else:
		velocity.y = -300
	move_and_slide()


func _on_main_game_over():
	set_physics_process(false)


func _on_main_idle_started():
	set_physics_process(false)


func _on_main_ingame_started():
	set_physics_process(true)
