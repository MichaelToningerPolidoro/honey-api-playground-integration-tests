package com.honey.apiplayground.constants;

import java.io.File;

public final class FileConstants {

    private FileConstants() {}

    public static final String USER_DIR = System.getProperty("user.dir");
    public static final String REQUEST_FILES_PATH = USER_DIR + File.separator + "src" + File.separator + "test"  + File.separator + "resources"  + File.separator + "request";
    public static final String REQUEST_BODIES_PATH = REQUEST_FILES_PATH + File.separator + "body";
    public static final String SCHEMA_CLASSPATH_DIRECTORY = REQUEST_FILES_PATH + File.separator + "schemas";
    public static final String PROJECT_CLASSES_PATH = FileConstants.USER_DIR + File.separator + "src";

}
