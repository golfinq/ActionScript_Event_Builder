// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/system/WorkerState.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.system
{

    public final class WorkerState
    {
        // This state indicates that an object that represents the new worker has been created, but the worker is not executing code.
        public static const NEW:String = "new";

        // This state indicates that the worker has begun executing application code and it has not been instructed to stop execution.
        public static const RUNNING:String = "running";

        // This state indicates that the worker has been stopped by code in another worker calling this Worker object's terminate() method.
        public static const TERMINATED:String = "terminated";

    }
}