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

package com.vrem.wifianalyzer.wifi.scanner;

import android.content.Context;
import android.icu.text.SimpleDateFormat;
import android.icu.util.Calendar;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.util.Log;
import android.widget.Toast;

import com.vrem.wifianalyzer.MainActivity;
import com.vrem.wifianalyzer.MainContext;
import com.vrem.wifianalyzer.settings.Settings;
import com.vrem.wifianalyzer.wifi.model.WiFiData;

import org.apache.commons.collections4.Closure;
import org.apache.commons.collections4.IterableUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.security.AccessController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.SortedMap;


@RequiresApi(api = Build.VERSION_CODES.N)
public class Scanner {
    private final List<UpdateNotifier> updateNotifiers;
    private final WifiManager wifiManager;
    private Transformer transformer;
    private WiFiData wiFiData;
    private Cache cache;
    private PeriodicScan periodicScan;

    //output the file
    //public String fileName = java.text.DateFormat.getDateTimeInstance().format(Calendar.getInstance().getTime())+".txt";
    public String fileName = "original.txt";
    public File outPut = new File(MainActivity.getContext().getExternalFilesDir(null),fileName);

    //store all data
    //public String allFile = java.text.DateFormat.getDateTimeInstance().format(Calendar.getInstance().getTime())+".all.txt";
    public String allFile = "all_data.txt";
    public File allOut = new File(MainActivity.getContext().getExternalFilesDir(null),allFile);

    //don't use databse, use file instead
    public String mapFile = "rss_map.txt";
    public File mapOut = new File(MainActivity.getContext().getExternalFilesDir(null),mapFile);

    //Timestampe of RssMap stands for the location
    public Long tsLong = System.currentTimeMillis()/1000;
    public String ts = tsLong.toString();


    public Scanner(@NonNull WifiManager wifiManager, @NonNull Handler handler, @NonNull Settings settings) {
        this.updateNotifiers = new ArrayList<>();
        this.wifiManager = wifiManager;
        this.wiFiData = WiFiData.EMPTY;
        this.setTransformer(new Transformer());
        this.setCache(new Cache());
        this.periodicScan = new PeriodicScan(this, handler, settings);
    }

    public void update() {
        performWiFiScan();
        IterableUtils.forEach(updateNotifiers, new UpdateClosure());
    }

    private void performWiFiScan() {
        List<ScanResult> scanResults = new ArrayList<>();
        WifiInfo wifiInfo = null;
        List<WifiConfiguration> configuredNetworks = null;
        try {
            if (!wifiManager.isWifiEnabled()) {
                wifiManager.setWifiEnabled(true);
            }
            if (wifiManager.startScan()) {
                scanResults = wifiManager.getScanResults();
            }
            wifiInfo = wifiManager.getConnectionInfo();
            configuredNetworks = wifiManager.getConfiguredNetworks();
        } catch (Exception e) {
            // critical error: set to no results and do not die
        }
        cache.add(scanResults);
        try {
            //orignal scan data
            FileWriter fileWriter = new FileWriter(outPut,true);
            BufferedWriter bufferWriter = new BufferedWriter(fileWriter);

            //all the AP data: bssid & tss
            FileWriter allWriter = new FileWriter(allOut,true);
            BufferedWriter allbufferWriter = new BufferedWriter(allWriter);
            //data format example: location|(bssid,val)(bssid,val)....
            allbufferWriter.write(MainContext.INSTANCE.getMainActivity().getLocation());
            allbufferWriter.write("|");

            //database file
            FileWriter mapWriter = new FileWriter(mapOut,true);
            BufferedWriter mapBufferWriter = new BufferedWriter(mapWriter);

            Map<String, Integer> filterRss = MainContext.INSTANCE.getFilterRss();
            String [] rss = new String[54];
            String rssStr = "";
            boolean empty = true;
            //bufferWriter.write("A new scan\n");
            for (ScanResult sr: scanResults)
            {
                if (//!Objects.equals(sr.SSID, "UDel") &&
                        //!Objects.equals(sr.SSID, "UDel Secure") &&
                        !Objects.equals(sr.SSID, "FAP1") &&
                        //!Objects.equals(sr.SSID, "FAP2") &&
                        !Objects.equals(sr.SSID, "test"))
                    continue;
                /*if (!Objects.equals(sr.SSID, "FAP1") &&
                        !Objects.equals(sr.SSID, "FAP2") && !Objects.equals(sr.SSID, "test") )
                    continue;*/
                //String res = "%-20s %-20s %-20s%n";
                //bufferWriter.write(String.format(res, sr.BSSID, sr.level, sr.SSID));
                String power=MainContext.INSTANCE.getMainActivity().getLocation();
                String res = "%-20s %-20s %-20s %-20s%n";
                bufferWriter.write(String.format(res, sr.BSSID, sr.level, sr.SSID, power));

                String pair = "(%s,%s)";
                allbufferWriter.write(String.format(pair,sr.BSSID,sr.level));
                //bufferWriter.newLine();

                //filter the rss vector by the map
                if(filterRss.containsKey(sr.BSSID))
                {
                    rss[filterRss.get(sr.BSSID)] = String.valueOf(sr.level);
                    empty = false;
                    //rssStr += sr.level + ",";
                }
            }
            allbufferWriter.newLine();
            allbufferWriter.close();
            bufferWriter.close();

            //inject the RssMap database
            for (int i = 1 ; i < 53 ;i++)
            {
                rssStr += rss[i] + ",";
            }
            rssStr += rss[53]; // The last element don't need ","

            RssMap rssMap = MainContext.INSTANCE.getRssMap();
            if (!empty) {
                //rssMap.insert(MainContext.INSTANCE.getMainActivity().getLocation(), rssStr);
                mapBufferWriter.write(MainContext.INSTANCE.getMainActivity().getLocation());
                mapBufferWriter.write("|");
                mapBufferWriter.write(rssStr);
                mapBufferWriter.newLine();
                //Log.e(ts, rssStr);
            }
            mapBufferWriter.close();
            //Log.e(MainContext.INSTANCE.getMainActivity().getLocation(), rssStr);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        wiFiData = transformer.transformToWiFiData(cache.getScanResults(), wifiInfo, configuredNetworks);
    }

    public WiFiData getWiFiData() {
        return wiFiData;
    }

    public void register(@NonNull UpdateNotifier updateNotifier) {
        updateNotifiers.add(updateNotifier);
    }

    public void unregister(@NonNull UpdateNotifier updateNotifier) {
        updateNotifiers.remove(updateNotifier);
    }

    public void pause() {
        periodicScan.stop();
    }

    public boolean isRunning() {
        return periodicScan.isRunning();
    }

    public void resume() {
        periodicScan.start();
    }

    PeriodicScan getPeriodicScan() {
        return periodicScan;
    }

    void setPeriodicScan(@NonNull PeriodicScan periodicScan) {
        this.periodicScan = periodicScan;
    }

    void setCache(@NonNull Cache cache) {
        this.cache = cache;
    }

    void setTransformer(@NonNull Transformer transformer) {
        this.transformer = transformer;
    }

    List<UpdateNotifier> getUpdateNotifiers() {
        return updateNotifiers;
    }

    private class UpdateClosure implements Closure<UpdateNotifier> {
        @Override
        public void execute(UpdateNotifier updateNotifier) {
            updateNotifier.update(wiFiData);
        }
    }
}
