package flash.events
{
    
    public final class PermissionEvent extends Event
    {
        public static const PERMISSION_STATUS:String = "permissionStatus"; // [static]

        private var _status: String; // [read-only] Check whether the permission has been granted or denied.

        public function PermissionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = "denied")
        {
            super(type,bubbles,cancelable);
            this._status = status;
        }
        

        // [override] Creates a copy of an PermissionEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new PermissionEvent(this.type,this.bubbles,this.cancelable,this.status);
        }

        // [override] Returns a string that contains all the properties of the PermissionEvent object.
        override public function toString():String
        {
            return this.formatToString("PermissionEvent","type","bubbles","cancelable","eventPhase",status);
        }

        public function get status() : String
        {
            return this._status;
        }
        
    }
}