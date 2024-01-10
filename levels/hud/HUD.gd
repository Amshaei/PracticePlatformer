extends Control

@onready var fuel_gauge = $FuelGauge

var total_frames = 21.0

func _process(_delta):
	if GlobalVars.has_jetpack:
		fuel_gauge.visible = true
		fuel_gauge.frame = total_frames - (GlobalVars.jetpack_fuel / (GlobalVars.max_fuel / total_frames))
	else:
		fuel_gauge.visible = false
	
func set_fuel(_fuel):
	GlobalVars.jetpack_fuel = _fuel

func set_max_fuel(_max_fuel):
	GlobalVars.max_fuel = _max_fuel
