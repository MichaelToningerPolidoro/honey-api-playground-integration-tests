package com.honey.apiplayground.utils;

import com.honey.apiplayground.service.AuthorizationProvider;

import java.util.List;
import java.util.NoSuchElementException;

public final class ClassRetriever {

    private ClassRetriever() {}

    public static AuthorizationProvider getAuthorizationClassImpl() {
        // TODO: Add cache here to improve performance
        final Class<AuthorizationProvider> expectedInterface = AuthorizationProvider.class;
        final List<Class<AuthorizationProvider>> authorizationClassImplementations = ClassUtils.getClassesImplementingInterface(expectedInterface);

        if (authorizationClassImplementations.isEmpty()) {
            throw new NoSuchElementException("No classes found implementing interface -> " + expectedInterface);
        }

        try {
            final AuthorizationProvider authorizationServiceInstance = authorizationClassImplementations.get(0).getConstructor().newInstance();

            // TODO add to cache here to improve performance

            return authorizationServiceInstance;
        } catch (Exception e) {
            throw new NoSuchElementException("No classes implementing " + expectedInterface.getSimpleName() + " has been found!");
        }
    }
}
