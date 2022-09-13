package flash.events
{
    
    public class EventDispatcher extends Object
    {
        

        

        public function EventDispatcher(target:IEventDispatcher = null)
        {
            super(target);
            
        }
        

        // Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            // Unknown Implementation
        }

        // Dispatches an event into the event flow.
        public function dispatchEvent(event:Event):Boolean
        {
            // Unknown Implementation
        }

        // Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
        public function hasEventListener(type:String):Boolean
        {
            // Unknown Implementation
        }

        // Removes a listener from the EventDispatcher object.
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            // Unknown Implementation
        }

        // Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
        public function willTrigger(type:String):Boolean
        {
            // Unknown Implementation
        }
    }
}