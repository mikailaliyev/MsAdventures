extends Control
@onready var bg_music = load("res://menu/background_music.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_option_pressed():
	$BackgroundMusic.playing = false
	
