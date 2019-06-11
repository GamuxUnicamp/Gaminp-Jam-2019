extends Node2D

onready var btn_left = get_node("ButtonLeft")
onready var btn_right = get_node("ButtonRight")
onready var btn_jump = get_node("ButtonJump")

func _ready():
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
	btn_left.connect("pressed",self,"_left_down")
	btn_right.connect("pressed",self,"_right_down")
	btn_jump.connect("pressed",self,"_jump_down")
	btn_left.connect("released",self,"_left_up")
	btn_right.connect("released",self,"_right_up")
	btn_jump.connect("released",self,"_jump_up")

func _left_down():
	Input.action_press("ui_left")

func _right_down():
	Input.action_press("ui_right")

func _jump_down():
	Input.action_press("ui_up")

func _left_up():
	Input.action_release("ui_left")

func _right_up():
	Input.action_release("ui_right")

func _jump_up():
	Input.action_release("ui_up")
