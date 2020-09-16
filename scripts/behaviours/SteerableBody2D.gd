extends KinematicBody2D

export (int) var maxSpeed = 80;
export (float) var maxForce = 420;
export (NodePath) var targetNode;

var mode;
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
	behaviour = SteeringBehaviours.modes[mode];

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
