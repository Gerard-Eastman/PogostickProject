extends Node
var player
var spawnPoint = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")
	spawnPoint = player[0].global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("respawn")):
		player[0].global_position = spawnPoint
