package com.honey.apiplayground.cache;

import com.honey.apiplayground.service.AuthorizationProvider;

public final class AuthorizationCache {

    private static volatile AuthorizationProvider authorizationProvider;

    private AuthorizationCache() {}

    public static AuthorizationProvider get() {
        return authorizationProvider;
    }

    public static void set(AuthorizationProvider provider) {
        authorizationProvider = provider;
    }
}
