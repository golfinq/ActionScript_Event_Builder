package flash.events
{
    
    public class FileListEvent extends Event
    {
        public static const DIRECTORY_LISTING:String = "directoryListing"; // [static] The FileListEvent.DIRECTORY_LISTING constant defines the value of the type property of the event object for a directoryListing event.
        public static const SELECT_MULTIPLE:String = "selectMultiple"; // [static] The FileListEvent.SELECT_MULTIPLE constant defines the value of the type property of the event object for a selectMultiple event.

        public var files: Array; // An array of File objects representing the files and directories found or selected.

        public function FileListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, files:Array = null)
        {
            super(type,bubbles,cancelable);
            this.files = files;
        }
        
    }
}