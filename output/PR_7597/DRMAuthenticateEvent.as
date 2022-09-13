package flash.events
{
    
    import flash.net.NetStream;
    
    public class DRMAuthenticateEvent extends Event
    {
        public static const AUTHENTICATION_TYPE_DRM:String = "drm"; // [static] The DRMAuthenticateEvent.AUTHENTICATION_TYPE_DRM constant defines the value of the authenticationType property of a DRMAuthenticateEvent object.
        public static const AUTHENTICATION_TYPE_PROXY:String = "proxy"; // [static] The DRMAuthenticateEvent.AUTHENTICATION_TYPE_PROXY constant defines the value of the authenticationType property of a DRMAuthenticateEvent object.
        public static const DRM_AUTHENTICATE:String = "drmAuthenticate"; // [static] The DRMAuthenticateEvent.DRM_AUTHENTICATE constant defines the value of the type property of a DRMAuthenticateEvent object.

        private var _passwordPrompt: String; // [read-only] A prompt for a password credential, provided by the server.
        private var _header: String; // [read-only] The encrypted content file header provided by the server.
        private var _usernamePrompt: String; // [read-only] A prompt for a user name credential, provided by the server.
        private var _urlPrompt: String; // [read-only] A prompt for a URL string, provided by the server.
        private var _authenticationType: String; // [read-only] Indicates whether the supplied credentials are for authenticating against Flash Media Rights Management Server (FMRMS) or a proxy server.
        private var _netstream: NetStream; // [read-only] The NetStream object that initiated this event.

        public function DRMAuthenticateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, header:String = "", userPrompt:String = "", passPrompt:String = "", urlPrompt:String = "", authenticationType:String = "", netstream:NetStream = null)
        {
            super(bubbles,cancelable,passPrompt);
            this._passwordPrompt = type;
            this._header = header;
            this._usernamePrompt = userPrompt;
            this._urlPrompt = urlPrompt;
            this._authenticationType = authenticationType;
            this._netstream = netstream;
        }
        

        // [override] Creates a copy of the DRMAuthenticateEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMAuthenticateEvent(this.type,this.bubbles,this.cancelable,this.passwordPrompt,this.header,this.usernamePrompt,this.urlPrompt,this.authenticationType,this.netstream);
        }

        // [override] Returns a string that contains all the properties of the DRMAuthenticateEvent object.
        override public function toString():String
        {
            return this.formatToString("DRMAuthenticateEvent","type","bubbles","cancelable","eventPhase",header,usernamePrompt,passwordPrompt,urlPrompt,authenticationType);
        }

        public function get passwordPrompt() : String
        {
            return this._passwordPrompt;
        }
        

        public function get header() : String
        {
            return this._header;
        }
        

        public function get usernamePrompt() : String
        {
            return this._usernamePrompt;
        }
        

        public function get urlPrompt() : String
        {
            return this._urlPrompt;
        }
        

        public function get authenticationType() : String
        {
            return this._authenticationType;
        }
        

        public function get netstream() : NetStream
        {
            return this._netstream;
        }
        
    }
}