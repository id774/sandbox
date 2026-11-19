// ImageCircle.as: Load an image into a circular mask
//
// Description:
// Load an image on a 320 by 240 SWF stage and display it through a circle.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     mxmlc ImageCircle.as
//
// Requirements:
// - The Flex SDK compiler (mxmlc) and Flash Player to run the SWF
//

package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;

  [SWF(width=320,height=240)]

  public class ImageCircle extends Sprite {
    private var l:Loader;
    private var b:BitmapData;

    public function ImageCircle() {
      l = new Loader();
      l.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
      l.load(new URLRequest("http://dl.dropbox.com/u/261861/img/flex.jpg"))
    }

    public function onImageLoad(e:Event):void {
      b = new BitmapData(l.width,l.height);
      b.draw(l);
      var bm:Bitmap = new Bitmap(b);
      addChild(l);
      //addChild(bm);
    }
  }
}
