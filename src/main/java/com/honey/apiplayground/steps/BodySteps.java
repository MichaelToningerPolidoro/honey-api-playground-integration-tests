package com.honey.apiplayground.steps;

import com.honey.apiplayground.utils.RequestBodyRetriever;
import io.cucumber.java.en.Given;

public final class BodySteps {

    @Given("add a body from json file {word}")
    public void addBody(String jsonFileName) {
        System.out.println(RequestBodyRetriever.getJsonFileBodyAsString(jsonFileName));

    }
}
