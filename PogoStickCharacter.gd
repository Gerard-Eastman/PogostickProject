extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var autoJump = true
var gravity = 700
var dontLeave = false
var prevVelocity = Vector2.ZERO
#write max velocity if on floor to allow slow sliding
#terminal velocity
#velocity = 0 when collide with ceiling

#code in rotational impulses when colliding, rotational velocity instead of directly changing angle

#variable set to true that determines if can jump, changed by canjump signals
var canJump = false
var rotationalVelocity = 0
var pivotPoint = Vector2.ZERO
var jumpVelocity = Vector2.ZERO
var jumpSpeedScale = 200
var preJump = false
var bounce = 0.2
var normal = Vector2.ZERO
var rotatedRad = 0
var rotationDirection = 0
#var relativeBounce = 0.2


func _ready():
	#$CanJump.connect("on_body_entered", on_jumpbox_entered)
	$PogoSprite.play("still")
	$PogoSprite.pause()
	

func _physics_process(delta):
	# Add the gravity.
	if(is_on_ceiling()):
		#no need to account for angle, ceilings always horizontal
		if prevVelocity.y < 0:
			velocity.y =  abs(prevVelocity.y * bounce)
		velocity.x = prevVelocity.x
		velocity.y += gravity*delta
		
		
	elif (!is_on_floor()):
		if(is_on_wall() && !canJump):
			#vector math for reflection
			normal = get_wall_normal()
			#velocity = velocity - (2*prevVelocity.dot(normal)*normal)
			#velocity *= bounce
			#velocity *= ((PI - abs(prevVelocity.angle_to(velocity)))/PI)*0.5  + 0.5
			
			#method 2
			#relativeBounce = 1 - normal.project(prevVelocity).length()
			#print(relativeBounce)
			normal = normal.rotated(PI/2)
			velocity = prevVelocity
			rotatedRad = 2*(velocity.angle_to(normal))
			velocity = velocity.rotated(rotatedRad)
			rotatedRad = velocity.angle_to(prevVelocity)
			rotatedRad = cos(abs(rotatedRad*5/12))
			#rotatedRad = (rotatedRad +2)/3
			#print(rotatedRad)
			velocity *= rotatedRad
			#print(velocity.x)
			if(velocity.x >10 ):
				velocity.x = clamp(velocity.x, 200, 1000)
			elif(velocity.x < -10):
				velocity.x = clamp(velocity.x, -1000, -200)
			#print(velocity.x)
			#bounce moddifier here, based off of rotatedRad (need standardization)
		if(is_on_wall() && canJump):
			velocity = get_position_delta()/delta
			
		
		velocity.y += gravity * delta
	elif (is_on_floor()):
		
		velocity.x -= 0.5*prevVelocity.x*delta
		if(canJump): 
			velocity.x = 0
			velocity.y = 0
		else:
			velocity.y = prevVelocity.y* -0.2
		
	if ((Input.is_action_pressed("down") || autoJump) && !canJump):
		preJump = true
	elif(!canJump):
		preJump = false
	# Handle jump.
	#maybe make it so that up key releases jump? would give more time to aim
	if((Input.is_action_just_pressed("down") ) || preJump) && canJump:
		$PogoSprite.play("compressing")
		preJump = false
		#hitbox changes would go here
		
	elif ((((!autoJump && Input.is_action_just_released("down")) || !canJump) && ($PogoSprite.get_frame() > 0)) || $PogoSprite.get_frame() >=14):
		
		jumpVelocity = ($CenterOfMass.global_position - global_position).normalized()
		jumpVelocity *= jumpSpeedScale * sqrt($PogoSprite.get_frame())
		
		$PogoSprite.play("still")
		$PogoSprite.pause()
		
		velocity = jumpVelocity
	
		
		
	#var pivotNode = $CenterOfMass
	
	rotationDirection = Input.get_axis("rotate_counterclockwise", "rotate_clockwise")
	if(Input.is_action_pressed("slow_turn")):
		rotationDirection /= 2
	#determine pivot
	if(canJump):
		rotation_degrees += rotationDirection *delta * 80
	elif(!is_on_wall()):
		#pivotPoint = $CenterOfMass.global_position
		#rotation_degrees += rotationDirection *delta * 170
		#pivotPoint -= $CenterOfMass.global_position
		#global_position += pivotPoint
		pivot_about($CenterOfMass, delta)
	elif(is_on_wall_only()):
		var lastCollision = get_last_slide_collision().get_position()
		if ($RightPivot.global_position.distance_to(lastCollision)) < ($LeftPivot.global_position.distance_to(lastCollision)):
			pivot_about($RightPivot, delta)
		#maybe for when distance is equal, rotate about pivot depending on direction
		else:
			pivot_about($LeftPivot, delta)
	
		

	#rotationalVelocity = rotationDirection * 100
	#rotation_degrees = rotationDirection *delta * 100
		
	#move to pivot point pre rotation
	
		
	#velocity.x = move_toward(velocity.x, 0, SPEED)
	#rotation_degrees += rotationalVelocity * delta 
	prevVelocity = velocity
	move_and_slide()
	
func on_jumpbox_entered(_garb):

	canJump = true
	
	
	
func on_jumpbox_exited(_garb):
	canJump = false
	
	

	
func pivot_about(rotationNode, delta):
	var wallPivot = rotationNode.global_position
	rotation_degrees += rotationDirection *delta * 170
	wallPivot -= rotationNode.global_position
	global_position += wallPivot
	

	

#func rotate_around(pivotNode2D, rotationDirection, delta):
	#pivotPoint = pivotNode2D.global_position
	#rotation_degrees += rotationDirection * delta
	#rotation_degrees 
