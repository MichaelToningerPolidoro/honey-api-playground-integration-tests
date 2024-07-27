package com.honey.apiplayground.handlers;

import com.honey.apiplayground.managers.RequestManager;
import com.honey.apiplayground.utils.ClassRetriever;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.specification.RequestSpecification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class RequestHandler {

    private RequestHandler() {}

    public static RequestSpecification getScenarioRequest() {
        return RequestManager.getScenarioRequest();
    }

    public static void addHeaders(Map<String, String> headersMap) {
        final List<Header> headersToAdd = new ArrayList<>() {{
            headersMap.forEach((header, value) -> add(new Header(header, value)));
        }};

        RequestManager.getScenarioRequest().headers(new Headers(headersToAdd));
    }

    public static void addHeader(String headerName, String value) {
        addHeaders(new HashMap<>() {{
            put(headerName, value);
        }});
    }

    public static void addAuthorizationHeader() {
        addHeader("Authorization", ClassRetriever.getAuthorizationClassImpl().getToken());
    }

    public static void addBody(String body) {
        RequestManager.getScenarioRequest().body(body);
    }
}
