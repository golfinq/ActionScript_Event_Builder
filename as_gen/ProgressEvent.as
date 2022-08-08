package flash.events
{
    
    public class ProgressEvent extends Event
    {
        public static const STANDARD_INPUT_PROGRESS:String = "standardInputProgress"; // [static] Defines the value of the type property of a progress event object.
        public static const SOCKET_DATA:String = "socketData"; // [static] Defines the value of the type property of a socketData event object.
        public static const STANDARD_ERROR_DATA:String = "standardErrorData"; // [static] Defines the value of the type property of a standardErrorData event object.
        public static const STANDARD_INPUT_PROGRESS:String = "standardInputProgress"; // [static] Defines the value of the type property of a standardInputProgress event object.
        public static const STANDARD_OUTPUT_DATA:String = "standardOutputData"; // [static] Defines the value of the type property of a standardOutputData event object.

        public var bytesLoaded: Number; // The number of items or bytes loaded when the listener processes the event.
        public var bytesTotal: Number; // The total number of items or bytes that will be loaded if the loading process succeeds.

        public function ProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:Number = 0, bytesTotal:Number = 0)
        {
            super(type,bubbles,cancelable);
            this.bytesLoaded = bytesLoaded;
            this.bytesTotal = bytesTotal;
        }
        

        // [override] Creates a copy of the ProgressEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new ProgressEvent(this.type, this.bubbles, this.cancelable, this.bytesLoaded, this.bytesTotal);
        }

        // [override] Returns a string that contains all the properties of the ProgressEvent object.
        override public function toString():String
        {
            return this.formatToString("ProgressEvent","type","bubbles","cancelable","eventPhase","bytesLoaded","bytesTotal");
        }
    }
}

