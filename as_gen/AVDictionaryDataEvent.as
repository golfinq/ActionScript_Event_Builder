package flash.events
{
    
    public class AVDictionaryDataEvent extends Event
    {
        public static const AV_DICTIONARY_DATA:String = "avDictionaryData"; // [static]

        public var _dictionary: Dictionary; // [read-only] Contains a dictionary of keys and values for the ID3 tags.
        public var _time: Number; // [read-only] The timestamp for the ID3 tag.

        public function AVDictionaryDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, init_dictionary:Dictionary = null, init_dataTime:Number = 0)
        {
            super(type,bubbles,cancelable);
            this._dictionary = init_dictionary;
            this._time = init_dataTime;
        }
        

        public function get dictionary() : Dictionary
        {
            return this._dictionary;
        }
        

        public function get time() : Number
        {
            return this._time;
        }
        
    }
}

