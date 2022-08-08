package flash.events
{
    
    public class DRMAuthenticationErrorEvent extends ErrorEvent
    {
        public static const AUTHENTICATION_ERROR:String = "authenticationError"; // [static] The string constant to use for the authentication error event in the type parameter when adding and removing event listeners.

        public var subErrorID: int; // A more detailed error code.
        public var serverURL: String; // The URL of the media rights server that rejected the authentication attempt.
        public var domain: String; // The content domain of the media rights server.

        public function DRMAuthenticationErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inDetail:String = "", inErrorID:int = 0, inSubErrorID:int = 0, inServerURL:String = null, inDomain:String = null)
        {
            super(type,bubbles,cancelable,inDetail,inErrorID);
            this.subErrorID = inSubErrorID;
            this.serverURL = inServerURL;
            this.domain = inDomain;
        }
        

        // [override] Creates a copy of the ErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMAuthenticationErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID, this.subErrorID, this.serverURL, this.domain);
        }
    }
}

