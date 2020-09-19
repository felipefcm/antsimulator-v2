
var circleDistance := 50;
var circleRadius := 15;
var maxAngleChange := deg2rad(12);

func calculateSteeringForce(steeringObj, _target):

	if(!steeringObj.behaviourParams.has('wanderAngle')):
		steeringObj.behaviourParams.wanderAngle = rand_range(0, PI * 2);

	var wanderAngle = steeringObj.behaviourParams.wanderAngle;

	if(steeringObj.velocity.length() <= 5):
		steeringObj.velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1));
	
	var circleCenter = steeringObj.velocity.normalized() * circleDistance;
	var displacement = (Vector2(0, 1) * circleRadius).rotated(wanderAngle);

	steeringObj.behaviourParams.wanderAngle += rand_range(-maxAngleChange, maxAngleChange);
	
	return circleCenter + displacement;	
