extends CharacterBody2D

@export var acceleration:float
@export var friction:float
@export var speed = 100.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $animatedSprite
@onready var direction : float = 0.0;

var up:bool = false
var down:bool = false
var hold:float = 0
var previous_animation:String
var previous_state:String

func _physics_process(delta):
	
	# Gravidade vertical
	applyGravity(delta);
	
	# Atualizar coordenadas
	move_and_slide()

func applyGravity(delta):
	if not is_on_floor():
		velocity.y += 980 * delta

func manageJump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
