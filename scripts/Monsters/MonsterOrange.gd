extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 1000
const JUMP = -800
const WALK = 130

var velocity = Vector2(0,0.1)
var walk_direction = -1
onready var sprite = get_node("Sprite")

func _ready():
	get_node("AnimationPlayer").play("orange_walk")
	set_physics_process(true)

func _physics_process(delta):
	velocity.x= WALK*walk_direction
	self.move_and_slide(velocity,UP)
	if self.is_on_wall():#reverse direction
		walk_direction = -walk_direction 
		sprite.set_flip_h(not sprite.flip_h)
	if self.is_on_floor():
		velocity.y = 0.1
	else:
		velocity.y += GRAVITY*delta
	#Collisions
	for i in get_slide_count(): #um unico movimento pode causar várias colisões
		if get_slide_collision(i).collider.is_in_group("player"):
			global.lives -= 1
			get_tree().reload_current_scene()
			break # evita que o personagem morra mais de uma vez se houver mais de 1 colisão
