package com.honey.apiplayground.config.environment;

import static com.honey.apiplayground.config.environment.EnvironmentVariablesProvider.getEnv;
import static com.honey.apiplayground.constants.EnvironmentVariablesConstants.CACHE_REQUEST_BODIES;
import static com.honey.apiplayground.constants.EnvironmentVariablesConstants.PARALLEL_SCENARIOS_COUNT;

public final class EnvironmentVariables {

    private static final boolean isRequestBodyCacheEnabled = Boolean.parseBoolean(getEnv(CACHE_REQUEST_BODIES));
    private static final int getParallelScenariosCount = getEnv(PARALLEL_SCENARIOS_COUNT) == null ? 1 : Integer.parseInt(getEnv(PARALLEL_SCENARIOS_COUNT));

    private EnvironmentVariables() {}

    public static int getParallelScenariosCount() {
        return getParallelScenariosCount;
    }

    public static boolean isJsonBodyCacheEnabled() {
        return isRequestBodyCacheEnabled;
    }


}
