package com.honey.apiplayground.handlers;

import com.honey.apiplayground.managers.RequestManager;

public final class RequestHandler {

    private RequestHandler() {}

    public static void addBody(String body) {
        RequestManager.getScenarioRequest().body(body);
    }
}
