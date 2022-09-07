package flash.events
{
    
    import flash.display.InteractiveObject;
    
    public class NativeDragEvent extends MouseEvent
    {
        public static const NATIVE_DRAG_COMPLETE:String = "nativeDragComplete"; // [static] NativeDragEvent.NATIVE_DRAG_COMPLETE defines the value of the type property of a nativeDragComplete event object.
        public static const NATIVE_DRAG_DROP:String = "nativeDragDrop"; // [static] NativeDragEvent.NATIVE_DRAG_DROP defines the value of the type property of a nativeDragDrop event object.
        public static const NATIVE_DRAG_ENTER:String = "nativeDragEnter"; // [static] NativeDragEvent.NATIVE_DRAG_ENTER defines the value of the type property of a nativeDragEnter event object.
        public static const NATIVE_DRAG_EXIT:String = "nativeDragExit"; // [static] NativeDragEvent.NATIVE_DRAG_EXIT defines the value of the type property of a nativeDragExit event object.
        public static const NATIVE_DRAG_OVER:String = "nativeDragOver"; // [static] NativeDragEvent.NATIVE_DRAG_OVER defines the value of the type property of a nativeDragOver event object.
        public static const NATIVE_DRAG_START:String = "nativeDragStart"; // [static] NativeDragEvent.NATIVE_DRAG_START defines the value of the type property of a nativeDragStart event object.
        public static const NATIVE_DRAG_UPDATE:String = "nativeDragUpdate"; // [static] NativeDragEvent.NATIVE_DRAG_UPDATE defines the value of the type property of a nativeDragUpdate event object.

        public var clipboard: Clipboard; // The Clipboard object containing the data in this drag operation.
        public var allowedActions: NativeDragOptions; // The NativeDragOptions object specifying the actions that are allowed by the display object that initiated this drag operation.
        public var dropAction: String; // The current action.

        public function NativeDragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, clipboard:Clipboard = null, allowedActions:NativeDragOptions = null, dropAction:String = null, controlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false)
        {
            super(type,bubbles,cancelable,localX,localY,relatedObject,controlKey,altKey,shiftKey,commandKey);
            this.clipboard = clipboard;
            this.allowedActions = allowedActions;
            this.dropAction = dropAction;
        }
        

        // [override] Creates a copy of this NativeDragEvent object.
        override public function clone():Event
        {
            return new NativeDragEvent(this.localX,this.localY,this.relatedObject,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.clipboard,this.allowedActions,this.dropAction);
        }

        // [override] Formats the properties of this NativeDragEvent object as a string.
        override public function toString():String
        {
            return this.formatToString("NativeDragEvent","clipboard","allowedActions","dropAction");
        }
    }
}