extends Node2D

@onready var coins = $Coins
signal player_gains()

func _ready():
		#var new_coin: PackedScene = preload("res://coins/coin.tscn")
		#var coin = new_coin.instantiate()
		#coin.connect("coin_collected", character_collected)
		#add_child(coin)	

	for i in coins.get_child_count():
		coins.get_child(i).connect("coin_collected",character_collected)

func character_collected():
	emit_signal("player_gains")
	
