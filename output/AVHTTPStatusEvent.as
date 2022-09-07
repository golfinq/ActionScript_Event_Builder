package flash.events
{
    
    public class AVHTTPStatusEvent extends Event
    {
        public static const AV_HTTP_RESPONSE_STATUS:String = "avHttpResponseStatus"; // [static] Unlike the httpStatus event, the httpResponseStatus event is delivered before any response data.

        private var _status: int; // [read-only] The HTTP status code returned by the server.
        public var responseURL: String; // The URL that the response was returned from.
        public var responseHeaders: Array; // The response headers that the response returned, as an array of URLRequestHeader objects.

        public function AVHTTPStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:int = 0, responseUrl:String = null, responseHeaders:Array = null)
        {
            super(type,bubbles,cancelable);
            this._status = status;
            this.responseURL = responseUrl;
            this.responseHeaders = responseHeaders;
        }
        

        // [override] Creates a copy of the AVHTTPStatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new AVHTTPStatusEvent(this.type,this.bubbles,this.cancelable,this.status,this.responseURL,this.responseHeaders);
        }

        // [override] Returns a string that contains all the properties of the AVHTTPStatusEvent object.
        override public function toString():String
        {
            return this.formatToString("AVHTTPStatusEvent","type","bubbles","cancelable","eventPhase",status);
        }

        public function get status() : int
        {
            return this._status;
        }
        
    }
}