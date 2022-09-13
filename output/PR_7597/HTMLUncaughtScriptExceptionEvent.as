package flash.events
{
    
    public class HTMLUncaughtScriptExceptionEvent extends Event
    {
        public static const UNCAUGHT_SCRIPT_EXCEPTION:* = uncaughtScriptException; // [static] The HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION constant defines the value of the type property of an uncaughtScriptException event object.

        public var exceptionValue: *; // The result of evaluating the expression in the throw statement that resulted in the uncaught exception.
        public var stackTrace: Array; // An array of objects that represent the stack trace at the time the throw statement that resulted in the uncaught exception was executed.

        public function HTMLUncaughtScriptExceptionEvent(exceptionValue:*)
        {
            super();
            
        }
        

        // [override] Creates a copy of the HTMLUncaughtScriptExceptionEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new HTMLUncaughtScriptExceptionEvent(this.type,this.bubbles,this.cancelable);
        }
    }
}