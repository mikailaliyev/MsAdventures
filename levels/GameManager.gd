extends Node
var left_control: int = 0
var right_control: int = 0
var jump_control: int = 0
# Called when the node enters the scene tree for the first time.
func _process(_delta):
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
		

