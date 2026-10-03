extends CharacterBody2D

var maxSpeed: float = 500 
var speed: float = 0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_up", "move_down")
	velocity.y = direction * maxSpeed
	move_and_slide()
	if absf(direction) > 0:
		speed = lerpf(maxSpeed, maxSpeed, 1 * delta)
	else:
		speed = 0
		

func _on_main_game_over():
	set_physics_process(false)


func _on_main_idle_started():
	set_physics_process(false)


func _on_main_ingame_started():
	set_physics_process(true)
