package flash.events
{
    
    public class HTTPStatusEvent extends Event
    {
        public static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus"; // [static] Unlike the httpStatus event, the httpResponseStatus event is delivered before any response data.
        public static const HTTP_STATUS:String = "httpStatus"; // [static] The HTTPStatusEvent.HTTP_STATUS constant defines the value of the type property of a httpStatus event object.

        private var _status: int; // [read-only] The HTTP status code returned by the server.
        public var redirected: Boolean; // Indicates whether the request was redirected.
        public var responseHeaders: Array; // The response headers that the response returned, as an array of URLRequestHeader objects.
        public var responseURL: String; // The URL that the response was returned from.

        public function HTTPStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:int = 0, redirected:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this._status = status;
            this.redirected = redirected;
        }
        

        // [override] Creates a copy of the HTTPStatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new HTTPStatusEvent(this.type,this.bubbles,this.cancelable,this.status,this.redirected);
        }

        // [override] Returns a string that contains all the properties of the HTTPStatusEvent object.
        override public function toString():String
        {
            return this.formatToString("HTTPStatusEvent","type","bubbles","cancelable","eventPhase",status);
        }

        public function get status() : int
        {
            return this._status;
        }
        
    }
}