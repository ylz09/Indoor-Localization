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

import com.jjoe64.graphview.LegendRenderer;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.verify;

@RunWith(MockitoJUnitRunner.class)
public class GraphLegendTest {
    @Mock
    private LegendRenderer legendRenderer;

    @Test
    public void testSortByNumber() throws Exception {
        assertEquals(3, GraphLegend.values().length);
    }

    @Test
    public void testGetDisplay() throws Exception {
        assertTrue(GraphLegend.HIDE.getDisplay() instanceof GraphLegend.DisplayNone);
        assertTrue(GraphLegend.LEFT.getDisplay() instanceof GraphLegend.DisplayLeft);
        assertTrue(GraphLegend.RIGHT.getDisplay() instanceof GraphLegend.DisplayRight);
    }

    @Test
    public void testDisplayHide() throws Exception {
        // execute
        GraphLegend.HIDE.display(legendRenderer);
        // validate
        verify(legendRenderer).setVisible(false);
    }

    @Test
    public void testDisplayLeft() throws Exception {
        // execute
        GraphLegend.LEFT.display(legendRenderer);
        // validate
        verify(legendRenderer).setVisible(true);
        verify(legendRenderer).setFixedPosition(0, 0);
    }

    @Test
    public void testDisplayRight() throws Exception {
        // execute
        GraphLegend.RIGHT.display(legendRenderer);
        // validate
        verify(legendRenderer).setVisible(true);
        verify(legendRenderer).setAlign(LegendRenderer.LegendAlign.TOP);
    }

}