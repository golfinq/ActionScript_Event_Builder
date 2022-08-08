package flash.events
{
    
    public class DeviceRotationEvent extends Event
    {
        public static const UPDATE:String = "update"; // [static] Defines the value of the type property of a DeviceRotationEvent event object.

        public var timestamp: Number; // The number of milliseconds at the time of the event since the runtime was initialized.
        public var roll: Number; // Roll along the y-axis, measured in degrees.
        public var pitch: Number; // pitch along the x-axis, measured in degrees.
        public var yaw: Number; // yaw along the z-axis, measured in degrees.
        public var quaternion: Array; // Quaternion data for the device rotation in the [w, x, y, z] format.

        public function DeviceRotationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, timestamp:Number = 0, roll:Number = 0, pitch:Number = 0, yaw:Number = 0, quaternion:Array = null)
        {
            super(type,bubbles,cancelable);
            this.timestamp = timestamp;
            this.roll = roll;
            this.pitch = pitch;
            this.yaw = yaw;
            this.quaternion = quaternion;
        }
        

        // [override] Creates a copy of an DeviceRotationEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DeviceRotationEvent(this.type, this.bubbles, this.cancelable, this.timestamp, this.roll, this.pitch, this.yaw, this.quaternion);
        }

        // [override] Returns a string that contains all the properties of the DeviceRotationEvent object.
        override public function toString():String
        {
            return this.formatToString("DeviceRotationEvent","type","bubbles","cancelable","eventPhase","timestamp","roll","pitch","yaw","quaternion");
        }
    }
}

