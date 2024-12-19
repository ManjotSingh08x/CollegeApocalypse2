extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:


	var direction := Vector2(0,0)
	
	
	if Input.is_action_pressed("move_left"):
		direction[0] = -1
	if Input.is_action_just_released("move_left"):
		direction[0] = 0
	if Input.is_action_pressed("move_right"):
		direction[0] = 1
	if Input.is_action_just_released("move_right"):
		direction[0] = 0
	velocity[0] = direction[0]*SPEED

	if Input.is_action_pressed("move_up"):
		direction[1] = -1
	if Input.is_action_just_released("move_up"):
		direction[1] = 0
	if Input.is_action_pressed("move_down"):
		direction[1] = 1
	if Input.is_action_just_released("move_down"):
		direction[1] = 0
	velocity[1] = direction[1]*SPEED
	
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
		velocity = velocity /1.414
	elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down"):
		velocity = velocity/1.414
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
		velocity = velocity /1.414
	elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up"):
		velocity = velocity/1.414
	
	if direction == Vector2(0,0):
		animated_sprite.play("idle")
	elif direction[0]==1:
		animated_sprite.play("walk_right")
	elif direction[0] ==-1:
		animated_sprite.play("walk_left")
	elif direction[1] ==1:
		animated_sprite.play("walk_down")
	elif direction[1] == -1:
		animated_sprite.play("walk_up")
	
	move_and_slide()
