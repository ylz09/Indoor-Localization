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

package com.vrem.wifianalyzer;

import android.content.Context;
import android.net.wifi.WifiManager;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.util.Log;

import com.vrem.wifianalyzer.settings.Settings;
import com.vrem.wifianalyzer.vendor.model.Database;
import com.vrem.wifianalyzer.wifi.scanner.RssData;
import com.vrem.wifianalyzer.wifi.scanner.RssMap;
import com.vrem.wifianalyzer.vendor.model.VendorService;
import com.vrem.wifianalyzer.wifi.filter.adapter.FilterAdapter;
import com.vrem.wifianalyzer.wifi.scanner.Scanner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;

public enum MainContext {
    INSTANCE;

    private Settings settings;
    private MainActivity mainActivity;
    private Scanner scanner;
    private VendorService vendorService;
    private Database database;
    private RssMap rssMap;
    private Configuration configuration;
    private FilterAdapter filterAdapter;
    private Map<String, Integer> filterRss;

    public Map<String, Integer> getFilterRss()
    {return filterRss;}

    public Settings getSettings() {
        return settings;
    }

    void setSettings(Settings settings) {
        this.settings = settings;
    }

    public VendorService getVendorService() {
        return vendorService;
    }

    void setVendorService(VendorService vendorService) {
        this.vendorService = vendorService;
    }

    public Scanner getScanner() {
        return scanner;
    }

    void setScanner(Scanner scanner) {
        this.scanner = scanner;
    }

    public Database getDatabase() {
        return database;
    }

    public RssMap getRssMap() {
        //Test the database table
//        List<RssData> tmp = rssMap.findAll();
//        for (RssData r : tmp ){
//            Log.e(r.getLoc(),r.getRss());
//        }
        return rssMap;
    }

    void setDatabase(Database database) {
        this.database = database;
    }

    void setRssMap(RssMap rssMap) {
        this.rssMap = rssMap;
    }

    public MainActivity getMainActivity() {
        return mainActivity;
    }

    void setMainActivity(MainActivity mainActivity) {
        this.mainActivity = mainActivity;
    }

    public Configuration getConfiguration() {
        return configuration;
    }

    void setConfiguration(Configuration configuration) {
        this.configuration = configuration;
    }

    public FilterAdapter getFilterAdapter() {
        return filterAdapter;
    }

    void setFilterAdapter(FilterAdapter filterAdapter) {
        this.filterAdapter = filterAdapter;
    }

    void initRss(){
        filterRss =new HashMap<String,Integer>();
        filterRss.put("00:24:6c:0e:76:c0",1);
        filterRss.put("00:24:6c:0e:76:c1",2);
        filterRss.put("00:24:6c:0e:76:c8",3);
        filterRss.put("00:24:6c:0e:76:c9",4);
        filterRss.put("00:24:6c:0e:7d:21",5);
        filterRss.put("00:24:6c:0e:7d:28",6);
        filterRss.put("00:24:6c:0e:7d:29",7);
        filterRss.put("00:24:6c:0e:7e:11",8);
        filterRss.put("00:24:6c:0e:7e:18",9);
        filterRss.put("00:24:6c:0e:7e:19",10);
        filterRss.put("00:24:6c:10:9d:10",11);
        filterRss.put("00:24:6c:10:9d:11",12);
        filterRss.put("00:24:6c:10:9d:18",13);
        filterRss.put("00:24:6c:10:9d:19",14);
        filterRss.put("00:24:6c:10:9d:f0",15);
        filterRss.put("00:24:6c:10:9d:f1",16);
        filterRss.put("00:24:6c:10:9d:f8",17);
        filterRss.put("00:24:6c:10:9d:f9",18);
        filterRss.put("00:24:6c:10:9e:30",19);
        filterRss.put("00:24:6c:10:9e:31",20);
        filterRss.put("00:24:6c:10:9e:38",21);
        filterRss.put("00:24:6c:10:9e:39",22);
        filterRss.put("00:24:6c:10:9e:40",23);
        filterRss.put("00:24:6c:10:9e:41",24);
        filterRss.put("00:24:6c:10:9e:48",25);
        filterRss.put("00:24:6c:10:9e:49",26);
        filterRss.put("04:bd:88:1e:00:c0",27);
        filterRss.put("04:bd:88:1e:00:c1",28);
        filterRss.put("04:bd:88:1e:00:d0",29);
        filterRss.put("04:bd:88:1e:00:d1",30);
        filterRss.put("04:bd:88:20:07:e0",31);
        filterRss.put("04:bd:88:20:07:e1",32);
        filterRss.put("04:bd:88:20:07:f0",33);
        filterRss.put("04:bd:88:20:07:f2",34);
        filterRss.put("70:3a:0e:17:b7:60",35);
        filterRss.put("70:3a:0e:17:b7:61",36);
        filterRss.put("70:3a:0e:17:b7:70",37);
        filterRss.put("70:3a:0e:17:b7:71",38);
        filterRss.put("d8:c7:c8:a7:14:01",39);
        filterRss.put("d8:c7:c8:a7:15:b0",40);
        filterRss.put("d8:c7:c8:a7:15:b1",41);
        filterRss.put("d8:c7:c8:a7:15:b8",42);
        filterRss.put("d8:c7:c8:a7:15:b9",43);
        filterRss.put("d8:c7:c8:a7:15:f8",44);
        filterRss.put("d8:c7:c8:a7:15:f9",45);
        filterRss.put("d8:c7:c8:a7:16:18",46);
        filterRss.put("d8:c7:c8:a7:16:19",47);
        filterRss.put("d8:c7:c8:a7:1f:80",48);
        filterRss.put("d8:c7:c8:a7:1f:81",49);
        filterRss.put("d8:c7:c8:a7:1f:88",50);
        filterRss.put("d8:c7:c8:a7:1f:89",51);
        filterRss.put("84:16:f9:26:7d:bc",52);
        filterRss.put("84:16:f9:26:7b:7e",53);
    }

    void initialize(@NonNull MainActivity mainActivity, boolean largeScreen) {
        WifiManager wifiManager = (WifiManager) mainActivity.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        Handler handler = new Handler();
        Settings settings = new Settings(mainActivity);
        Configuration configuration = new Configuration(largeScreen);

        setMainActivity(mainActivity);
        setConfiguration(configuration);
        setDatabase(new Database(mainActivity));
        setRssMap(new RssMap(mainActivity));
        setSettings(settings);
        setVendorService(new VendorService());
        setScanner(new Scanner(wifiManager, handler, settings));
        setFilterAdapter(new FilterAdapter(settings));

        initRss();
    }

}
