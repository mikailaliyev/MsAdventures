extends Node
#Save path for game variables
var save_path = "res://variable.save"

#Game control tips variables
var is_paused: bool = false
var left_control: int = 0
var right_control: int = 0
var jump_control: int = 0
var coin_control: int = 0
var life_control: int = 0
var coin_intro_control: int = 0
var enemy_intro_control: int = 0
var all_controls: int = 0

func _ready():
	# Loading control tips data if exist
	load_data()

func _process(_delta):
	#Teaching moving controls
	if right_control == 0:
		if $"../Character".is_on_floor():
			if !Input.is_action_pressed("right"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				right_control += 1
				all_controls += 1
				save_data(right_control)
				%LabelForRightControl.hide()
				%ArrowRight.hide()
	else:
			%LabelForRightControl.hide()
			%ArrowRight.hide()	
	
	
	if left_control == 0:
		if %Character.position.x > 600:
			%LabelForLeftControl.show()
			%ArrowLeft.show()
			if !Input.is_action_pressed("left"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				left_control += 1
				all_controls += 1
				save_data(left_control)
				%LabelForLeftControl.hide()
				%ArrowLeft.hide()
	
			
	if jump_control == 0 && all_controls == 2 :
		if %Character.position.x < 500:
			%LabelForUpControl.show()
			%ArrowUp.show()
			if !Input.is_action_pressed("jump"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				jump_control += 1
				all_controls += 1
				save_data(jump_control)
				%LabelForUpControl.hide()
				%ArrowUp.hide()
		
	if coin_control == 0:
		if %Character.position.x > 500 && all_controls == 3:
			%LabelForCoinsCounter.show()
			%RectangleForCoins.show()			
			get_tree().paused = true
			if Input.is_action_just_pressed("pause"): 
				get_tree().paused = false
				coin_control += 1
				all_controls += 1
				save_data(coin_control)
				%LabelForCoinsCounter.hide()
				%RectangleForCoins.hide()
	
	if life_control == 0:
		if %Character.position.x > 550 && coin_control > 0:
			%LabelForLivesCounter.show()
			%RectangleForLives.show()
			if !Input.is_action_pressed("pause"):
				get_tree().paused = true
			else: 
				get_tree().paused = false
				life_control += 1
				save_data(life_control)
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
				save_data(coin_intro_control)
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
				save_data(enemy_intro_control)
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

func save_data(data):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var _file = FileAccess.open(save_path, FileAccess.READ)
		left_control = 1
		right_control = 1
		jump_control = 1
		coin_control = 1
		life_control = 1
		coin_intro_control = 1
		enemy_intro_control = 1
	else:
		print("no data")
