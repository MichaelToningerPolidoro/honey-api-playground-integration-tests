package com.honey.apiplayground.utils;

import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

public final class FileUtils {

    private FileUtils() {}

    public static String getJsonFileText(String jsonFileName) {
        FileChannel fileChannel;

        try {
            fileChannel = FileChannel.open(PathUtils.getCompleteJsonFilePathForRequestBodies(jsonFileName));

            final int arraySize = (int) fileChannel.size();
            final byte[] data = new byte[arraySize];

            fileChannel.read(ByteBuffer.wrap(data));
            fileChannel.close();

            return new String(data);

        } catch (Exception e) {
            throw new RuntimeException("An error occurred while json file reading!");
        }
    }
}
