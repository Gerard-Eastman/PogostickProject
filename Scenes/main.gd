extends Node

var levelOne = preload("res://Scenes/levelPogo.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(levelOne.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
