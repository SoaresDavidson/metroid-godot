extends CharacterBody2D

@export var acceleration:float
@export var friction:float
@export var speed = 100.0
const JUMP_VELOCITY = -400.0
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animationState = animation_tree.get("parameters/playback")

var up:bool = false
var down:bool = false
var turning:bool = false
var animations = [["TurningCrouchedLeft","TurningCrouchedRight"], ["TurningLeft", "TurningRight"]]
var hold:float = 0
var power:float

func _physics_process(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("up"):
		up = true
	else:
		up = false
	if Input.is_action_just_pressed("down"):
		down = true
	if Input.is_action_just_pressed("up"):
		down = false

		
	var direction = Input.get_axis("left", "right")
		
	turningAnimation(direction)
	
	if not down:
		stading_motion(direction, delta)
	else:
		crouched_motion(direction)
		
	move_and_slide()


func stading_motion(direction: float, delta) -> void:
	if direction:
		setAnimations(direction)
		animationState.travel("Running")
		velocity.x = move_toward(velocity.x , direction * speed, acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
func crouched_motion(direction: float):
	velocity.x = 0
	if direction:
		setAnimations(direction)
	animationState.travel("Crouched")

func setAnimations(direction: float):
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Running/blend_position", direction)
	animation_tree.set("parameters/Crouched/blend_position", direction)
	
func turningAnimation(direction: float) -> void:
	var i
	if down:
		i = 0
	else:
		i = 1
	if not hold:
		hold = direction
	if hold != direction and direction != 0:
		turning = true
		animation_tree.active = false
		if hold < 0:
			animation_player.play(animations[i][0])
		if hold > 0:
			animation_player.play(animations[i][1])
			
		await animation_player.animation_finished
		turning = false
		animation_tree.active = true
		hold = direction
