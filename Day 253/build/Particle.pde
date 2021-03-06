class Particle{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan = (int)random(10,150);
//	int lifespan = 100;

	float minScale = 1;
	float maxScale = 100;
	float scaleNum = 3;

	PVector location;
	PVector velocity;
	PVector acceleration;

        PImage whichArt;

	float vx, vy, dx, dy;
	float spring = 0.5;
	float ease = 0.005;

	Particle(int i, int _finger_which, PVector _pt, color _clr ) {
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		vx = 0;
		vy = 0;
		dx = 0;
		dy = 0;
                
                whichArt = art[ (int)random(artnum) ];
		location = pt.get();
		velocity = new PVector( random(-3,3), random(-3,3), random(0,3) );
		acceleration = new PVector(0, 0.9);
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		dx = pt.x - (width/2);
		vx += (pt.x - (width/2)) * ease;
		vx *= spring;
		if(abs(dx)>1) location.x += vx;

		dy = pt.y - (height/2);
		vy += (pt.y - (height/2)) * ease;
		vy *= spring;
		if(abs(dy)>1) location.y += vy;

		container.beginDraw();

		maxScale -= scaleNum;
		if (maxScale<=minScale) maxScale = minScale;

		container.stroke(#000000); container.fill(clr);

		container.pushMatrix();
			container.translate(location.x, location.y, map(location.z,0,100,900,-900) );
			// container.rotate( radians( (map(location.z,0,100,-900,900)/2) - (lifespan*2) ) );

			container.rotate( radians( map(lifespan,0,100,0,720) + (lifespan*2) ) );

			container.tint( clr );

			container.image(whichArt,0,0);
		container.popMatrix();

		container.endDraw();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}
