package com.honey.apiplayground.steps;

import com.honey.apiplayground.handlers.RequestHandler;
import com.honey.apiplayground.handlers.ResponseHandler;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public final class RequestSteps {

    @When("send a {word} to {word}")
    public void request(String httpMethod, String endpoint) throws Exception {
        final RequestSpecification requestSpecification = RestAssured.given().spec(RequestHandler.getScenarioRequest());
        final Response response = (Response) requestSpecification.getClass()
                .getMethod(httpMethod, String.class, Object[].class)
                .invoke(requestSpecification, endpoint, new Object[]{});

        ResponseHandler.save(response);

    }

}
