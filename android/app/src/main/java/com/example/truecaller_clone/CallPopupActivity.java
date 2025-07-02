package com.example.truecaller_clone;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class CallPopupActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        String callerNumber = getIntent().getStringExtra("CALLER_NUMBER");

        TextView textView = new TextView(this);
        textView.setText("Incoming call from: " + callerNumber);
        textView.setTextSize(24);
        setContentView(textView);
    }
}
