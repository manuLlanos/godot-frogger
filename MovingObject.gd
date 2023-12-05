extends Area2D
class_name MovingObject

# PARENT SHOULD ALWAYS BE A LANE NODE

@onready var parent = get_parent()
@onready var SPEED: float = parent.speed
@onready var direction: Vector2 = parent.direction

@onready var velocity: Vector2 = SPEED * direction

var tween: Tween

func _ready():
	if not parent is Lane:
		push_error("ERROR CREATING OBJECT: parent is NOT a lane")
		queue_free()

func _process(delta):
	position += velocity * delta


#position is relative to its parent, so simply make it zero
func _on_visible_on_screen_notifier_2d_screen_exited():
	position.x = 0

