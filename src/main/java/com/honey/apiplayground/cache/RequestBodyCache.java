package com.honey.apiplayground.cache;

import java.util.HashMap;
import java.util.Map;

public final class RequestBodyCache {

    private static final Map<String, String> requestBodyCache = new HashMap<>();

    private RequestBodyCache() {}

    public static synchronized void add(String jsonFileName, String jsonBody) {
        if (!requestBodyCache.containsKey(jsonFileName)) {
            requestBodyCache.put(jsonFileName, jsonBody);
        }
    }

    public static String getCachedJsonBody(String jsonFileName) {
        return requestBodyCache.get(jsonFileName);
    }

    public static boolean isJsonBodyCached(String jsonFileName) {
        return requestBodyCache.containsKey(jsonFileName);
    }
}
