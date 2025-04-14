package com.example.resources;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

/**
 * SampleResourceのテストクラス
 */
public class SampleResourceTest {
    /**
     * SampleResourceのgetSampleMessageメソッドのテスト
     */
    @Test
    public void testGetSampleMessage() {
        SampleResource sampleResource = new SampleResource();
        String expectedMessage = "Hello, this is a sample resource!\n";
        String actualMessage = sampleResource.getSampleMessage();
        assertEquals(expectedMessage, actualMessage, "The message should match the expected output.");
    }
}
