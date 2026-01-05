extends Camera2D

var targetPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	acquire_target_position()
	
	global_position = targetPosition
	
	
func acquire_target_position():
	var players = get_tree().get_nodes_in_group("camera_follow")
	if (players.size() > 0):
		var player = players[0]
		targetPosition = player.global_position
		targetPosition.y -= 30
