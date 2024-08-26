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

var facing : int = 1;

## State atual
enum PlayerStates {
	idle,
	turn,
	walk
}
var state: int = PlayerStates.idle;

func _physics_process(delta):
	
	# Gravidade vertical
	applyGravity(delta);
	
	## Pular
	#manageJump();
	#
	## Agachar
	#manageUpDown();
		#
	#direction = Input.get_axis("ui_left", "ui_right")
	#
	## Movimentação em pé
	#if not down:
		#stading_motion(direction, delta)
	## Movimentação agachado
	#else:
		#crouched_motion(direction)
		#
	# Atualizar coordenadas
	move_and_slide()

func applyGravity(delta):
	if not is_on_floor():
		velocity.y += 980 * delta

func manageUpDown():
	# Checar Up
	up = Input.is_action_just_pressed("up");

	# Checar Down
	if Input.is_action_just_pressed("down"):
		down = true
	# Se levantar
	if down and up:	down = false

func manageJump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func stading_motion(direction: float, delta) -> void:
	if direction:
		velocity.x = move_toward(velocity.x , direction * speed, acceleration * delta)
		
	else:
		animated_sprite.play("IdleLeft")
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
func crouched_motion(direction: float):
	velocity.x = 0
	#if direction:
#func turningAnimation(direction: float) -> void:
	#var i
	#if down:
		#i = 0
	#else:
		#i = 1
	#if not hold:
		#hold = direction
	#if hold != direction and direction != 0:
		#turning = true
		#animation_tree.active = false
		#if hold < 0:
			#animation_player.play(animations[i][0])
		#if hold > 0:
			#animation_player.play(animations[i][1])
			#
		#await animation_player.animation_finished
		#turning = false
		#animation_tree.active = true
		#hold = direction


func _on_samus_animations_animation_finished():
	# Animação de turn:
	if state == PlayerStates.turn:
		if animated_sprite.animation == "TurnRight":
			state = PlayerStates.idle;
