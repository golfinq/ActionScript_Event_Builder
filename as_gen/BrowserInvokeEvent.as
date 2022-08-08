package flash.events
{
    
    public class BrowserInvokeEvent extends Event
    {
        public static const BROWSER_INVOKE:String = "browserInvoke"; // [static] The BrowserInvokeEvent.BROWSER_INVOKE constant defines the value of the type property of a BrowserInvokeEvent object.

        public var _arguments: Array; // [read-only] An array of arguments (strings) to pass to the application.
        public var _sandboxType: String; // [read-only] The sandbox type for the content in the browser.
        public var _securityDomain: String; // [read-only] The security domain for the content in the browser, such as "www.adobe.com" or "www.example.org".
        public var _isHTTPS: Boolean; // [read-only] Whether the content in the browser uses the HTTPS URL scheme (true) or not (false).
        public var _isUserEvent: Boolean; // [read-only] Whether the browser invocation resulted in a user event (such as a mouse click).

        public function BrowserInvokeEvent(type:String, bubbles:Boolean, cancelable:Boolean, arguments:Array, sandboxType:String, securityDomain:String, isHTTPS:Boolean, isUserEvent:Boolean)
        {
            super(type,bubbles,cancelable);
            this._arguments = arguments;
            this._sandboxType = sandboxType;
            this._securityDomain = securityDomain;
            this._isHTTPS = isHTTPS;
            this._isUserEvent = isUserEvent;
        }
        

        // [override] Creates a new copy of this event.
        override public function clone():Event
        {
            return new BrowserInvokeEvent(this.type, this.bubbles, this.cancelable, this.arguments, this.sandboxType, this.securityDomain, this.isHTTPS, this.isUserEvent);
        }

        public function get arguments() : Array
        {
            return this._arguments;
        }
        

        public function get sandboxType() : String
        {
            return this._sandboxType;
        }
        

        public function get securityDomain() : String
        {
            return this._securityDomain;
        }
        

        public function get isHTTPS() : Boolean
        {
            return this._isHTTPS;
        }
        

        public function get isUserEvent() : Boolean
        {
            return this._isUserEvent;
        }
        
    }
}

