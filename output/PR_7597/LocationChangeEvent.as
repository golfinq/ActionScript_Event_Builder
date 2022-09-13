package flash.events
{
    
    public class LocationChangeEvent extends Event
    {
        public static const LOCATION_CHANGE:String = "locationChange"; // [static] Dispatched after every location change.
        public static const LOCATION_CHANGING:String = "locationChanging"; // [static] The LOCATION_CHANGING constant defines the value of the type property LocationChangeEvent object dispatched before a change in page location.

        public var location: String; // The destination URL of the change.

        public function LocationChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, location:String = null)
        {
            super(type,bubbles,cancelable);
            this.location = location;
        }
        

        // [override]
        override public function clone():Event
        {
            return new LocationChangeEvent(this.type,this.bubbles,this.cancelable,this.location);
        }

        // [override] Returns a string that contains all the properties of the LocationChangeEvent object.
        override public function toString():String
        {
            return this.formatToString("LocationChangeEvent","type","bubbles","cancelable","eventPhase","location");
        }
    }
}