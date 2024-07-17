package com.honey.apiplayground.utils;

import com.honey.apiplayground.constants.FileConstants;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

public final class PathUtils {

    private PathUtils() {}

    public static Path getCompleteJsonFilePathForRequestBodies(String jsonFileName) {
        return Paths.get(FileConstants.REQUEST_BODIES_PATH + File.separator + jsonFileName);
    }
}
