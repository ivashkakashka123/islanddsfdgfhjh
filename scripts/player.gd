extends CharacterBody2D

enum {
	DOWN,
	UP,
	RIGHT,
	LEFT,
	DOWN_RIGHT,
	DOWN_LEFT,
	UP_RIGHT,
	UP_LEFT,
	ATTACK
}

@onready var player: Sprite2D = $Player

var speed = 750
var idle_dir = DOWN
var hp = 100
var can_move = true
var dmg = 20
var type = "player"
var is_paused = false


func _ready() -> void:
	if Globalka.pl_hunger >=1:
		$CanvasLayer/hungrer/Hunger.frame = 1
	if Globalka.pl_hunger >=2:
		$CanvasLayer/hungrer/Hunger2.frame = 1
	if Globalka.pl_hunger >=3:
		$CanvasLayer/hungrer/Hunger3.frame = 1
	

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	_run()
	
	# Обнуляем скорость в начале каждого кадра
	velocity = Vector2.ZERO
	
	# Собираем ввод с клавиатуры
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Нормализуем вектор, если нужно (для диагонального движения)
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		_handle_movement(input_vector)
	else:
		_idle_state()
	
	move_and_slide()

func _run():
	if Input.is_action_pressed("run"):
		speed = 280
	else:
		speed = 100

func _handle_movement(input_vector: Vector2):
	# Устанавливаем скорость
	velocity = input_vector * speed
	
	# Определяем направление для анимации
	if input_vector.x > 0:
		if input_vector.y > 0:
			# Вниз-вправо
			#animp.play("runD")  # это кста делал дипсик, простите
			$Player.flip_h = false
			idle_dir = DOWN_RIGHT
		elif input_vector.y < 0:
			# Вверх-вправо
			#animp.play("runU")
			$Player.flip_h = false
			idle_dir = UP_RIGHT
		else:
			# Вправо
			#animp.play("run")
			$Player.flip_h = false
			idle_dir = RIGHT
	elif input_vector.x < 0:
		if input_vector.y > 0:
			# Вниз-влево мяу-мяу
			#animp.play("runD")
			$Player.flip_h = true
			idle_dir = DOWN_LEFT
		elif input_vector.y < 0:
			# Вверх-влево гав-гав
			#animp.play("runU")
			$Player.flip_h = true
			idle_dir = UP_LEFT
		else:
			# Влево
			#animp.play("run")
			$Player.flip_h = true
			idle_dir = LEFT
	else:
		if input_vector.y > 0:
			# Вниз
			#animp.play("runD")
			idle_dir = DOWN
		elif input_vector.y < 0:
			# Вверх
			#animp.play("runU")
			idle_dir = UP

func _idle_state():
	velocity.x = 0
	velocity.y = 0
	
	match idle_dir:
		#DOWN:
			#animp.play("idleD")
		#UP:
			#animp.play("idleU")
		RIGHT:
			$Player.flip_h = false
			#animp.play("idle")
		LEFT:
			$Player.flip_h = true
			#animp.play("idle")
		DOWN_RIGHT:
			#animp.play("idleD")  # или создайте отдельную анимацию для диагонали
			$Player.flip_h = false
		DOWN_LEFT:
			#animp.play("idleD")
			$Player.flip_h = true
		UP_RIGHT:
			#animp.play("idleU")
			$Player.flip_h = false
		UP_LEFT:
			#animp.play("idleU")
			$Player.flip_h = true
