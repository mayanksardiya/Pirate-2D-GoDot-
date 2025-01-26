extends CharacterBody2D
 
@export var SPEED : int = 400
@export var JUMP_FORCE : int = 500
@export var GRAVITY : int = 900
@onready var animated_sprite_2d = $AnimatedSprite2D

var is_attacking = false
 
func _physics_process(delta):
	
	
	var direction = Input.get_axis("left","right")
	
	if direction:
		
		velocity.x = SPEED * direction
		
		if is_on_floor() and is_attacking == false:
			$AnimatedSprite2D.play("run")
		
	else:
		
		velocity.x = 0
		
		if is_on_floor() and is_attacking == false:
			
			$AnimatedSprite2D.play("idle")
	
	# Rotate
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	
	# Gravity
	
	if not is_on_floor():
		
		velocity.y += GRAVITY * delta
		
		if velocity.y > 0:
			
			$AnimatedSprite2D.play("fall")
	
	# Jump
	
	if is_on_floor():
		
		if Input.is_action_just_pressed("up"):
			
			velocity.y -= JUMP_FORCE
			$AnimatedSprite2D.play("jump")
			
		if Input.is_action_just_pressed("att1"):
			
			is_attacking = true
			$AnimatedSprite2D.play("attack1")
			await $AnimatedSprite2D.animation_finished
			is_attacking = false
			
			
	
	
	move_and_slide()
