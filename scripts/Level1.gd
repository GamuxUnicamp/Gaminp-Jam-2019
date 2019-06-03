extends Node2D

onready var background = get_node("background")
onready var camera = get_node("Player/Camera2D")

func _ready():
	set_process(true)

func _process(delta):
	#make background follow camera
	#background.global_position = camera.global_position
	#background.global_position.x = max(0,camera.global_position.x)
	pass
