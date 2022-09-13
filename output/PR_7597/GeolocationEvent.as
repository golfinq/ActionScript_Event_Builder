package flash.events
{
    
    public class GeolocationEvent extends Event
    {
        public static const UPDATE:String = "update"; // [static] Defines the value of the type property of a GeolocationEvent event object.

        public var latitude: Number; // The latitude in degrees.
        public var longitude: Number; // The longitude in degrees.
        public var altitude: Number; // The altitude in meters.
        public var horizontalAccuracy: Number; // The horizontal accuracy in meters.
        public var verticalAccuracy: Number; // The vertical accuracy in meters.
        public var speed: Number; // The speed in meters/second.
        public var heading: Number; // The direction of movement (with respect to true north) in integer degrees.
        public var timestamp: Number; // The number of milliseconds at the time of the event since the runtime was initialized.

        public function GeolocationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, latitude:Number = 0, longitude:Number = 0, altitude:Number = 0, hAccuracy:Number = 0, vAccuracy:Number = 0, speed:Number = 0, heading:Number = 0, timestamp:Number = 0)
        {
            super(type,bubbles,cancelable);
            this.latitude = latitude;
            this.longitude = longitude;
            this.altitude = altitude;
            this.horizontalAccuracy = hAccuracy;
            this.verticalAccuracy = vAccuracy;
            this.speed = speed;
            this.heading = heading;
            this.timestamp = timestamp;
        }
        

        // [override] Creates a copy of the GeolocationEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new GeolocationEvent(this.type,this.bubbles,this.cancelable,this.latitude,this.longitude,this.altitude,this.horizontalAccuracy,this.verticalAccuracy,this.speed,this.heading,this.timestamp);
        }

        // [override] Returns a string that contains all the properties of the GeolocationEvent object.
        override public function toString():String
        {
            return this.formatToString("GeolocationEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}