extends Node2D

@onready var coins = $Coins
@onready var enemies = $Enemies
signal player_gains()
signal enemy_collision()

func _ready():
	for i in coins.get_child_count():
		coins.get_child(i).connect("coin_collected",character_collected)
	for i in enemies.get_child_count():
		enemies.get_child(i).connect("enemy_attack",enemy_attacking)

func character_collected():
	emit_signal("player_gains")

func enemy_attacking():
	emit_signal("enemy_collision")
