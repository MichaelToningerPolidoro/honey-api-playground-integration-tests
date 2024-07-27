package com.honey.apiplayground.steps;

import com.honey.apiplayground.handlers.RequestHandler;
import io.cucumber.java.en.Given;

import java.util.Map;

public final class HeaderSteps {

    @Given("add authorization header")
    public void addAuthorizationHeader() {
        RequestHandler.addAuthorizationHeader();
    }

    @Given("add headers")
    public void addHeader(Map<String, String> headers) {
        RequestHandler.addHeaders(headers);
    }

}
