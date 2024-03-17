extends Control

@onready var smooth_slider = $VBoxContainer/HBoxContainer/SmoothSlider

@onready var smooth_value = $VBoxContainer/HBoxContainer/SmoothValue
@onready var stepped_value = $VBoxContainer/HBoxContainer2/SteppedValue

func _ready():
	smooth_slider.grab_focus()

func _on_smooth_slider_value_changed(value):
	smooth_value.text = str(value)

func _on_stepped_slider_value_changed(value):
	stepped_value.text = str(value)
