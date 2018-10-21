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

package com.vrem.wifianalyzer.wifi.band;

import org.apache.commons.collections4.Closure;
import org.apache.commons.collections4.IterableUtils;
import org.junit.Before;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

@SuppressWarnings("AnonymousInnerClass")
public class WiFiChannelCountryGHZ5Test {

    private final static SortedSet<Integer> CHANNELS_SET1 = new TreeSet<>(Arrays.asList(36, 40, 44, 48, 52, 56, 60, 64));
    private final static SortedSet<Integer> CHANNELS_SET2 = new TreeSet<>(Arrays.asList(100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144));
    private final static SortedSet<Integer> CHANNELS_SET3 = new TreeSet<>(Arrays.asList(149, 153, 157, 161, 165));

    private WiFiChannelCountryGHZ5 fixture;

    @Before
    public void setUp() {
        fixture = new WiFiChannelCountryGHZ5();
    }

    @Test
    public void testChannelsAustraliaCanada() throws Exception {
        final SortedSet<Integer> exclude = new TreeSet<>(Arrays.asList(120, 124, 128));
        final int expectedSize = CHANNELS_SET1.size() + CHANNELS_SET2.size() + CHANNELS_SET3.size() - exclude.size();
        List<String> countries = Arrays.asList("AU", "CA");
        IterableUtils.forEach(countries, new Closure<String>() {
            @Override
            public void execute(String country) {
                Set<Integer> actual = fixture.findChannels(country);
                assertEquals(expectedSize, actual.size());
                assertTrue(actual.containsAll(CHANNELS_SET1));
                assertTrue(actual.containsAll(CHANNELS_SET3));
                assertFalse(actual.containsAll(exclude));
            }
        });
    }

    @Test
    public void testChannelsChinaSouthKorea() throws Exception {
        final int expectedSize = CHANNELS_SET1.size() + CHANNELS_SET3.size();
        List<String> countries = Arrays.asList("CN", "KR");
        IterableUtils.forEach(countries, new Closure<String>() {
            @Override
            public void execute(String country) {
                Set<Integer> actual = fixture.findChannels(country);
                assertEquals(expectedSize, actual.size());
                assertTrue(actual.containsAll(CHANNELS_SET1));
                assertTrue(actual.containsAll(CHANNELS_SET3));
                assertFalse(actual.containsAll(CHANNELS_SET2));
            }
        });
    }

    @Test
    public void testChannelsJapanTurkeySouthAfrica() throws Exception {
        final int expectedSize = CHANNELS_SET1.size() + CHANNELS_SET2.size();
        List<String> countries = Arrays.asList("JP", "TR", "ZA");
        IterableUtils.forEach(countries, new Closure<String>() {
            @Override
            public void execute(String country) {
                Set<Integer> actual = fixture.findChannels(country);
                assertEquals(expectedSize, actual.size());
                assertTrue(actual.containsAll(CHANNELS_SET1));
                assertTrue(actual.containsAll(CHANNELS_SET2));
                assertFalse(actual.containsAll(CHANNELS_SET3));
            }
        });
    }

    @Test
    public void testChannelsIsrael() throws Exception {
        int expectedSize = CHANNELS_SET1.size();
        Set<Integer> actual = fixture.findChannels("IL");
        assertEquals(expectedSize, actual.size());
        assertTrue(actual.containsAll(CHANNELS_SET1));
        assertFalse(actual.containsAll(CHANNELS_SET2));
        assertFalse(actual.containsAll(CHANNELS_SET3));
    }

    @Test
    public void testChannelsOther() throws Exception {
        final int expectedSize = CHANNELS_SET1.size() + CHANNELS_SET2.size() + CHANNELS_SET3.size();
        List<String> countries = Arrays.asList("US", "RU", "XYZ");
        IterableUtils.forEach(countries, new Closure<String>() {
            @Override
            public void execute(String country) {
                Set<Integer> actual = fixture.findChannels(country);
                assertEquals(expectedSize, actual.size());
                assertTrue(actual.containsAll(CHANNELS_SET1));
                assertTrue(actual.containsAll(CHANNELS_SET2));
                assertTrue(actual.containsAll(CHANNELS_SET3));
            }
        });
    }

}