package com.honey.apiplayground.utils;

import com.honey.apiplayground.constants.FileConstants;

import java.io.File;
import java.util.Arrays;
import java.util.List;

public final class ClassUtils {

    private ClassUtils() {}

    public static <T> List<T> getClassesImplementingInterface(T expectedInterface) {
        return getAllClassesInsideProject().stream()
                .filter(clazz -> Arrays.asList(clazz.getInterfaces()).contains(expectedInterface))
                .filter(clazz -> !clazz.getSimpleName().equals(expectedInterface.getClass().getSimpleName()))
                .map(clazz -> (T) clazz)
                .toList();
    }

    private static List<Class> getAllClassesInsideProject() {
        return FileUtils.getAllClassesFilesInsideProject()
                .stream()
                .map(ClassUtils::getClassPackagePathFromFile)
                .map(ClassUtils::getClass)
                .toList()
                ;

    }

    private static String getClassPackagePathFromFile(File file) {
        return file.getAbsolutePath()
                .replace(FileConstants.USER_DIR + File.separator, "")
                .replace("src" + File.separator, "")
                .replace("test" + File.separator, "")
                .replace("main" + File.separator, "")
                .replace("java" + File.separator, "")
                .replace(".java", "")
                .replace(File.separator, ".");
    }

    private static Class getClass(String completePath) {
        try {
            return Class.forName(completePath);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

}
