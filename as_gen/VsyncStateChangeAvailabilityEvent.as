package flash.events
{
    
    public class VsyncStateChangeAvailabilityEvent extends Event
    {
        public static const VSYNC_STATE_CHANGE_AVAILABILITY:String = "vSyncStateChangeAvailability"; // [static] Defines the value of the type property of a VsyncStateChangeAvailabilityEvent event object.

        public var _available: Boolean; // [read-only] Indicate that vsync state of Stage is changeable.

        public function VsyncStateChangeAvailabilityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, available:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this._available = available;
        }
        

        // [override] Creates a copy of an VsyncStateChangeAvailabilityEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new VsyncStateChangeAvailabilityEvent(this.type, this.bubbles, this.cancelable, this.available);
        }

        // [override] Returns a string that contains all the properties of the VsyncStateChangeAvailabilityEvent object.
        override public function toString():String
        {
            return this.formatToString("VsyncStateChangeAvailabilityEvent","type","bubbles","cancelable","eventPhase","available");
        }

        public function get available() : Boolean
        {
            return this._available;
        }
        
    }
}

