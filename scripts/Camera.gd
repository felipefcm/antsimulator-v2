extends Node2D

onready var camera = $Camera2D;
export (float) var zoomSensibility = 0.08;
export (float) var moveSensibility = 6;

func _unhandled_input(event: InputEvent):

	if(event is InputEventMouseButton):
		if(event.is_action('ui_zoom_in')):
			camera.zoom += Vector2(-zoomSensibility, -zoomSensibility);
		elif(event.is_action('ui_zoom_out')):
			camera.zoom += Vector2(zoomSensibility, zoomSensibility);

func _process(_delta):
	
	var leftStr = Input.get_action_strength('ui_left');
	var rightStr = Input.get_action_strength('ui_right');
	var upStr = Input.get_action_strength('ui_up');
	var downStr = Input.get_action_strength('ui_down');

	var direction = Vector2(rightStr - leftStr, downStr - upStr);
	position = position + direction * moveSensibility;
