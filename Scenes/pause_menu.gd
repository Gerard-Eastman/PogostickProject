extends Control

@onready var currentLevel = get_tree().get_nodes_in_group("level")
@onready var player = get_tree().get_nodes_in_group("player")

func _ready():
	if currentLevel.size() > 0: currentLevel = currentLevel[0]
	if player.size() > 0: player = player[0]


func _on_resume_button_down():
	currentLevel.pauseMenu()

func _on_show_fps_toggled(_toggled_on):
	pass # Replace with function body.

func _on_auto_jump_toggled(toggled_on):
	player.autoJump = toggled_on 

func _on_timer_toggled(_toggled_on):
	pass # Replace with function body.

func _on_respawn_button_down():
	currentLevel.respawn()
	currentLevel.pauseMenu()
	player.velocity = Vector2.ZERO
