package com.vrem.wifianalyzer.wifi.scanner;

import android.database.sqlite.SQLiteOpenHelper;
import android.provider.BaseColumns;

/**
 * Created by Yuan on 2017/6/19.
 */
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.provider.BaseColumns;
import android.support.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

public class RssMap extends SQLiteOpenHelper implements BaseColumns {

    static final String TABLE_NAME = "rssmap";
    static final String COLUMN_LOC = "location";
    static final String COLUMN_RSS = "rss";
    static final String[] ALL_COLUMNS = new String[]{_ID, COLUMN_LOC, COLUMN_RSS};
    static final String SORT_ORDER = COLUMN_LOC + "," + COLUMN_RSS + "," + _ID;
    static final String TABLE_CREATE = "CREATE TABLE IF NOT EXISTS " + TABLE_NAME + " ("
            + _ID + " INTEGER PRIMARY KEY AUTOINCREMENT,"
            + COLUMN_LOC + " TEXT NOT NULL,"
            + COLUMN_RSS + " TEXT NOT NULL)";
    static final String TABLE_DROP = "DROP TABLE IF EXISTS " + TABLE_NAME;

    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "RssMap.db";
    private String strRes = "";

    public RssMap(@NonNull Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(TABLE_CREATE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL(TABLE_DROP);
        onCreate(db);
    }

    public long insert(String loc, String rss) {
        SQLiteDatabase db = getWritableDatabase();
        //ContentValues values = getContentValues();
        ContentValues values = new ContentValues();
        values.put(COLUMN_LOC, loc);
        values.put(COLUMN_RSS, rss);
        //return db.insert(TABLE_NAME, null, values);
        return db.replace(TABLE_NAME, null, values);
    }

    public ContentValues getContentValues() {
        return new ContentValues();
    }

    public void deleteAll()
    {
        SQLiteDatabase db = getReadableDatabase();
        db.execSQL("delete from "+ TABLE_NAME);
    }

    public void delete(String id)
    {
        String[] args={id};
        getWritableDatabase().delete("texts", "_ID=?", args);
    }

    public String find(String loc) {
        String result = null;
        SQLiteDatabase db = getReadableDatabase();

        Cursor cursor = db.query(
                TABLE_NAME,
                new String[]{COLUMN_RSS},
                COLUMN_LOC + "=?",
                new String[]{loc},
                null, null, null,null);
        if (cursor.moveToFirst()) {
            result = cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_LOC));
        }
        cursor.close();
        return result;
    }

    public List<RssData> findAll() {

        List<RssData> results = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor cursor = db.query(TABLE_NAME, ALL_COLUMNS, null, null, null, null, SORT_ORDER);
        if (cursor.moveToFirst()) {
            while (!cursor.isAfterLast()) {
                RssData rssData = new RssData(
                        cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_LOC)),
                        cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_RSS)));
                results.add(rssData);
//                strRes = cursor.getString(cursor.getColumnIndexOrThrow(_ID)) + ": "+"["+cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_LOC))+"]"+"\n"+
//                        cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_RSS)) + "\n" + strRes;
                cursor.moveToNext();

            }
        }
        cursor.close();
        return results;
    }

    public String getStringResult()
    {
        strRes="";
        SQLiteDatabase db = getReadableDatabase();
        String orderBy = _ID + " DESC";
        Cursor cursor = db.query(TABLE_NAME, ALL_COLUMNS, null, null, null, null, orderBy, null);
        if (cursor.moveToFirst()) {
            while (!cursor.isAfterLast()) {
                strRes += cursor.getString(cursor.getColumnIndexOrThrow(_ID)) + ": "+"["+cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_LOC))+"]"+"\n"+
                        cursor.getString(cursor.getColumnIndexOrThrow(COLUMN_RSS)) + "\n";
                cursor.moveToNext();
            }
        }

        return strRes;
    }
}
