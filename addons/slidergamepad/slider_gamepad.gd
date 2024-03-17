@tool
extends HSlider

@export var slider_speed: float = 2
@export var joystick_discrete: bool = false
@export var dpad_step: int = 5

var sliding_left: bool = false
var sliding_right: bool = false

var joystick_can_input: bool = true

func _ready() -> void:
	pass # Replace with function body.

# Overriding the behavior in _input() and marking it as handled
# to avoid Godot doing the normal behavior
func _input(event: InputEvent) -> void:
	# FOR TESTING
	#return
	
	# If slider doesn't have focus, it's not the right one
	if not has_focus(): return
	if not editable: return
	
	if joystick_discrete:
		handle_joystick_discrete(event)
	else:
		handle_joystick(event)
	handle_dpad(event)

func _process(delta: float) -> void:
	if sliding_left:
		value -= ceil(slider_speed * delta)
	elif sliding_right:
		value += ceil(slider_speed * delta)

func handle_joystick(event: InputEvent) -> void:
	if not event is InputEventJoypadMotion: return
	if event.is_action("ui_left", true):
#		print("Event: ", event.as_text())
		get_viewport().set_input_as_handled()
		if event.get_action_strength("ui_left", true) > 0.15:
			sliding_right = false
			sliding_left = true
		else:
			sliding_right = false
			sliding_left = false
	elif event.is_action("ui_right", true):
#		print("Event: ", event.as_text())
		if event.get_action_strength("ui_right", true) > 0.15:
			sliding_right = true
			sliding_left = false
		else:
			sliding_right = false
			sliding_left = false
		get_viewport().set_input_as_handled()
		
func handle_joystick_discrete(event: InputEvent) -> void:
	if not event is InputEventJoypadMotion: return
	if event.is_action("ui_left", true):
		if event.get_action_strength("ui_left", true) >= 0.25 and joystick_can_input:
			joystick_can_input = false
			value -= 1
		elif event.is_action_released("ui_left", true):
			joystick_can_input = true
		get_viewport().set_input_as_handled()
		
	elif event.is_action("ui_right", true):
		if event.get_action_strength("ui_right", true) >= 0.25 and joystick_can_input:
			joystick_can_input = false
			value += 1
		elif event.is_action_released("ui_right", true):
			joystick_can_input = true
		get_viewport().set_input_as_handled()
	
func handle_dpad(event: InputEvent) -> void:
	if not event is InputEventJoypadButton: return
	
	if event is InputEventJoypadButton and event.button_index == JOY_BUTTON_DPAD_LEFT and event.is_pressed():
		value -= dpad_step-1
	elif event is InputEventJoypadButton and event.button_index == JOY_BUTTON_DPAD_RIGHT and event.is_pressed():
		value += dpad_step-1

func _on_gui_input(event):
	pass
	#TODO: handle input here instead of _input()
	#print("GUI INPU EVENT: ", event)
	#get_viewport().set_input_as_handled()
