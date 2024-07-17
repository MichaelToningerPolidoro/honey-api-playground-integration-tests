package com.honey.apiplayground.constants;

import java.io.File;

public final class FileConstants {

    private FileConstants() {}

    private static final String USER_DIR = System.getProperty("user.dir");

    public static final String REQUEST_BODIES_PATH = USER_DIR + File.separator + "src" + File.separator + "test"  + File.separator + "resources"  + File.separator + "request" + File.separator + "body";

}
