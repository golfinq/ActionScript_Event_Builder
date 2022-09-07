package flash.events
{
    
    public class NativeProcessExitEvent extends Event
    {
        public static const EXIT:String = "exit"; // [static] Defines the value of the type property of a exit event object.

        public var exitCode: Number; // The exit code that the native process returned to the host operating system when exiting.

        public function NativeProcessExitEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, exitCode:Number = NaN)
        {
            super(type,bubbles,cancelable);
            this.exitCode = exitCode;
        }
        

        // [override] Creates a copy of the NativeProcessExitEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new NativeProcessExitEvent(this.type,this.bubbles,this.cancelable,this.exitCode);
        }

        // [override] Returns a string that contains all the properties of the NativeProcessExitEvent object.
        override public function toString():String
        {
            return this.formatToString("NativeProcessExitEvent","type","bubbles","cancelable","eventPhase",exitCode);
        }
    }
}