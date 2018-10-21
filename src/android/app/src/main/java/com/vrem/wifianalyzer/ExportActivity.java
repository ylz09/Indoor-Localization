package com.vrem.wifianalyzer;

import android.content.Intent;
import android.icu.util.Calendar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class ExportActivity extends AppCompatActivity {
    //private TextView nameText;
    private TextView sizeText;
    private TextView dataText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.export_layout);
        Intent intent = getIntent();
        //String name = intent.getStringExtra("DatabaseName");
        String size = intent.getStringExtra("databaseSize");
        String data = intent.getStringExtra("database");

//        nameText = (TextView) findViewById(R.id.name_result);
//        nameText.setText(name);

        sizeText = (TextView) findViewById(R.id.size_result);
        sizeText.setText(size);

        //Log.e("data:", data);
        dataText = (TextView) findViewById(R.id.data_result);
        dataText.setMovementMethod(new ScrollingMovementMethod());
        dataText.setText(data);

        //Toast.makeText(this,name,Toast.LENGTH_LONG).show();
    }
}
