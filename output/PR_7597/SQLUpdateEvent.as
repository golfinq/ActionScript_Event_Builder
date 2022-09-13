package flash.events
{
    
    public class SQLUpdateEvent extends Event
    {
        public static const DELETE:String = "delete"; // [static] The SQLUpdateEvent.DELETE constant defines the value of the type property of a SQLConnection delete event.
        public static const INSERT:String = "insert"; // [static] The SQLUpdateEvent.INSERT constant defines the value of the type property of a SQLConnection insert event.
        public static const UPDATE:String = "update"; // [static] The SQLUpdateEvent.UPDATE constant defines the value of the type property of a SQLConnection update event.

        private var _table: String; // [read-only] The name of the table whose data change caused the event to be dispatched.
        private var _rowID: Number; // [read-only] The unique row identifier of the row that was inserted, deleted, or updated.

        public function SQLUpdateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, table:String = null, rowID:Number = 0)
        {
            super(type,bubbles,cancelable);
            this._table = table;
            this._rowID = rowID;
        }
        

        // [override] Creates a copy of the SQLUpdateEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SQLUpdateEvent(this.type,this.bubbles,this.cancelable,this.table,this.rowID);
        }

        public function get table() : String
        {
            return this._table;
        }
        

        public function get rowID() : Number
        {
            return this._rowID;
        }
        
    }
}