extends Control

onready var smooth_slider = $VBoxContainer/HBoxContainer/SmoothSlider
onready var smooth_value = $VBoxContainer/HBoxContainer/SmoothValue

onready var stepped_slider = $VBoxContainer/HBoxContainer2/SteppedSlider
onready var stepped_value = $VBoxContainer/HBoxContainer2/SteppedValue

onready var smooth_stepped_slider = $VBoxContainer/HBoxContainer3/SmoothSteppedSlider
onready var smooth_stepped_value = $VBoxContainer/HBoxContainer3/SmoothSteppedValue

func _ready():
	smooth_slider.grab_focus()

func _on_SmoothSlider_value_changed(value: float) -> void:
	smooth_value.text = str(value)

func _on_SteppedSlider_value_changed(value: float) -> void:
	stepped_value.text = str(value)

func _on_SmoothSteppedSlider_value_changed(value: float) -> void:
	smooth_stepped_value.text = str(value)
