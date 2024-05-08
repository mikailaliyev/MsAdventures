extends Node
var is_paused: bool = false
var left_control: int = 0
var right_control: int = 0
var jump_control: int = 0
var coin_control: int = 0
var live_control: int = 0
var coin_intro_control: int = 0
var enemy_intro_control: int = 0

func _process(_delta):
	# Pausing the game
	#pause_game()

	#Teaching moving controls
	if left_control == 0:
		if $"../Character".is_on_floor():
			if !Input.is_action_pressed("right"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				left_control += 1
				%LabelForRightControl.hide()
				%ArrowRight.hide()
				

	if right_control == 0:
		if %Character.position.x > 710 && left_control > 0:
			%LabelForLeftControl.show()
			%ArrowLeft.show()
			if !Input.is_action_pressed("left"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				right_control += 1
				%LabelForLeftControl.hide()
				%ArrowLeft.hide()
		
	if jump_control == 0:
		if %Character.position.x < 500 && right_control > 0:
			%LabelForUpControl.show()
			%ArrowUp.show()
			if !Input.is_action_pressed("jump"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				jump_control += 1
				%LabelForUpControl.hide()
				%ArrowUp.hide()
		
	if coin_control == 0:
		if %Character.position.x > 540 && right_control > 0 && jump_control > 0:
			%LabelForCoinsCounter.show()
			%RectangleForCoins.show()			
			get_tree().paused = true
			if Input.is_action_just_pressed("pause"): 
				get_tree().paused = false
				coin_control += 1
				%LabelForCoinsCounter.hide()
				%RectangleForCoins.hide()
	
	if live_control == 0:
		if %Character.position.x > 550 && coin_control > 0:
			%LabelForLivesCounter.show()
			%RectangleForLives.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				live_control += 1
				%LabelForLivesCounter.hide()
				%RectangleForLives.hide()
				
	if coin_intro_control == 0:
		if %Character.position.x > 2100:
			%LabelForCoinsIntro.show()
			%RectangleForCoinsIntro.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				coin_intro_control += 1
				%LabelForCoinsIntro.hide()
				%RectangleForCoinsIntro.hide()

	if enemy_intro_control == 0:
		if %Character.position.x > 2800:
			%LabelForEnemyIntro.show()
			%RectangleForEnemyIntro.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				enemy_intro_control += 1
				%LabelForEnemyIntro.hide()
				%RectangleForEnemyIntro.hide()


func pause_game():
	if Input.is_action_just_pressed("pause"):
		if is_paused:
			get_tree().paused = false
			is_paused = false
			return false
		else:
			get_tree().paused = true
			is_paused = true
			return true
