extends CharacterBody2D

@export var speed := 120.0
@export var attack_time := 0.15
@export var sword_distance := 28.0

@onready var sword: Area2D = $SwordHitBox

var is_attacking := false
var facing := Vector2.RIGHT

func _ready():
	sword.hide()

func _physics_process(delta):
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			facing = Vector2(sign(direction.x), 0)
		else:
			facing = Vector2(0, sign(direction.y))

	sword.position = facing * sword_distance

	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

func attack():
	is_attacking = true
	sword.show()
	await get_tree().create_timer(attack_time).timeout
	sword.hide()
	is_attacking = false
