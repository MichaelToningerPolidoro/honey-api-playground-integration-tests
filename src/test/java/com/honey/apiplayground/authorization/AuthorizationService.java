package com.honey.apiplayground.authorization;

import com.honey.apiplayground.config.environment.EnvironmentVariablesProvider;
import com.honey.apiplayground.service.AuthorizationProvider;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

public final class AuthorizationService implements AuthorizationProvider {

    private static final String basicToken;

    static {
        final String tokenPrefix = "Basic ";
        final String username = EnvironmentVariablesProvider.getRequiredEnv("username");
        final String password = EnvironmentVariablesProvider.getRequiredEnv("password");

        basicToken = tokenPrefix + Base64.getEncoder().encodeToString((username + ":" + password).getBytes(StandardCharsets.UTF_8));
    }

    @Override
    public String getToken() {
        return basicToken;
    }

}
