package flash.events
{
    
    public class DRMLicenseRequestEvent extends Event
    {
        public static const LICENSE_REQUEST:String = "licenseRequest"; // [static] The string constant to use for the license request event in the type parameter when adding and removing event listeners.

        public var serverURL: String; // The URL which will be used to communicate with the license server

        public function DRMLicenseRequestEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inServerURL:String = null)
        {
            super(type,bubbles,cancelable);
            this.serverURL = inServerURL;
        }
        

        // [override] Duplicates an instance of an Event subclass.
        override public function clone():Event
        {
            return new DRMLicenseRequestEvent(this.type,this.bubbles,this.cancelable,this.serverURL);
        }
    }
}