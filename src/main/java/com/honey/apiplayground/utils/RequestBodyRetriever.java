package com.honey.apiplayground.utils;

import com.honey.apiplayground.cache.RequestBodyCache;
import com.honey.apiplayground.config.environment.EnvironmentVariables;

import java.nio.file.Path;

public final class RequestBodyRetriever {

    private RequestBodyRetriever() {}

    public static String getJsonFileBodyAsString(Path jsonFilePath) {
        if (RequestBodyCache.isJsonBodyCached(jsonFilePath)) {
            return RequestBodyCache.getCachedJsonBody(jsonFilePath);
        }

        final String jsonFileText = FileUtils.getJsonFileText(jsonFilePath);

        if (EnvironmentVariables.isJsonBodyCacheEnabled() && !RequestBodyCache.isJsonBodyCached(jsonFilePath)) {
            RequestBodyCache.add(jsonFilePath, jsonFileText);
        }

        return jsonFileText;
    }
}
