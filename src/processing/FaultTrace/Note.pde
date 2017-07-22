public class Note extends Thread {
	int channel;
	int velocity;
	int pitch;
	long duration;
	long delay;
	MidiBus bus;

	Note(MidiBus bus) {
		this.bus = bus;
	}

	public synchronized void run() {
		try {
			bus.sendNoteOn( this.channel, this.pitch, this.velocity );

			if ( duration > 0 ) {
				Thread.sleep( duration ) ;
			}

			bus.sendNoteOff( this.channel, this.pitch, this.velocity );

		}
		catch( Exception e ) {
			println( e );
		}
	}
}
