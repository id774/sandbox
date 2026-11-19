// Hello.as: Draw text on a Flash stage
//
// Description:
// Show a greeting text field on a 240 by 240 white SWF stage.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     mxmlc Hello.as
//
// Requirements:
// - The Flex SDK compiler (mxmlc) and Flash Player to run the SWF
//

package {
  import flash.display.*;
  import flash.text.*;

  [SWF(width=240,height=240, backgroundColor=0xFFFFFF)]

  public class Hello extends Sprite {
    public function Hello(){
      var label:TextField = new TextField();
      label.text = "String sample"
      label.x = 10;
      label.y = 10;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.selectable = false;

      var format:TextFormat = new TextFormat();
      format.color = 0xFF0000;
      format.font = "_sans";
      format.size = 24;
      label.setTextFormat(format);
      addChild(label);
    }
  }
}
