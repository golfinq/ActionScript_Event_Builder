// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BlendMode.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.display
{

    public final class BlendMode
    {
        // Adds the values of the constituent colors of the display object to the colors of its background, applying a ceiling of 0xFF.
        public static const ADD:String = "add";

        // Applies the alpha value of each pixel of the display object to the background.
        public static const ALPHA:String = "alpha";

        // Selects the darker of the constituent colors of the display object and the colors of the background (the colors with the smaller values).
        public static const DARKEN:String = "darken";

        // Compares the constituent colors of the display object with the colors of its background, and subtracts the darker of the values of the two constituent colors from the lighter value.
        public static const DIFFERENCE:String = "difference";

        // Erases the background based on the alpha value of the display object.
        public static const ERASE:String = "erase";

        // Adjusts the color of each pixel based on the darkness of the display object.
        public static const HARDLIGHT:String = "hardlight";

        // Inverts the background.
        public static const INVERT:String = "invert";

        // Forces the creation of a transparency group for the display object.
        public static const LAYER:String = "layer";

        // Selects the lighter of the constituent colors of the display object and the colors of the background (the colors with the larger values).
        public static const LIGHTEN:String = "lighten";

        // Multiplies the values of the display object constituent colors by the constituent colors of the background color, and normalizes by dividing by 0xFF, resulting in darker colors.
        public static const MULTIPLY:String = "multiply";

        // The display object appears in front of the background.
        public static const NORMAL:String = "normal";

        // Adjusts the color of each pixel based on the darkness of the background.
        public static const OVERLAY:String = "overlay";

        // Multiplies the complement (inverse) of the display object color by the complement of the background color, resulting in a bleaching effect.
        public static const SCREEN:String = "screen";

        // Uses a shader to define the blend between objects.
        public static const SHADER:String = "shader";

        // Subtracts the values of the constituent colors in the display object from the values of the background color, applying a floor of 0.
        public static const SUBTRACT:String = "subtract";

    }
}
