package flash.events
{
    
    public class ActivityEvent extends Event
    {
        public static const ACTIVITY:String = "activity"; // [static] The ActivityEvent.ACTIVITY constant defines the value of the type property of an activity event object.

        public var activating: Boolean; // Indicates whether the device is activating (true) or deactivating (false).

        public function ActivityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, activating:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this.activating = activating;
        }
        

        // [override] Creates a copy of an ActivityEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ActivityEvent(this.type, this.bubbles, this.cancelable, this.activating);
        }

        // [override] Returns a string that contains all the properties of the ActivityEvent object.
        override public function toString():String
        {
            return this.formatToString("ActivityEvent","type","bubbles","cancelable","eventPhase","activating");
        }
    }
}

