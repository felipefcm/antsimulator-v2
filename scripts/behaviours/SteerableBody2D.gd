extends KinematicBody2D

export (String, 'None', 'Seek') var mode;

var Behaviours = {
	'None': null,
	'Seek': preload('res://scripts/behaviours/Seek.gd').new(),
	'Wander': preload('res://scripts/behaviours/Wander.gd').new(),
};

export (int) var maxSpeed = 80;
export (float) var maxForce = 420;
export (NodePath) var targetNode;

var velocity = Vector2.ZERO;
var target;

var maxSpeedOffset = 0;
var behaviourParams = {};

var behaviour;

func _ready():
	if(targetNode):
		target = get_node(targetNode);

func setMode(newMode):
	mode = newMode;
	behaviour = Behaviours[mode];

func setTarget(newTarget):
	target = newTarget;

func _physics_process(delta):
	
	if(behaviour):
		var steeringForce = behaviour.calculateSteeringForce(self, target);
		velocity = velocity + steeringForce.normalized() * maxForce * delta;
	else:
		velocity = Vector2.ZERO;

	rotation = velocity.angle();
	velocity = move_and_slide(velocity.normalized() * (maxSpeed + maxSpeedOffset));
