extends Area2D


@onready var ray: RayCast2D = $RayCast2D

@onready var moving: bool = false
@onready var alive: bool = true

##More is faster
@export var animation_speed: float = 8.0


var inputs = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

# dont move diagonally, and only move on single inputs so we do = instead of +=
func _unhandled_input(event):
	if moving or not alive:
		return
	for dir: String in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * Globals.TILE_SIZE
	ray.force_raycast_update()
	if not ray.is_colliding():
		#position += inputs[dir] * TILE_SIZE
		var tween = create_tween()
		tween.tween_property(self, "position",
		 position + inputs[dir] * Globals.TILE_SIZE, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false

func _process(_delta):
	#cheap solution to check for drowning/leaving logs into water
	# i just want to get this game done lmao
	if alive:
		var overlapping_areas: Array = get_overlapping_areas()
		if overlapping_areas.size() == 0:
			return
			# if NONE of the areas is NOT water
		if ! overlapping_areas.any(func(x): return !(x is Water)):
			drown()

func _on_area_entered(area):
	if alive and area.is_in_group("Vehicles"):
		splat()

func hit():
	alive = false
	$AnimationPlayer.play("death")

func splat():
	$Particles/BloodExplosion.emitting = true
	Sound.play("BodySplat")
	hit()

func drown():
	$Particles/WaterSplash.emitting = true
	Sound.play("WaterSplash")
	hit()
