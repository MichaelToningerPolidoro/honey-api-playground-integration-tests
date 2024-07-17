package com.honey.apiplayground.config;

import java.util.NoSuchElementException;

public final class EnvironmentVariablesProvider {
    
    public EnvironmentVariablesProvider() {}

    public static String getRequiredEnv(String envVarName) {
        final String envVarValue = getEnv(envVarName);

        if (envVarValue == null) {
            throw new NoSuchElementException("Required environment variable <" + envVarName + "> was not found!");
        }

        return envVarValue;
    }

    public static String getEnv(String envVarName) {
        return System.getenv(envVarName);
    }
}
