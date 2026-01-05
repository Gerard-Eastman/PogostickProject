extends Node
var player
var spawnPoint = Vector2.ZERO
var playerScene = preload("res://Scenes/PogoStickCharacter.tscn")
@onready var pause_Menu = $Camera2D/PauseMenu
var paused = false
@onready var trial_timer_start = Time.get_ticks_msec()
var won := false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")
	if player.size() > 0:
		spawnPoint = player[0].global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("respawn")):
		respawn()
	if(Input.is_action_just_pressed("pause")):
		pauseMenu()
	
	if !won:
		$TrialTimerUI/Control/Label.text = get_time()
	
func respawn():
	won = false
	
	
	player[0].global_position = spawnPoint
	player[0].velocity = Vector2.ZERO
	player[0].rotation_degrees = 0
	trial_timer_start = Time.get_ticks_msec()
	
func pauseMenu():
	if paused:
		pause_Menu.hide()
		Engine.time_scale = 1
		paused = false
		
	else:
		pause_Menu.show()
		Engine.time_scale = 0
		paused = true

func get_time():
	var current_Time = Time.get_ticks_msec() - trial_timer_start
	var minutes = current_Time/1000/60%60
	var seconds = current_Time/1000%60
	var hours = current_Time/1000/60/60
	
	return (str(hours)+":"+str("%02d" % minutes)+":"+str("%02d" % seconds) + "\n\nBy Floppypants")
	
func _on_finish_area_body_entered(_body):
	game_won()
	
func game_won():
	won = true
	pauseMenu()
	
