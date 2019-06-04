extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 1000
const JUMP = -800
const WALK = 300

var velocity = Vector2(0,0.1)
var jump_sound

func _ready():
	jump_sound = get_node("JumpSound")
	set_physics_process(true)

func _physics_process(delta):
	#Movement
	self.move_and_slide(velocity,UP)
	if Input.is_action_pressed("ui_left") and (not Input.is_action_pressed("ui_right")):
		velocity.x = -WALK
	elif Input.is_action_pressed("ui_right") and (not Input.is_action_pressed("ui_left")):
		velocity.x = WALK
	else:
		velocity.x = 0
	if self.is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP
			jump_sound.play()
		else:
			velocity.y = 0.1
	else:
		velocity.y += GRAVITY*delta
	#Collisions
	for i in get_slide_count(): #um unico movimento pode causar várias colisões
		if get_slide_collision(i).collider.is_in_group("monsters"):
			global.lives -= 1
			get_tree().reload_current_scene()
			break # evita que o personagem morra mais de uma vez se houver mais de 1 colisão
