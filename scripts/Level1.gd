extends Node2D

func _ready():
	get_node("ParallaxBackground/ParallaxLayer/LivesLabel").text = str("Lives: ", global.lives)
	set_process(true)

func _process(delta):
	pass
