extends CharacterBody2D
@onready var level = $".."
@onready var portal = $"../Portal"
@onready var enemies = $"../LivesCounterCanvas/Lives"
@export var menu: PackedScene
var coins:int = 0
var jump_available:bool = true

func _ready():
	level.connect("player_gains", coin_added)
	portal.connect("portal_reached", level_end)
	level.connect("enemy_collision", loosing_health)
	$AnimatedSprite2D.animation = "idle"

func _physics_process(_delta):
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * 600
	move_and_slide()
	
	#gravity and jump
	jump()
	#flip horizontally when turning
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("left"):
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	elif velocity == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"
		
	#if lost all lives then game over
	if enemies.get_child_count() == 0:
		get_tree().reload_current_scene()

		
func coin_added():
	coins += 1
	if coins > 0:
		print(coins)
		$"../CoinsCounterCanvas/CoinsCounterLabel".text = "Coins: " + str(coins)

#erasing life icons if collided with enemies
func loosing_health():
	enemies.get_child(enemies.get_child_count() - 1).queue_free()



func level_end():
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_packed(menu)
	
#gravity
func gravity():
	if !is_on_floor():
		velocity.y += 40
#jump
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


