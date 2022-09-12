// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/media/StageVideoAvailabilityReason.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.media
{
    
    
    public final class StageVideoAvailabilityReason
    {
        // Stage video is not currently available, the driver is too old or black listed
        public static const DRIVER_TOO_OLD:String = "driverTooOld";
        
        // Stage video is currently available, no errors occurred
        public static const NO_ERROR:String = "noError";
        
        // Stage video is not currently available, no hardware was available
        public static const UNAVAILABLE:String = "unavailable";
        
        // Stage video is not currently available, the user disabled HW acceleration
        public static const USER_DISABLED:String = "userDisabled";
        
        // Stage video is not currently available, the wmode doesn't support Stage video.
        public static const WMODE_INCOMPATIBLE:String = "wModeIncompatible";
        
        
    }
}