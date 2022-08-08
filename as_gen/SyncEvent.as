package flash.events
{
    
    public class SyncEvent extends Event
    {
        public static const SYNC:String = "sync"; // [static] Defines the value of the type property of a sync event object.

        public var changeList: Array; // An array of objects; each object contains properties that describe the changed members of a remote shared object.

        public function SyncEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, changeList:Array = null)
        {
            super(type,bubbles,cancelable);
            this.changeList = changeList;
        }
        

        // [override] Creates a copy of the SyncEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SyncEvent(this.type, this.bubbles, this.cancelable, this.changeList);
        }

        // [override] Returns a string that contains all the properties of the SyncEvent object.
        override public function toString():String
        {
            return this.formatToString("SyncEvent","type","bubbles","cancelable","eventPhase", "changeList");
        }
    }
}

