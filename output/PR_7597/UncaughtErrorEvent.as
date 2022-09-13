package flash.events
{
    
    public class UncaughtErrorEvent extends ErrorEvent
    {
        public static const UNCAUGHT_ERROR:String = "uncaughtError"; // [static] Defines the value of the type property of an uncaughtError event object.

        private var _error: *; // [read-only] The error object associated with the uncaught error.

        public function UncaughtErrorEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = true, error_in:* = null)
        {
            super(type,bubbles,cancelable);
            
        }
        

        // [override] Creates a copy of the UncaughtErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new UncaughtErrorEvent(this.type,this.bubbles,this.cancelable,this.eventPhase,this.text,this.errorID);
        }

        // [override] Returns a string that contains all the properties of the UncaughtErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("UncaughtErrorEvent","type","bubbles","cancelable","eventPhase","text","error");
        }

        public function get error() : *
        {
            return this._error;
        }
        
    }
}