extends Control

var fuel = 100

var max_fuel = 100

@onready var fuel_gauge = $FuelGauge

func _process(_delta):
	fuel_gauge.value = float(fuel) / max_fuel * 100
	
func set_fuel(_fuel):
	fuel = _fuel

func set_max_fuel(_max_fuel):
	max_fuel = _max_fuel
