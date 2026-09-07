package com.honey.apiplayground.steps;

import com.honey.apiplayground.handlers.RequestHandler;
import com.honey.apiplayground.handlers.ResponseHandler;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

/**
 * Cucumber step definitions responsible for sending the request assembled for
 * the current scenario.
 */
public final class RequestSteps {

    /**
     * Sends the configured request using the supplied HTTP method and endpoint,
     * then stores the received response for subsequent steps.
     *
     * @param httpMethod the HTTP method to invoke on the request specification
     * @param endpoint the endpoint to which the request is sent
     * @throws Exception if the requested HTTP method cannot be invoked
     */
    @When("send a {word} to {word}")
    public void request(String httpMethod, String endpoint) throws Exception {
        final RequestSpecification requestSpecification = RestAssured.given().spec(RequestHandler.getScenarioRequest());
        final Response response = (Response) requestSpecification.getClass()
                .getMethod(httpMethod, String.class, Object[].class)
                .invoke(requestSpecification, endpoint, new Object[]{});

        ResponseHandler.save(response);

    }

}
