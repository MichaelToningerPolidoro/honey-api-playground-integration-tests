package com.honey.apiplayground.config;

public final class EnvironmentVariables {

    private EnvironmentVariables() {}

    public static int getParallelScenariosCount() {
        final String parallelScenariosCount = EnvironmentVariablesProvider.getEnv("parallel_scenarios_count");

        if (parallelScenariosCount == null) {
            return 1;
        }

        return Integer.parseInt(parallelScenariosCount);
    }


}
