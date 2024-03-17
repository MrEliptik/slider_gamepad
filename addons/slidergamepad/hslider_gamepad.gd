@tool
extends HSlider

## Horizontal slider with better support for joystick and dpad
class_name HSliderGamepad

@export var slider_speed: float = 2
@export var dpad_step: int = 5
@export var joystick_discrete: bool = false
# If set above 0, enables smooth discrete
@export var joystick_smooth_discrete_threshold: float = 0.0

var sliding_dir: int = 0

var joystick_can_input: bool = true

var smooth_discrete_timer: SceneTreeTimer

func _ready() -> void:
	# Connect the event
	gui_input.connect(_on_gui_input)

func _process(delta: float) -> void:
	if sliding_dir == 0: return
	
	value += ceil(slider_speed * delta) * sliding_dir

func handle_joystick(event: InputEvent) -> void:
	if not event is InputEventJoypadMotion: return
	
	# Not passing true would also match the action set to this
	# key so it would trigger on joystick right, but I find it confusing
	# Use pressed to respect the deadzone set in the project settings
	if event.is_action_pressed("ui_left", true):
		sliding_dir = -1.0
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_right", true):
		sliding_dir = 1.0
		get_viewport().set_input_as_handled()
	elif event.is_action_released("ui_left", true) or event.is_action_released("ui_right", true):
		sliding_dir = 0.0
		get_viewport().set_input_as_handled()

func handle_joystick_discrete(event: InputEvent) -> void:
	if not event is InputEventJoypadMotion: return
	
	if event.is_action_pressed("ui_left", true) and joystick_can_input:
		joystick_can_input = false
		value -= 1
		if not is_zero_approx(joystick_smooth_discrete_threshold):
			smooth_discrete_timer = get_tree().create_timer(joystick_smooth_discrete_threshold)
			smooth_discrete_timer.timeout.connect(on_threshold_timeout.bind(-1))
		get_viewport().set_input_as_handled()
	elif event.is_action_released("ui_left", true):
		joystick_can_input = true
		sliding_dir = 0.0
		if smooth_discrete_timer and smooth_discrete_timer.timeout.is_connected(on_threshold_timeout):
			smooth_discrete_timer.timeout.disconnect(on_threshold_timeout)
		get_viewport().set_input_as_handled()
		
	if event.is_action_pressed("ui_right", true) and joystick_can_input:
		joystick_can_input = false
		value += 1
		if not is_zero_approx(joystick_smooth_discrete_threshold):
			smooth_discrete_timer = get_tree().create_timer(joystick_smooth_discrete_threshold)
			smooth_discrete_timer.timeout.connect(on_threshold_timeout.bind(1))
		get_viewport().set_input_as_handled()
	elif event.is_action_released("ui_right", true):
		joystick_can_input = true
		sliding_dir = 0.0
		if smooth_discrete_timer and smooth_discrete_timer.timeout.is_connected(on_threshold_timeout):
			smooth_discrete_timer.timeout.disconnect(on_threshold_timeout)
		get_viewport().set_input_as_handled()
	
func handle_dpad(event: InputEvent) -> void:
	if not event is InputEventJoypadButton: return
	
	if event is InputEventJoypadButton and event.button_index == JOY_BUTTON_DPAD_LEFT and event.is_pressed():
		value -= dpad_step
		get_viewport().set_input_as_handled()
	elif event is InputEventJoypadButton and event.button_index == JOY_BUTTON_DPAD_RIGHT and event.is_pressed():
		value += dpad_step
		get_viewport().set_input_as_handled()

func _on_gui_input(event):
	if not editable: return
	
	if joystick_discrete:
		handle_joystick_discrete(event)
	else:
		handle_joystick(event)
		
	handle_dpad(event)

func on_threshold_timeout(direction: int) -> void:
	if direction == 1 and Input.is_action_pressed("ui_right", true) or \
		direction == -1 and Input.is_action_pressed("ui_left", true):
		sliding_dir = direction
