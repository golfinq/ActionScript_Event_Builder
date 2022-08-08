package flash.events
{
    
    import flash.errors.SQLError;
    
    public class SQLErrorEvent extends ErrorEvent
    {
        public static const ERROR:String = "error"; // [static] The SQLErrorEvent.ERROR constant defines the value of the type property of an error event dispatched when a call to a method of a SQLConnection or SQLStatement instance completes with an error.

        public var _error: SQLError; // [read-only] A SQLError object containing detailed information about the cause of the error.

        public function SQLErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, error:SQLError = null)
        {
            super(type,bubbles,cancelable,error.details,error.detailID);
            this._error = error;
        }
        

        // [override] Creates a copy of the SQLErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SQLErrorEvent(this.type, this.bubbles, this.cancelable, this.error);
        }

        // [override] Returns a string that contains all the properties of the SQLErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("SQLErrorEvent","type","bubbles","cancelable","eventPhase","error");
        }

        public function get error() : SQLError
        {
            return this._error;
        }
        
    }
}

