package flash.events
{
    
    public class SecurityErrorEvent extends ErrorEvent
    {
        public static const SECURITY_ERROR:String = "securityError"; // [static] The SecurityErrorEvent.SECURITY_ERROR constant defines the value of the type property of a securityError event object.

        

        public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
        {
            super(type,bubbles,cancelable,text,id);
            
        }
        

        // [override] Creates a copy of the SecurityErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SecurityErrorEvent(this.type,this.bubbles,this.cancelable,this.eventPhase,this.text,this.errorID);
        }

        // [override] Returns a string that contains all the properties of the SecurityErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("SecurityErrorEvent","type","bubbles","cancelable","eventPhase","text");
        }
    }
}