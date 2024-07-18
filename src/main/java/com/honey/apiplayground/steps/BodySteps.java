package com.honey.apiplayground.steps;

import com.honey.apiplayground.handlers.RequestHandler;
import com.honey.apiplayground.utils.RequestBodyRetriever;
import io.cucumber.java.en.Given;

public final class BodySteps {

    @Given("add body from json file {word}")
    public void addBody(String jsonFileName) {
        RequestHandler.addBody(RequestBodyRetriever.getJsonFileBodyAsString(jsonFileName));
    }
}
