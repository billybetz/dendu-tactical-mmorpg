extends CharacterBody3D

var speed = 6

#@onready var floorTarget = $FloorTarget
@onready var navigationAgent: NavigationAgent3D = $NavigationAgent3D
#@onready var navigationAgent := NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (navigationAgent.is_navigation_finished()):
		return
		
	moveToPoints(delta, speed)
	pass

func moveToPoints(delta, speed):
	pass
	var targetPos = navigationAgent.get_next_path_position()
	
	var isReachable = navigationAgent.is_target_reachable()
	var finalPosition = navigationAgent.get_final_position()
	var isNavFinish = navigationAgent.is_navigation_finished()
	
	var direction = global_position.direction_to(targetPos)
	
	velocity = direction * speed
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("leftClick"):
		var camera = get_viewport().get_camera_3d()
		var mousePos = get_viewport().get_mouse_position()
		var rayLenght = 100
		var rayFrom = camera.project_ray_origin(mousePos)
		var rayTo = rayFrom + camera.project_ray_normal(mousePos) * rayLenght
		var rayQuery = PhysicsRayQueryParameters3D.new()
		print("rayFrom : ", rayFrom)
		print("rayTo : ", rayTo)
		rayQuery.from = rayFrom
		rayQuery.to = rayTo
		
		var space = get_world_3d().direct_space_state
		var result = space.intersect_ray(rayQuery)
		if result:
			navigationAgent.set_target_position(result.position)
			#show_debug_target(result.position)
			print("---------------------------------------------")
		else:
			print("no collision")

#func show_debug_target(target_pos: Vector3)->void:
	#floorTarget.position = target_pos
	#floorTarget.visible = true
#
#func hide_debug_target()->void:
	#floorTarget.visible = false
	
