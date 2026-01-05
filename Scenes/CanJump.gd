extends Area2D



func _ready():
	var parent = get_parent()
	connect("body_entered", Callable(parent, "on_jumpbox_entered"))
	connect("body_exited", Callable(parent, "on_jumpbox_exited"))
	
