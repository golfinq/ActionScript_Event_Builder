package flash.events
{
    
    public final class RemoteNotificationEvent extends Event
    {
        public static const NOTIFICATION:String = "notification"; // [static] Defines the value of the type property of a RemoteNotificationEvent event object.
        public static const TOKEN:String = "token"; // [static] Defines the value of the type property of a RemoteNotificationEvent event object.

        private var _data: Object; // [read-only] Contains a JSON-format notification payload.
        private var _tokenId: String; // [read-only] Cotains the tokenId received from APNs, used to identify the application.

        public function RemoteNotificationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:Object = null, tokenId:String = null)
        {
            super(type,bubbles,cancelable);
            this._data = data;
            this._tokenId = tokenId;
        }
        

        public function get data() : Object
        {
            return this._data;
        }
        

        public function get tokenId() : String
        {
            return this._tokenId;
        }
        
    }
}