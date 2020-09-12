
func calculateSteeringForce(steeringObj, target):
	
	var desiredVelocity = target.global_position - steeringObj.global_position;
	desiredVelocity = desiredVelocity.normalized() * steeringObj.maxSpeed;

	return desiredVelocity - steeringObj.velocity;
