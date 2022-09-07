package flash.events
{
    
    import flash.display.InteractiveObject;
    
    public class MouseEvent extends Event
    {
        public static const RIGHT_CLICK:String = "rightClick"; // [static] Defines the value of the type property of a click event object.
        public static const CONTEXT_MENU:String = "contextMenu"; // [static] The MouseEvent.CONTEXT_MENU constant defines the value of the type property of a contextMenu event object.
        public static const DOUBLE_CLICK:String = "doubleClick"; // [static] Defines the value of the type property of a doubleClick event object.
        public static const MIDDLE_CLICK:String = "middleClick"; // [static] Defines the value of the type property of a middleClick event object.
        public static const MIDDLE_MOUSE_DOWN:String = "middleMouseDown"; // [static] Defines the value of the type property of a middleMouseDown event object.
        public static const MIDDLE_MOUSE_UP:String = "middleMouseUp"; // [static] Defines the value of the type property of a middleMouseUp event object.
        public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown"; // [static] Defines the value of the type property of a mouseDown event object.
        public static const MOUSE_MOVE:String = "mouseMove"; // [static] Defines the value of the type property of a mouseMove event object.
        public static const MOUSE_OUT:String = "mouseOut"; // [static] Defines the value of the type property of a mouseOut event object.
        public static const MOUSE_OVER:String = "mouseOver"; // [static] Defines the value of the type property of a mouseOver event object.
        public static const RIGHT_MOUSE_UP:String = "rightMouseUp"; // [static] Defines the value of the type property of a mouseUp event object.
        public static const MOUSE_WHEEL:String = "mouseWheel"; // [static] Defines the value of the type property of a mouseWheel event object.
        public static const RELEASE_OUTSIDE:String = "releaseOutside"; // [static] Defines the value of the type property of a releaseOutside event object.
        public static const RIGHT_CLICK:String = "rightClick"; // [static] Defines the value of the type property of a rightClick event object.
        public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown"; // [static] Defines the value of the type property of a rightMouseDown event object.
        public static const RIGHT_MOUSE_UP:String = "rightMouseUp"; // [static] Defines the value of the type property of a rightMouseUp event object.
        public static const ROLL_OUT:String = "rollOut"; // [static] Defines the value of the type property of a rollOut event object.
        public static const ROLL_OVER:String = "rollOver"; // [static] Defines the value of the type property of a rollOver event object.

        public var localX: Number; // When mouse locking is disabled, the horizontal coordinate at which the event occurred relative to the containing sprite.
        public var localY: Number; // When mouse locking is disabled, the vertical coordinate at which the event occurred relative to the containing sprite.
        public var relatedObject: InteractiveObject; // A reference to a display list object that is related to the event.
        public var ctrlKey: Boolean; // On Windows or Linux, indicates whether the Ctrl key is active (true) or inactive (false).
        public var altKey: Boolean; // Indicates whether the Alt key is active (true) or inactive (false).
        public var shiftKey: Boolean; // Indicates whether the Shift key is active (true) or inactive (false).
        public var buttonDown: Boolean; // Indicates whether the primary mouse button is pressed (true) or not (false).
        public var delta: int; // Indicates how many lines should be scrolled for each unit the user rotates the mouse wheel.
        public var commandKey: Boolean; // Indicates whether the command key is activated (Mac only.) The value of property commandKey will have the same value as property ctrlKey on the Mac.
        public var controlKey: Boolean; // Indicates whether the Control key is activated on Mac and whether the Ctrl key is activated on Windows or Linux.
        private var _clickCount: int; // [read-only] Indicates whether or not the mouse down event is part of a multi-click sequence.
        public var isRelatedObjectInaccessible: Boolean; // If true, the relatedObject property is set to null for reasons related to security sandboxes.
        public var movementX: Number; // When mouse locking is enabled, the change in mouse position in the X direction since the last mouse event.
        public var movementY: Number; // When mouse locking is enabled, the change in mouse position in the Y direction since the last mouse event.
        private var _stageX: Number; // [read-only] The horizontal coordinate at which the event occurred in global Stage coordinates.
        private var _stageY: Number; // [read-only] The vertical coordinate at which the event occurred in global Stage coordinates.

        public function MouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0, commandKey:Boolean = false, controlKey:Boolean = false, clickCount:int = 0)
        {
            super(type,bubbles,cancelable);
            this.localX = localX;
            this.localY = localY;
            this.relatedObject = relatedObject;
            this.ctrlKey = ctrlKey;
            this.altKey = altKey;
            this.shiftKey = shiftKey;
            this.buttonDown = buttonDown;
            this.delta = delta;
            this.commandKey = commandKey;
            this.controlKey = controlKey;
            this._clickCount = clickCount;
        }
        

        // [override] Creates a copy of the MouseEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new MouseEvent(this.type,this.bubbles,this.cancelable,this.localX,this.localY,this.relatedObject,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.delta,this.commandKey,this.controlKey,this.clickCount);
        }

        // [override] Returns a string that contains all the properties of the MouseEvent object.
        override public function toString():String
        {
            return this.formatToString("MouseEvent","type","bubbles","cancelable","eventPhase","localX","localY","relatedObject","ctrlKey","altKey","shiftKey","buttonDown","delta","commandKey","controlKey","clickCount","isRelatedObjectInaccessible","movementX","movementY","stageX","stageY");
        }

        // Instructs Flash Player or Adobe AIR to render after processing of this event completes, if the display list has been modified.
        public function updateAfterEvent():void
        {
            // Unknown Implementation
        }

        public function get clickCount() : int
        {
            return this._clickCount;
        }
        

        public function get stageX() : Number
        {
            return this._stageX;
        }
        

        public function get stageY() : Number
        {
            return this._stageY;
        }
        
    }
}