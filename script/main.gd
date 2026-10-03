extends Node2D

signal idle_started
signal ingame_started
signal paused_started
signal stats_started 

enum State{IDLE, INGAME,PAUSED,STATS}

var current_state: State

signal game_over

var scorePlayer = 0
var scoreBot = 0
var max_score:int = 1
var idle_elapsed: int = -1:
	set(value):
		idle_elapsed = value
		update_countdown_label()

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var player_score_sound = $PlayerScoreSound
@onready var bot_score_sound = $BotScoreSound
@onready var results_screen = %ResultsScreen
@onready var results = %Results
@onready var countdown_label = %CountdownLabel

func _ready()->void:
	results_screen.hide()
	change_state(State.IDLE)
	start_countdown()
	await get_tree().create_timer(3).timeout
	change_state(State.INGAME)

func _on_goal_1_body_entered(body: Node2D) -> void:
	body.global_position = Vector2i(566, 332)
	scoreBot += 1
	bot_score_sound.play()
	updateScore()


func _on_goal_2_body_entered(body: Node2D) -> void:
	body.global_position = Vector2i(566, 332) 
	scorePlayer += 1
	updateScore()
	player_score_sound.play()

func updateScore():
	score_label.text = str(scorePlayer) + " x " + str(scoreBot)
	if scorePlayer>=max_score or scoreBot>=max_score:
		results_screen.show()
		results.text ="%s" % "[wave]vitória!" if scorePlayer>scoreBot else"[shake]Derrota!"
		results.text +="\n%s/%s" % [scorePlayer,scoreBot]
		game_over.emit()
		change_state(State.STATS)
		
func change_state(new_state:State)->void:
	current_state = new_state
	
	match new_state:
		State.IDLE:
			idle_started.emit()
		State.INGAME:
			ingame_started.emit()
			countdown_label.hide()
		State.PAUSED:
			paused_started.emit()
		State.STATS:
			stats_started.emit()

func start_countdown()->void:
	var tween:Tween = create_tween()
	idle_elapsed=3
	tween.tween_property(self,"idle_elapsed",0,3)

func update_countdown_label()->void:
	countdown_label.text = str(idle_elapsed)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
	

func _on_restart_pressed():
	get_tree().reload_current_scene()
