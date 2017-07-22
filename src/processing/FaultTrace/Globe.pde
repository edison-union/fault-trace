public class Globe {
	ArrayList<GlobePoint> points;
	ArrayList<WB_Point4D> buffer;
	ArrayList<WB_Point4D> bufferBase;
	HEC_Geodesic creator;
	HE_Mesh icosahedron;
	List<WB_Coord> icosahedronPoints;

	GlobePoint point;
	int size;
	int newSize;
	int x;
	WB_Vector vec;

	public Globe( ArrayList<GlobePoint> points ) {
		this.points = points;
		this.creator = new HEC_Geodesic();
		this.creator.setRadius( Configuration.Mesh.GlobeSize);
		this.creator.setB( 3 );
		this.creator.setC( 3 );
		this.creator.setType( HEC_Geodesic.ICOSAHEDRON );
		this.icosahedron = new HE_Mesh( creator );
		this.icosahedronPoints = icosahedron.getPoints();
		this.fillBuffer();
	}

	public GlobePoint getExistingPoint( GlobePoint newPoint ) {
		if ( !Configuration.Optimisations.GroupPoints ) {
			return null;
		}

		size = this.points.size();

		for ( int x = 0 ; x < size ; x++ ) {
			point = this.points.get(x);
			vec = point.point.subToVector3D( newPoint.point );

			if (
				abs((float)vec.xd()) <= Configuration.Optimisations.PointDistanceTolerance &&
				abs((float)vec.yd()) <= Configuration.Optimisations.PointDistanceTolerance &&
				abs((float)vec.zd()) <= Configuration.Optimisations.PointDistanceTolerance
			) {
				return point;
			}
		}

		return null;
	}

	public HE_Mesh getGeodesic() {
		return this.icosahedron;
	}

	private void fillBuffer() {
		this.bufferBase = new ArrayList<WB_Point4D>();
		this.buffer = new ArrayList<WB_Point4D>();

		if ( Configuration.Mesh.UseIcosahedronBase ) {
			for ( WB_Coord coord : this.icosahedronPoints ) {
				this.bufferBase.add( new WB_Point4D( coord ) );
			}
		}
	}

	public WB_Point4D[] getPoints( int max ) {
		this.buffer.clear();
		this.buffer.addAll( this.bufferBase );
		GlobePoint point;
		newSize = this.bufferBase.size();
		size = this.points.size();

		for ( x = 0 ; x < size ; x++ ) {
			point = this.points.get(x);
			if ( point.canDisplay() ) {
				point.animate();
				this.buffer.add( point.getPoint() );
				newSize++;
			}
		}

		if ( newSize > max ) {
			for ( x = 0 ; x < newSize-max ; x++ ) {
				if ( x < size ) {
					point = this.points.get(x);

					if ( !point.isFinishing && !point.isFinished ) {
						point.remove();
					}

					if ( point.isFinished ) {
						this.points.remove( x );
					}
				}
			}
		}
		return this.buffer.toArray( new WB_Point4D[ newSize ] );
	}
}

public class GlobePoint {
	ArrayList<Long> delays;
	ArrayList<Float> animationTimes;
	ArrayList<Float> scales;
	ArrayList<Ani> animations;
	ArrayList<Float> distances;

	long delay;
	float animationTime;
	float scale;
	float distance;
	int ticks;
	boolean isFinished;
	boolean isFinishing;
	int index;
	WB_Point point;
	Ani animation;
	WB_Point4D point4D;

	public GlobePoint( WB_Point point ) {
		this.delays = new ArrayList<Long>();
		this.animationTimes = new ArrayList<Float>();
		this.scales = new ArrayList<Float>();
		this.animations = new ArrayList<Ani>();
		this.distances = new ArrayList<Float>();
		this.point = point;
		this.scale = 0.0;
		this.distance = 0.0;
		this.index = 0;
		this.isFinished = false;
		this.isFinishing = false;
		this.ticks = 0;
	}

	public void addDefaultScale( float scale ) {
		this.scale = scale;
	}

	public void addDelay( long delay ) {
		this.delays.add( delay );
	}

	public void addScale( float scale ) {
		this.scales.add( scale );
	}

	public void addAnimationTime( float animationTime ) {
		this.animationTimes.add( animationTime );
	}

	public void addDistance( float distance ) {
		this.distances.add( distance );
	}

	public void addAnimation( float scale, float distance, float animationTime ) {
		this.distance = distance;

	 	animation = new Ani( this, animationTime, "scale", scale, Ani.BOUNCE_OUT );
		animation.pause();

		this.animations.add( animation );

		animation = new Ani( this, animationTime * .36, "distance", 0.0, Ani.EXPO_OUT );
		animation.pause();

		this.animations.add( animation );

		animation = null;
	}

	public void remove() {
		this.isFinishing = true;
		this.isFinished = false;
		animation = new Ani( this, Configuration.Animation.Duration.Max, "scale", 0.0, Ani.EXPO_IN, "onEnd:onEnd" );
		animation.start();

		animation = new Ani( this, Configuration.Animation.Duration.Max, "distance", 0.0, Ani.EXPO_IN, "onEnd:onEnd" );
		animation.start();
	}

	public void onEnd() {
		this.isFinished = true;
		this.isFinishing = false;
	}

	public void onScaleEnd() {
		this.ticks = 1;
	}

	public boolean canDisplay() {
		for ( int x = this.delays.size()-1 ; x >= 0 ; x-- ) {
			delay = this.delays.get( x );
			animationTime = this.animationTimes.get( x );
			if ( millis() >= delay ) {
				this.index = x;
				return true;
			}
		}

		return false;
	}

	public void animate() {
		if ( this.ticks >= 1) {
			this.ticks += 1;
		}
		for ( int x = 0 ; x < 2 ; x++ ) {
			animation = this.animations.get( this.index + x );

			if ( animation != null ) {
				if ( !animation.isPlaying() && !animation.isEnded() ) {
					animation.resume();
				}
			}
		}
	}

	public WB_Point4D getPoint() {
		WB_Point4D point4D = new WB_Point4D( this.point.scale( this.scale ) );

		if ( Configuration.Mesh.Explosions.UseTicks ) {
			point4D.setW( this.ticks );
		} else {
			point4D.setW( this.distance );
		}

		return point4D;
	}
}
