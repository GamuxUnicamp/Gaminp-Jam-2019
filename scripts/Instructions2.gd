extends Node2D

func _ready():
	if global.is_mobile:
		proxima_cena()
	get_node("Timer").connect("timeout",self,"proxima_cena")


func proxima_cena():
	get_tree().change_scene("res://scenes/levels/Level6.tscn")