extends Camera3D

var player = preload("res://assets/Characters/player.tscn")
@onready var playerObj = $Player

func _input(event):
	if event.is_action_pressed("leftClick"):
		shoot_ray()

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 3000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	print("shoot ray : ", raycast_result)
	print("is empty ? ", raycast_result.is_empty())
	if !raycast_result.is_empty():
		var instance = player.instantiate()
		instance.position = raycast_result["position"]
		$'../'.add_child(instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
