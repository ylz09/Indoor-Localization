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

package com.vrem.wifianalyzer.wifi.graphutils;

import com.jjoe64.graphview.series.BaseSeries;
import com.jjoe64.graphview.series.DataPoint;
import com.vrem.wifianalyzer.wifi.band.WiFiWidth;
import com.vrem.wifianalyzer.wifi.model.WiFiDetail;
import com.vrem.wifianalyzer.wifi.model.WiFiSignal;

import org.apache.commons.collections4.Closure;
import org.apache.commons.collections4.IterableUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.TreeSet;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

@SuppressWarnings("AnonymousInnerClass")
@RunWith(MockitoJUnitRunner.class)
public class SeriesCacheTest {
    @Mock
    private BaseSeries<DataPoint> series1;
    @Mock
    private BaseSeries<DataPoint> series2;
    @Mock
    private BaseSeries<DataPoint> series3;

    private List<BaseSeries<DataPoint>> series;

    private SeriesCache fixture;

    @Before
    public void setUp() {
        series = Arrays.asList(series1, series2, series3);
        fixture = new SeriesCache();
    }

    @Test
    public void testContains() throws Exception {
        // setup
        List<WiFiDetail> wiFiDetails = withData();
        // execute
        boolean actual = fixture.contains(wiFiDetails.get(0));
        // validate
        assertTrue(actual);
    }

    @Test
    public void testGet() throws Exception {
        // setup
        List<WiFiDetail> wiFiDetails = withData();
        // execute & validate
        for (int i = 0; i < series.size(); i++) {
            WiFiDetail wiFiDetail = wiFiDetails.get(i);
            assertEquals(series.get(i), fixture.get(wiFiDetail));
        }
    }

    @Test
    public void testAddExistingSeries() throws Exception {
        // setup
        List<WiFiDetail> wiFiDetails = withData();
        // execute
        BaseSeries<DataPoint> actual = fixture.put(wiFiDetails.get(0), series2);
        // validate
        assertEquals(series1, actual);
        assertEquals(series2, fixture.get(wiFiDetails.get(0)));
    }

    @Test
    public void tesDifferenceExpectOneLess() {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<WiFiDetail> actual = fixture.difference(new TreeSet<>(expected.subList(0, 1)));
        // validate
        assertEquals(expected.size() - 1, actual.size());
        for (int i = 1; i < expected.size(); i++) {
            assertEquals(expected.get(i), actual.get(i - 1));
        }
    }

    @Test
    public void tesDifferenceExpectEverything() {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<WiFiDetail> actual = fixture.difference(new TreeSet<WiFiDetail>());
        // validate
        assertEquals(expected.size(), actual.size());
        for (int i = 0; i < expected.size(); i++) {
            assertEquals(expected.get(i), actual.get(i));
        }
    }

    @Test
    public void tesDifferenceExpectNone() {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<WiFiDetail> actual = fixture.difference(new TreeSet<>(expected));
        // validate
        assertTrue(actual.isEmpty());
    }

    @Test
    public void testRemoveExpectedAllLeft() throws Exception {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<BaseSeries<DataPoint>> actual = fixture.remove(new ArrayList<WiFiDetail>());
        // validate
        assertTrue(actual.isEmpty());
        IterableUtils.forEach(expected, new Closure<WiFiDetail>() {
            @Override
            public void execute(WiFiDetail wiFiDetail) {
                assertTrue(fixture.contains(wiFiDetail));
            }
        });
    }

    @Test
    public void testRemoveExpectNoneLeft() throws Exception {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<BaseSeries<DataPoint>> actual = fixture.remove(expected);
        // validate
        assertEquals(expected.size(), actual.size());
        IterableUtils.forEach(expected, new Closure<WiFiDetail>() {
            @Override
            public void execute(WiFiDetail wiFiDetail) {
                assertFalse(fixture.contains(wiFiDetail));
            }
        });
    }

    @Test
    public void testRemoveExpectOneLeft() throws Exception {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<BaseSeries<DataPoint>> actual = fixture.remove(expected.subList(1, expected.size()));
        // validate
        assertEquals(2, actual.size());
        for (int i = 1; i < expected.size(); i++) {
            assertTrue(series.contains(actual.get(i - 1)));
            assertFalse(fixture.contains(expected.get(i)));
        }
        assertTrue(fixture.contains(expected.get(0)));
    }

    @Test
    public void testRemoveNonExistingOne() throws Exception {
        // setup
        List<WiFiDetail> expected = withData();
        List<WiFiDetail> toRemove = Collections.singletonList(makeWiFiDetail("SSID-999"));
        // execute
        List<BaseSeries<DataPoint>> actual = fixture.remove(toRemove);
        // validate
        assertTrue(actual.isEmpty());
        IterableUtils.forEach(expected, new Closure<WiFiDetail>() {
            @Override
            public void execute(WiFiDetail wiFiDetail) {
                assertTrue(fixture.contains(wiFiDetail));
            }
        });
    }

    @Test
    public void testRemoveExpectMoreThanOneLeft() throws Exception {
        // setup
        List<WiFiDetail> expected = withData();
        // execute
        List<BaseSeries<DataPoint>> actual = fixture.remove(expected.subList(0, 1));
        // validate
        assertEquals(1, actual.size());
        assertTrue(series.contains(actual.get(0)));
        for (int i = 1; i < expected.size(); i++) {
            assertTrue(fixture.contains(expected.get(i)));
        }
        assertFalse(fixture.contains(expected.get(0)));
    }

    @Test
    public void testFind() throws Exception {
        // setup
        List<WiFiDetail> wiFiDetails = withData();
        // execute
        WiFiDetail actual = fixture.find(series2);
        // validate
        assertEquals(wiFiDetails.get(1), actual);
    }

    private WiFiDetail makeWiFiDetail(String SSID) {
        return new WiFiDetail(SSID, "BSSID", StringUtils.EMPTY, new WiFiSignal(100, 100, WiFiWidth.MHZ_20, 5));
    }

    private List<WiFiDetail> withData() {
        List<WiFiDetail> results = new ArrayList<>();
        for (int i = 0; i < series.size(); i++) {
            WiFiDetail wiFiDetail = makeWiFiDetail("SSID" + i);
            results.add(wiFiDetail);
            fixture.put(wiFiDetail, series.get(i));
        }
        return results;
    }

}