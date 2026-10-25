package com.honey.apiplayground.cache;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public final class RequestBodyCache {

    private static final Map<Path, String> requestBodyCache = new HashMap<>();

    private RequestBodyCache() {}

    public static synchronized void add(Path jsonFilePath, String jsonBody) {
        if (!requestBodyCache.containsKey(jsonFilePath)) {
            requestBodyCache.put(jsonFilePath, jsonBody);
        }
    }

    public static String getCachedJsonBody(Path jsonFilePath) {
        return requestBodyCache.get(jsonFilePath);
    }

    public static boolean isJsonBodyCached(Path jsonFilePath) {
        return requestBodyCache.containsKey(jsonFilePath);
    }
}
