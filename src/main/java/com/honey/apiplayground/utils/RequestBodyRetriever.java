package com.honey.apiplayground.utils;

import com.honey.apiplayground.cache.RequestBodyCache;
import com.honey.apiplayground.config.environment.EnvironmentVariables;

public final class RequestBodyRetriever {

    private RequestBodyRetriever() {}

    public static String getJsonFileBodyAsString(String jsonFileName) {
        if (RequestBodyCache.isJsonBodyCached(jsonFileName)) {
            return RequestBodyCache.getCachedJsonBody(jsonFileName);
        }

        final String jsonFileText = FileUtils.getJsonFileText(jsonFileName);

        if (EnvironmentVariables.isJsonBodyCacheEnabled() && !RequestBodyCache.isJsonBodyCached(jsonFileName)) {
            RequestBodyCache.add(jsonFileName, jsonFileText);
        }

        return jsonFileText;
    }
}
