package flash.events
{
    
    public final class GameInputEvent extends Event
    {
        public static const DEVICE_ADDED:String = "deviceAdded"; // [static] Indicates that a compatible device has been connected or turned on.
        public static const DEVICE_REMOVED:String = "deviceRemoved"; // [static] Indicates that one of the enumerated devices has been disconnected or turned off.
        public static const DEVICE_UNUSABLE:String = "deviceUnusable"; // [static] Dispatched when a game input device is connected but is not usable.

        private var _device: GameInputDevice; // [read-only] Returns a reference to the device that was added or removed.

        public function GameInputEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, device:GameInputDevice = null)
        {
            super(type,bubbles,cancelable);
            this._device = device;
        }
        

        public function get device() : GameInputDevice
        {
            return this._device;
        }
        
    }
}