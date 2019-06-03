extends KinematicBody2D

const UP = Vector2(0,-1)
const JUMP = -800
const WALK = 100

var velocity = Vector2(0,0)
var walk_direction = -1
onready var sprite = get_node("Sprite")

func _ready():
	get_node("AnimationPlayer").play("walk")
	set_physics_process(true)

func _physics_process(delta):
	velocity.x= WALK*walk_direction
	self.move_and_slide(velocity,UP)
	if self.is_on_wall():#reverse direction
		walk_direction = -walk_direction 
		sprite.set_flip_h(not sprite.flip_h)
