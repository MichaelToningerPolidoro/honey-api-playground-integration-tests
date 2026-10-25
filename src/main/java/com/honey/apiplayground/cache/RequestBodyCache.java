package com.honey.apiplayground.cache;

import java.nio.file.Path;
import java.util.concurrent.ConcurrentHashMap;

public final class RequestBodyCache {

    private static final ConcurrentHashMap<Path, String> requestBodyCache = new ConcurrentHashMap<>();

    private RequestBodyCache() {}

    public static void add(Path jsonFilePath, String jsonBody) {
        requestBodyCache.putIfAbsent(jsonFilePath, jsonBody);
    }

    public static String getCachedJsonBody(Path jsonFilePath) {
        return requestBodyCache.get(jsonFilePath);
    }

    public static boolean isJsonBodyCached(Path jsonFilePath) {
        return requestBodyCache.containsKey(jsonFilePath);
    }
}
