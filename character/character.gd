extends CharacterBody2D
@onready var level = $".."
@onready var portal = $"../Portal"
@onready var lives = $"../LivesCounterCanvas/Lives"
@export var menu: PackedScene

var coins:int = 0
var jump_available:bool = true

func _ready():
	level.connect("player_gains", coin_added)
	portal.connect("portal_reached", level_end)
	level.connect("enemy_collision", loosing_health)
	$AnimatedSprite2D.animation = "idle"

func _physics_process(_delta):
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * 600
	
	move_and_slide()
	
	#gravity and jump
	jump()
	
	#flip horizontally when turning
	if Input.is_action_pressed("right"):
		if $AnimatedSprite2D.animation == "damaged":
			await get_tree().create_timer(0.3).timeout
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("left"):
		if $AnimatedSprite2D.animation == "damaged":
			await get_tree().create_timer(0.3).timeout
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = false	
	elif velocity == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"

	#if lost all lives then game over
	if lives.get_child_count() == 0 && $AnimationPlayer && $AnimationPlayer.current_animation != "death":
		Engine.time_scale = 0.5
		rotation_degrees = 45
		$AnimationPlayer.play('death')
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.5).timeout
		if get_tree():
			get_tree().reload_current_scene()
		Engine.time_scale = 1.0

		
func coin_added():
	coins += 1
	if coins > 0:
		$"../CoinsCounterCanvas/CoinsCounterLabel".text = "Coins: " + str(coins)

#erasing life icons if collided with enemies
func loosing_health():
	$AnimatedSprite2D.animation = "damaged"
	lives.get_child(lives.get_child_count() - 1).queue_free()



func level_end():
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_packed(menu)
	
#gravity
func gravity():
	if !is_on_floor():
		velocity.y += 40
		
#jump cooldown
func jump():
	if Input.is_action_pressed("jump") && jump_available:
		velocity.y -= 1000
		$Timer.start()
		jump_available = false
	else:
		gravity()
		
func _on_timer_timeout():
	jump_available = true
	
#to exit game
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("exit"):
		get_tree().quit()

