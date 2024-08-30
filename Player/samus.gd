extends CharacterBody2D

@export var acceleration:float

const JUMP_VELOCITY = -400.0

@export var speed = 100.0

@export_category("Jump Parameters")
@export var Jump_Buffer_Time:float = .1
@export var Jump_Gravity:float = 1000
@export var Fall_Gravity: float = 1250
@export var Coyote_Time:float = 0.25
var Jump_Avaliable:bool = true
var Jump_Buffer:bool = false


@onready var animated_sprite = $animatedSprite
@onready var direction : float = 0.0;

var aimState:int = 0

var previous_animation:String
var previous_state:String

func _ready():
	pass
	
func _physics_process(delta):

	
	manageJump()
	
	applyGravity(delta)
	# Atualizar coordenadas
	move_and_slide()

func applyGravity(delta):
	if not is_on_floor():
		
		if Jump_Avaliable:
			get_tree().create_timer(Coyote_Time).timeout.connect(Coyote_Timeout)
		if velocity.y > 0:
			velocity.y += Jump_Gravity * delta
		else:
			velocity.y += Fall_Gravity * delta
	else:
		Jump_Avaliable = true
		if Jump_Buffer:
			Jump()
			Jump_Buffer = false
			
func Jump():
	get_node("FSM").change_state(get_node("FSM").current_state, "StandingJump")
	velocity.y = JUMP_VELOCITY
	Jump_Avaliable = false

func manageJump() -> void:
	if Input.is_action_just_pressed("Jump"):
		if Jump_Avaliable:
			Jump()
		else:
			Jump_Buffer = true
			get_tree().create_timer(Jump_Buffer).timeout.connect(on_jump_biffer_timeout)
			
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y /= 4
		
func Coyote_Timeout():
	Jump_Avaliable = false

func on_jump_biffer_timeout() -> void:
	Jump_Buffer = false

func handleJumpAnimations():
	get_node("FSM/Idle").checkAnimation("CrouchedAimUpLeft", "CrouchedAimUpRight")
