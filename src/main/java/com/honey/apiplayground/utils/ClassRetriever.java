package com.honey.apiplayground.utils;

import com.honey.apiplayground.cache.AuthorizationCache;
import com.honey.apiplayground.service.AuthorizationProvider;

import java.util.List;
import java.util.NoSuchElementException;

public final class ClassRetriever {

    private ClassRetriever() {}

    static {
        AuthorizationCache.set(findAuthorizationClassImpl());
    }

    public static AuthorizationProvider getAuthorizationImpl() {
        return AuthorizationCache.get();
    }

    private static AuthorizationProvider findAuthorizationClassImpl() {
        final Class<AuthorizationProvider> expectedInterface = AuthorizationProvider.class;
        final List<Class<AuthorizationProvider>> authorizationClassImplementations = ClassUtils.getClassesImplementingInterface(expectedInterface);

        if (authorizationClassImplementations.isEmpty()) {
            throw new NoSuchElementException("No classes found implementing interface -> " + expectedInterface);
        }

        try {
            return authorizationClassImplementations.getFirst().getConstructor().newInstance();

        } catch (Exception e) {
            throw new NoSuchElementException("No classes implementing " + expectedInterface.getSimpleName() + " has been found!");

        }
    }
}
