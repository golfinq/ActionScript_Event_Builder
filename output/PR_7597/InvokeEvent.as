package flash.events
{
    
    public class InvokeEvent extends Event
    {
        public static const INVOKE:String = "invoke"; // [static] The InvokeEvent.INVOKE constant defines the value of the type property of an InvokeEvent object.

        private var _arguments: Array; // [read-only] The array of string arguments passed during this invocation.
        private var _reason: String; // [read-only] The reason for this InvokeEvent.
        private var _currentDirectory: File; // [read-only] The directory that should be used to resolve any relative paths in the arguments array.

        public function InvokeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, dir:File = null, argv:Array = null, reason:String = "standard")
        {
            super(type,bubbles,cancelable,dir);
            this._arguments = argv;
            this._reason = reason;
        }
        

        // [override] Creates a new copy of this event.
        override public function clone():Event
        {
            return new InvokeEvent(this.type,this.bubbles,this.cancelable,this.arguments,this.reason);
        }

        public function get arguments() : Array
        {
            return this._arguments;
        }
        

        public function get reason() : String
        {
            return this._reason;
        }
        

        public function get currentDirectory() : File
        {
            return this._currentDirectory;
        }
        
    }
}