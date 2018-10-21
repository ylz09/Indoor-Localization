package com.vrem.wifianalyzer.wifi.scanner;

import android.support.annotation.NonNull;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * Created by Yuan on 2017/6/19.
 */

public class RssData {
    private final String loc;
    private final String rss;
    //private final long id;

/*    RssData(long id, @NonNull String loc, @NonNull String rss) {
        this.id = id;
        this.rss = rss;
        this.loc = loc;
    }*/

    RssData(@NonNull String loc, @NonNull String rss) {
        this.rss = rss;
        this.loc = loc;
    }

/*    long getId() {
        return id;
    }*/

    public String getRss() {
        return rss;
    }

    public String getLoc() {
        return loc;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
