package flash.events
{
    
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    
    public class ShaderEvent extends Event
    {
        public static const COMPLETE:String = "complete"; // [static] Defines the value of the type property of a complete event object.

        public var bitmapData: BitmapData; // The BitmapData object that was passed to the ShaderJob.start() method.
        public var vector: Vector; // The Vector.<Number> object that was passed to the ShaderJob.start() method.
        public var byteArray: ByteArray; // The ByteArray object that was passed to the ShaderJob.start() method.

        public function ShaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bitmap:BitmapData = null, array:ByteArray = null, vector:Vector.<Number> = null)
        {
            super(type,bubbles,cancelable,array);
            this.bitmapData = bitmap;
            this.vector = vector;
        }
        

        // [override] Creates a copy of the ShaderEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ShaderEvent(this.type,this.bubbles,this.cancelable,this.bitmapData,this.vector);
        }

        // [override] Returns a string that contains all the properties of the ShaderEvent object.
        override public function toString():String
        {
            return this.formatToString("ShaderEvent","type","bubbles","cancelable","eventPhase",bitmapData,byteArray,vector);
        }
    }
}