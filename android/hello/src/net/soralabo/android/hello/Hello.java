package net.soralabo.android.hello;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class Hello extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        Button b = (Button)findViewById(R.id.hello_button);
        b.setOnClickListener(new HelloClickListener());
    }

    class HelloClickListener implements OnClickListener {
      @Override
      public void onClick(View v){
        /** Write what to do when button clicked */
        TextView t = (TextView)findViewById(R.id.hello_label);
        t.setText("Hello, android");
      }
    }
}
