public static final class Configuration {

	public static final class Palette {
		public static final int Background = 0xff0F0500;

		public static final class UI {

			public static final int Foreground = 0xff0F0500;

			public static final class Start {
				// Background colour of HUD
				public static final int Background = 0xff00BD20;
			}

			public static final class End {
				// Background colour of HUD
				public static final int Background = 0xff00BD20;
			}
		}

		public static final class Lights {
			// Left Light
			public static final int Left = 0xff1899cc;

			// Right Light
			public static final int Right = 0xff79bd8f;

			// Centre Light
			public static final int Centre = 0xffffff;
		}

		public static final class Mesh {
			// Wireframe colour
			public static final int Wireframe = 0xff808080;

			// Face colour
			public static final int Faces = 0xff808080;

			// Line colour
			public static final int Line = 0xff00D924;
		}
	}

	public static final class MIDI {
		// Approximate time to parse CSV file (milliseconds)
		public static final long StartOffset = 5000;

		// Time acceleration
		public static final long Acceleration = 7000;

		// BPM for time quantization
		public static final int BeatsPerMinute = 133;

		// Beats per bar X/4
		public static final float BeatsPerBar = 9;

		// 4/X
		public static final float BeatDivision = 8;

		// Decimal representaiton of BeatDivision
		public static final float[] NoteType = new float[] {
			QuantizationType.OneQuarterNote.get(),
			QuantizationType.OneQuarterNote.get(),
			QuantizationType.OneSixteenthNote.get(),
			QuantizationType.OneSixteenthNote.get(),
			QuantizationType.OneHalfNote.get(),
			QuantizationType.OneQuarterNote.get(),
			QuantizationType.OneQuarterNote.get(),
			QuantizationType.OneHalfNoteTriplet.get()
		};

		// Number of MIDI channels to use
		public static final int Channels = 13;


		public static final class Pitch {
			// Minimum pitch (0 - 127)
			public static final int Min = 20;

			// Maximum pitch (0 - 127)
			public static final int Max = 100;
		}

		public static final class Velocity {
			// Minimum velocity (0 - 127)
			public static final int Min = 20;

			// Maximum velocity (0 - 127)
			public static final int Max = 110;
		}


		public static final class Note {
			// Minimum note duration in milliseconds
			public static final int Min = 10;

			// Maximum note duration in milliseconds
			public static final int Max = 500;
		}
	}

	public static final class UI {
		// Debug flag. Hit 'd' key to enable.
		public static final boolean DEBUG = false;

		// Frames per second
		public static final int FPS = 60;


		public static final class HUD {
			// Size of the HUD font
			public static final int FontSize = 40;

			// The HUD font
			public static final String Font = "HelveticaNeue-Bold-42.vlw";
		}

		public static final int GridWidth = 100;

		public static final int Margin = 10;
	}

	public static final class Animation {
		public static final class Duration {
			// Minimum tween time
			public static final float Min = 0.5;

			// Maximum tween time
			public static final float Max = 2.0;
		}

		public static final class Scale {
			// Minimum tween scale factor
			public static final float Min = 1.0;

			// Maximum tween scale factor
			public static final float Max = 1.0;
		}

		// Rotation speed
		public static final float Speed = 0.01;


		public static final class Zoom {
			// Zoom time
			public static final float Time = 5.0;
		}
	}

	public static final class Optimisations {
		// In an effort to keep animation speed consistent, increase this number to group neighbouring points into a single point
		public static final float PointDistanceTolerance = 0.001;

		// Re-use existing points
		public static final boolean GroupPoints = false;
	}

	public static final class Mesh {
		// Size of the globe
		public static final int GlobeSize = 400;

		// Maximum amount of points to render
		public static final int MaxPoints = 7500;

		// Show bounding wireframe
		public static final boolean ShowWireframe = false;

		// Opacity of globe ( 0 - 255 )
		public static final int FillOpacity = 200;

		// Available types:
		// - Normal
		// - Dual
		// - Lattice
		// - Twisted
		// - Voronoi
		// - Extrude
		public static final MeshType Type = MeshType.Normal;

		// Available types:
		// - Edges
		// - Faces
		// - EdgesFaces
		// - Points
		// - EdgesPoints
		// - EdgesFacesPoints
		// - Lines
		// - Particles
		// - Rings

		public static final RenderType Renderer = RenderType.Rings;

		public static final boolean UseIcosahedronBase = false;

		public static final class Rings {
			// Distance between rings
			public static final int Distance = 8;

			// Rotation step
			public static final int RotationStep = 6;
		}
	}

	public static final class Data {
		public static final class Depth {
			public static final int Min = 0;

			public static final int Max = 1000;
		}

		public static final class Distance {
			public static final float Min = 0.9;

			public static final float Max = 1.1;
		}

		public static final String TimeZone = "Australia/Melbourne";
	}

	public static final class Timing {
		// Start date offset
		public static final String StartDate = "2017-05-01T00:00:00.000Z";

		// End date
		public static final String EndDate = "2017-05-31T23:59:59.999Z";
	}

	public static final class IO {
		// Save frames to disk
		public static final boolean SaveFrames = false;

		// CSV File
		public static final String CSV = "quakes.csv";
	}
}
