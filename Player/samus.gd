extends CharacterBody2D

@export var acceleration:float
@export var friction:float
@export var speed = 100.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $animatedSprite
@onready var direction : float = 0.0;

var aimState:int = 0
var previous_animation:String
var previous_state:String

func _physics_process(delta):
	
	#if Input.is_action_pressed("Aim") and get_node("FSM").current_state != get_node("FSM").get_node("Aim") and get_node("FSM").current_state != get_node("FSM").get_node("Walk"):
		##dentro do node FSM tem a função change state e a variavel current state
		#get_node("FSM").change_state(get_node("FSM").current_state,"Aim")
	# Gravidade vertical
	applyGravity(delta)
	
	# Atualizar coordenadas
	move_and_slide()

func applyGravity(delta):
	if not is_on_floor():
		velocity.y += 980 * delta

func manageJump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
