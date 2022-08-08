package flash.events
{
    
    public class AccelerometerEvent extends Event
    {
        public static const UPDATE:String = "update"; // [static] Defines the value of the type property of a AccelerometerEvent event object.

        public var timestamp: Number; // The number of milliseconds at the time of the event since the runtime was initialized.
        public var accelerationX: Number; // Acceleration along the x-axis, measured in Gs.
        public var accelerationY: Number; // Acceleration along the y-axis, measured in Gs.
        public var accelerationZ: Number; // Acceleration along the z-axis, measured in Gs.

        public function AccelerometerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, timestamp:Number = 0, accelerationX:Number = 0, accelerationY:Number = 0, accelerationZ:Number = 0)
        {
            super(type,bubbles,cancelable);
            this.timestamp = timestamp;
            this.accelerationX = accelerationX;
            this.accelerationY = accelerationY;
            this.accelerationZ = accelerationZ;
        }
        

        // [override] Creates a copy of an AccelerometerEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new AccelerometerEvent(this.type, this.bubbles, this.cancelable, this.timestamp, this.accelerationX, this.accelerationY, this.accelerationZ);
        }

        // [override] Returns a string that contains all the properties of the AccelerometerEvent object.
        override public function toString():String
        {
            return this.formatToString("AccelerometerEvent","type","bubbles","cancelable","eventPhase","timestamp","accelerationX","accelerationY","accelerationZ");
        }
    }
}

