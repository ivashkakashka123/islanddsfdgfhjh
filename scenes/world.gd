extends Node2D

@onready var days: AnimationPlayer = $days
@onready var day_aoao: Label = $CanvasLayer/day_aoao

var d_count = -1
func _process(delta: float) -> void:
	days.play("day-night")
	day_aoao.text = 'ДЕНЬ' + str(d_count)

func days_count():
	d_count += 1
