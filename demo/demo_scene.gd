extends Control

@onready var smooth_slider = $VBoxContainer/HBoxContainer/SmoothSlider
@onready var smooth_value = $VBoxContainer/HBoxContainer/SmoothValue

@onready var stepped_slider = $VBoxContainer/HBoxContainer3/SteppedSlider
@onready var stepped_value = $VBoxContainer/HBoxContainer3/SteppedValue

@onready var smooth_stepped_slider = $VBoxContainer/HBoxContainer4/SmoothSteppedSlider
@onready var smooth_stepped_value = $VBoxContainer/HBoxContainer4/SmoothSteppedValue

@onready var v_smooth_stepped_slider = $VBoxContainer/HBoxContainer2/VSmoothSteppedSlider
@onready var v_smooth_stepped_value = $VBoxContainer/HBoxContainer2/SmoothSteppedValue

func _ready():
	smooth_slider.grab_focus()

func _on_smooth_slider_value_changed(value):
	smooth_value.text = str(value)

func _on_stepped_slider_value_changed(value):
	stepped_value.text = str(value)

func _on_smooth_stepped_slider_value_changed(value):
	smooth_stepped_value.text = str(value)

func _on_v_smooth_stepped_slider_value_changed(value):
	v_smooth_stepped_value.text = str(value)
