/*
 * WiFiAnalyzer
 * Copyright (C) 2017  VREM Software Development <VREMSoftwareDevelopment@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

package com.vrem.wifianalyzer.menu;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.CountDownTimer;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.vrem.wifianalyzer.ExportActivity;
import com.vrem.wifianalyzer.MainActivity;
import com.vrem.wifianalyzer.MainContext;
import com.vrem.wifianalyzer.R;
import com.vrem.wifianalyzer.wifi.filter.Filter;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.input.ReversedLinesFileReader;

import static android.R.attr.lines;

public class OptionMenu {
    private Menu menu;
    private boolean timing = false; // for timer

    public void create(@NonNull Activity activity, Menu menu) {
        activity.getMenuInflater().inflate(R.menu.optionmenu, menu);
        this.menu = menu;

    }

    public void clock() {
        if (timing) return;
        timing = true;
        final MenuItem  counter = menu.findItem(R.id.counter);
        counter.setTitle("60s");
        CountDownTimer Timer = new CountDownTimer(60000, 1000) {
            public void onTick(long millisUntilFinished) {
                long millis = millisUntilFinished;
                String  ms = ""+(
                        (TimeUnit.MILLISECONDS.toMinutes(millis) -
                                TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(millis)))+":"+
                                (TimeUnit.MILLISECONDS.toSeconds(millis) -
                                        TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))));
                counter.setTitle(ms);
                //timer = millis;
            }

            public void onFinish() {
                counter.setTitle("done!");
                timing = false;

                Uri uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);//系统自带提示音
                Ringtone rt = RingtoneManager.getRingtone(MainContext.INSTANCE.getMainActivity(), uri);
                rt.play();

                AlertDialog.Builder dlgAlert  = new AlertDialog.Builder(MainContext.INSTANCE.getMainActivity());
                dlgAlert.setMessage("Click InputLocation next!");
                dlgAlert.setTitle("");
                dlgAlert.setPositiveButton("OK", null);
                dlgAlert.setCancelable(true);
                dlgAlert.create().show();
            }
        };
        Timer.start();
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void select(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.counter:
                clock();
                break;

            case R.id.action_scanner:
                if (MainContext.INSTANCE.getScanner().isRunning()) {
                    pause();
                } else {
                    resume();
                }
                break;

            case R.id.action_filter:
                Filter.build().show();
                break;

            case R.id.action_input_location:
                //Toast.makeText(MainContext.INSTANCE.getMainActivity(),"Where are you?", Toast.LENGTH_LONG).show();
                MainActivity mainActivity = MainContext.INSTANCE.getMainActivity();
                View view = mainActivity.getLayoutInflater().inflate(R.layout.input_location, null);
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(mainActivity);
                alertDialogBuilder.setView(view);
                final EditText editText = (EditText) view.findViewById(R.id.edittext);

                //stop the scanner
                if (MainContext.INSTANCE.getScanner().isRunning()) {
                    pause();
                }
                // setup a dialog window
                alertDialogBuilder.setCancelable(false)
                        .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                //set the database field
                                String loc = editText.getText().toString();
                                MainContext.INSTANCE.getMainActivity().setLocation(loc);

                                //recover scanning and prompt some message!
                                if (!(MainContext.INSTANCE.getScanner().isRunning())) resume();
                                Toast t = Toast.makeText(MainContext.INSTANCE.getMainActivity(),"NewLocation: " + loc, Toast.LENGTH_LONG);
                                t.setGravity(Gravity.CENTER,0,0);
                                t.show();
                                clock();

                            }
                        })
                        .setNegativeButton("Cancel",
                                new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                        dialog.cancel();
                                    }
                                });

                // create an alert dialog
                AlertDialog alert = alertDialogBuilder.create();
                alert.show();

                //resume();
                break;

            case R.id.action_output_database:

                Intent intent = new Intent(MainContext.INSTANCE.getMainActivity(), ExportActivity.class);
                //How to pass the database for output?
                //intent.putExtra("DatabaseName", MainContext.INSTANCE.getRssMap().getDatabaseName());

                //intent.putExtra("database",MainContext.INSTANCE.getRssMap().getStringResult());
                //Don't use database anymore, here is just for output the snapshot of the result file
                File map = MainContext.INSTANCE.getScanner().mapOut;
                ReversedLinesFileReader outpter = null;
                String line120 = "";
                try {
                    outpter = new ReversedLinesFileReader(map);
                    for (int i = 0 ; i < 60 ; i++) line120 += outpter.readLine()+"\n";
                } catch (IOException e) {
                    e.printStackTrace();
                }
                intent.putExtra("database",line120);

                //Number of record in the database(file)
                LineNumberReader lnr = null;
                try {
                    lnr = new LineNumberReader(new FileReader(map));
                    try {
                        lnr.skip(Long.MAX_VALUE);
                        // Finally, the LineNumberReader object should be closed to prevent resource leak
                        intent.putExtra("databaseSize",Integer.toString((lnr.getLineNumber()+ 1)/2));
                        lnr.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }


                MainContext.INSTANCE.getMainActivity().startActivity(intent);

/*              String fileName = "rssmap.db.txt";
                File outPut = new File(MainActivity.getContext().getExternalFilesDir(null),fileName);
                outPut.delete();
                try {
                    FileWriter fileWriter = new FileWriter(outPut,true);
                    BufferedWriter bufferWriter = new BufferedWriter(fileWriter);
                    bufferWriter.write(MainContext.INSTANCE.getRssMap().getStringResult());
                    bufferWriter.close();
                    //MainContext.INSTANCE.getMainActivity().pre = MainContext.INSTANCE.getMainActivity().cur;
                } catch (IOException e) {
                    e.printStackTrace();
                }*/
                break;

/*          //Don't use database in this case, but for app itself database is much efficient than files!!!
            case R.id.action_delete_database:
                MainContext.INSTANCE.getRssMap().deleteAll();
                //Hint that DB is empty!
                Toast t = Toast.makeText(MainContext.INSTANCE.getMainActivity(),"DB is empty!", Toast.LENGTH_SHORT);
                t.setGravity(Gravity.CENTER,0,0);
                t.show();
                break;*/

            default:
                // do nothing
                break;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void pause() {
        MainContext.INSTANCE.getScanner().pause();
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void resume() {
        MainContext.INSTANCE.getScanner().resume();
    }

    public Menu getMenu() {
        return menu;
    }

}
