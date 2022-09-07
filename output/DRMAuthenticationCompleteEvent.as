package flash.events
{
    
    import flash.utils.ByteArray;
    
    public class DRMAuthenticationCompleteEvent extends Event
    {
        public static const AUTHENTICATION_COMPLETE:String = "authenticationComplete"; // [static] The string constant to use for the authentication complete event in the type parameter when adding and removing event listeners.

        public var serverURL: String; // The URL of the media rights server.
        public var domain: String; // The content domain of the media rights server.
        public var token: ByteArray; // The authentication token.

        public function DRMAuthenticationCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inServerURL:String = null, inDomain:String = null, inToken:ByteArray = null)
        {
            super(type,bubbles,cancelable);
            this.serverURL = inServerURL;
            this.domain = inDomain;
            this.token = inToken;
        }
        

        // [override] Duplicates an instance of an Event subclass.
        override public function clone():Event
        {
            return new DRMAuthenticationCompleteEvent(this.type,this.bubbles,this.cancelable,this.serverURL,this.domain,this.token);
        }
    }
}