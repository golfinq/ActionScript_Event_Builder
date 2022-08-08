package flash.events
{
    
    public class TimerEvent extends Event
    {
        public static const TIMER_COMPLETE:String = "timerComplete"; // [static] Defines the value of the type property of a timer event object.
        public static const TIMER_COMPLETE:String = "timerComplete"; // [static] Defines the value of the type property of a timerComplete event object.

        

        public function TimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type,bubbles,cancelable);
            
        }
        

        // [override] Creates a copy of the TimerEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new TimerEvent(this.type, this.bubbles, this.cancelable);
        }

        // [override] Returns a string that contains all the properties of the TimerEvent object.
        override public function toString():String
        {
            return this.formatToString("TimerEvent","type","bubbles","cancelable","eventPhase");
        }

        // Instructs Flash Player or the AIR runtime to render after processing of this event completes, if the display list has been modified.
        public function updateAfterEvent():void
        {
            // Unknown Implementation
        }
    }
}

