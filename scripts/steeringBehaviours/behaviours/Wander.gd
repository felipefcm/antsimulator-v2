extends SteeringBehaviour

var circleDistance := 50;
var circleRadius := 15;
var maxAngleChange := deg2rad(12);

func calculateSteeringForce(body: SteerableBody2D, _target: Node2D):

	if(!body.behaviourParams.has('wanderAngle')):
		body.behaviourParams.wanderAngle = rand_range(0, PI * 2);

	var wanderAngle = body.behaviourParams.wanderAngle;

	if(body.velocity.length() <= 5):
		body.velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1));
	
	var circleCenter = body.velocity.normalized() * circleDistance;
	var displacement = (Vector2(0, 1) * circleRadius).rotated(wanderAngle);

	body.behaviourParams.wanderAngle += rand_range(-maxAngleChange, maxAngleChange);
	
	return circleCenter + displacement;
	
