extends CharacterBody2D

#TODO: add idle animations to all sides and handle it

@export var SPEED : int = 1000

@onready var player_camera = $Camera2D
@onready var body_anim = $player_body
@onready var head_anim = $player_head

var is_saluting #acts a bit as a semaphore, so the salute animation is played whole


func _ready() -> void:
	#set interaction manager player variable
	InteractionManager.player = self
	
	#set camera limits according to parent scene
	player_camera.limit_bottom = get_parent().camera_limit_bottom
	player_camera.limit_left = get_parent().camera_limit_left
	player_camera.limit_right = get_parent().camera_limit_right
	player_camera.limit_top = get_parent().camera_limit_top
	
	#load sprite frames according to selected character
	$player_head.sprite_frames = load("res://resources/sprite_frames/" + Globals.character + ".tres")


func _physics_process(delta) -> void:
	if not is_saluting:
		player_movement(delta)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("salute"):
		#set semaphore
		is_saluting = true
		
		head_anim.play("front")
		body_anim.play("salute")
		#wait until animation finishes
		await get_tree().create_timer(0.5).timeout
		#release semaphore
		is_saluting = false


func player_movement(_delta) -> void: 
	if Input.is_action_pressed("walk_right"):
		body_anim.play("walk_right")
		head_anim.play("right")
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("walk_left"):
		body_anim.play("walk_left")
		head_anim.play("left")
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("walk_down"):
		body_anim.play("walk_down")
		head_anim.play("front")
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("walk_up"):
		body_anim.play("walk_up")
		head_anim.play("back")
		velocity.x = 0
		velocity.y = -SPEED
	else:
		body_anim.play("default")
		head_anim.play("front")
		velocity = Vector2.ZERO
	
	move_and_slide()
