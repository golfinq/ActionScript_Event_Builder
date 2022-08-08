package flash.events
{
    
    import flash.filesystem.File;
    import flash.filesystem.StorageVolume;
    
    public class StorageVolumeChangeEvent extends Event
    {
        public static const STORAGE_VOLUME_MOUNT:String = "storageVolumeMount"; // [static] The StorageVolumeChangeEvent.VOLUME_MOUNT constant defines the value of the type property of a StorageVolumeChangeEvent when a volume is mounted.
        public static const STORAGE_VOLUME_UNMOUNT:String = "storageVolumeUnmount"; // [static] The StorageVolumeChangeEvent.VOLUME_MOUNT constant defines the value of the type property of a StorageVolumeChangeEvent when a volume is unmounted.

        public var _rootDirectory: File; // [read-only] A File object corresponding to the root directory of the mounted volume.
        public var _storageVolume: StorageVolume; // [read-only] A StorageVolume object containing information about a mounted volume.

        public function StorageVolumeChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, path:File = null, volume:StorageVolume = null)
        {
            super(type,bubbles,cancelable);
            this._rootDirectory = path;
            this._storageVolume = volume;
            
        }
        

        // [override] Duplicates an instance of an Event subclass.
        override public function clone():Event
        {
            return new StorageVolumeChangeEvent(this.type, this.bubbles, this.cancelable, this.rootDirectory, this.storageVolume);
        }

        // [override] Returns a string containing all the properties of the Event object.
        override public function toString():String
        {
            return this.formatToString("StorageVolumeChangeEvent","type","bubbles","cancelable","eventPhase","rootDirectory","storageVolume");
        }

        public function get rootDirectory() : File
        {
            return this._rootDirectory;
        }
        

        public function get storageVolume() : StorageVolume
        {
            return this._storageVolume;
        }
        
    }
}

