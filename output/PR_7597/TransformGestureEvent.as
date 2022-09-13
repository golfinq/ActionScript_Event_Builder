package flash.events
{
    
    public class TransformGestureEvent extends GestureEvent
    {
        public static const GESTURE_DIRECTIONAL_TAP:String = "gestureDirectionalTap"; // [static] Defines the value of the type property of a GESTURE_DIRECTIONAL_TAP touch event object.
        public static const GESTURE_PAN:String = "gesturePan"; // [static] Defines the value of the type property of a GESTURE_PAN touch event object.
        public static const GESTURE_ROTATE:String = "gestureRotate"; // [static] Defines the value of the type property of a GESTURE_ROTATE touch event object.
        public static const GESTURE_SWIPE:String = "gestureSwipe"; // [static] Defines the value of the type property of a GESTURE_SWIPE touch event object.
        public static const GESTURE_ZOOM:String = "gestureZoom"; // [static] Defines the value of the type property of a GESTURE_ZOOM touch event object.

        public var scaleX: Number; // The horizontal scale of the display object, since the previous gesture event.
        public var scaleY: Number; // The vertical scale of the display object, since the previous gesture event.
        public var rotation: Number; // The current rotation angle, in degrees, of the display object along the z-axis, since the previous gesture event.
        public var offsetX: Number; // The horizontal translation of the display object, since the previous gesture event.
        public var offsetY: Number; // The vertical translation of the display object, since the previous gesture event.
        public var velocity: Number; // The velocity, in pixels per second, of the transform gesture event.

        public function TransformGestureEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, scaleX:Number = 1.0, scaleY:Number = 1.0, rotation:Number = 0, offsetX:Number = 0, offsetY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false, velocity:Number = 0)
        {
            super(type,bubbles,cancelable,phase,localX,localY,ctrlKey,altKey,shiftKey,commandKey,controlKey);
            this.scaleX = scaleX;
            this.scaleY = scaleY;
            this.rotation = rotation;
            this.offsetX = offsetX;
            this.offsetY = offsetY;
            this.velocity = velocity;
        }
        

        // [override] Creates a copy of the TransformGestureEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new TransformGestureEvent(this.localX,this.localY,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.scaleX,this.scaleY,this.rotation,this.offsetX,this.offsetY,this.velocity);
        }

        // [override] Returns a string that contains all the properties of the TransformGestureEvent object.
        override public function toString():String
        {
            return this.formatToString("TransformGestureEvent","localX","localY","ctrlKey","altKey","shiftKey","buttonDown","scaleX","scaleY","rotation","offsetX","offsetY","velocity");
        }
    }
}