package com.honey.apiplayground.utils;

import com.honey.apiplayground.constants.FileConstants;

import java.io.File;
import java.io.UncheckedIOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Path;
import java.util.Collection;

public final class FileUtils {

    private FileUtils() {}

    public static String getJsonFileText(Path jsonFilePath) {
        try (FileChannel fileChannel = FileChannel.open(jsonFilePath)) {
            final int arraySize = (int) fileChannel.size();
            final byte[] data = new byte[arraySize];

            fileChannel.read(ByteBuffer.wrap(data));

            return new String(data);

        } catch (Exception e) {
            throw new RuntimeException("An error occurred while json file reading!");
        }
    }

    public static Collection<File> getAllClassesFilesInsideProject() {
        final File directory = new File(FileConstants.PROJECT_CLASSES_PATH);
        final String[] extensions = {"java"};
        final boolean recursive = true;

        try {
            return org.apache.commons.io.FileUtils.listFiles(directory, extensions, recursive);
        } catch (UncheckedIOException e) {
            throw new RuntimeException("Error during classes search!");
        } catch (Exception e) {
            throw new RuntimeException("Some unknown error occurred during classes search!");
        }

    }
}
