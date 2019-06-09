extends Node2D

func _ready():
	get_node("Timer").connect("timeout",self,"proxima_cena")
	set_process_input(true)

func _input(event):
	#proxima_cena()
	if event is InputEventKey:
		proxima_cena()
	pass

func proxima_cena():
	get_tree().change_scene("res://scenes/levels/Level6.tscn")