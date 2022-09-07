package flash.events
{
    
    import flash.display.InteractiveObject;
    
    public class ContextMenuEvent extends Event
    {
        public static const MENU_ITEM_SELECT:String = "menuItemSelect"; // [static] Defines the value of the type property of a menuItemSelect event object.
        public static const MENU_SELECT:String = "menuSelect"; // [static] Defines the value of the type property of a menuSelect event object.

        public var mouseTarget: InteractiveObject; // The display list object on which the user right-clicked to display the context menu.
        public var contextMenuOwner: InteractiveObject; // The display list object to which the menu is attached.
        public var isMouseTargetInaccessible: Boolean; // Indicates whether the mouseTarget property was set to null for security reasons.

        public function ContextMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null)
        {
            super(type,bubbles,cancelable);
            this.mouseTarget = mouseTarget;
            this.contextMenuOwner = contextMenuOwner;
        }
        

        // [override] Creates a copy of the ContextMenuEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ContextMenuEvent(this.type,this.bubbles,this.cancelable,this.mouseTarget,this.contextMenuOwner);
        }

        // [override] Returns a string that contains all the properties of the ContextMenuEvent object.
        override public function toString():String
        {
            return this.formatToString("ContextMenuEvent","type","bubbles","cancelable","eventPhase","mouseTarget","contextMenuOwner","isMouseTargetInaccessible");
        }
    }
}