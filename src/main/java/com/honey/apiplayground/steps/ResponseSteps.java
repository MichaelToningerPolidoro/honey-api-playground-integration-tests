package com.honey.apiplayground.steps;

import com.honey.apiplayground.context.ScenarioContextStorage;
import com.honey.apiplayground.handlers.ResponseHandler;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;
import io.restassured.response.ValidatableResponse;
import org.hamcrest.Matchers;

import java.util.Map;

public final class ResponseSteps {


    @Then("validate response status equals {int}")
    public void validateResponse(int statusHttp) {
        ResponseHandler.getSavedAsValidatableResponse().statusCode(statusHttp);
    }

    @Then("validate response body")
    public void validateResponseBody(Map<String, String> expectedData) {
        final ValidatableResponse savedAsValidatableResponse = ResponseHandler.getSavedAsValidatableResponse();

        expectedData.forEach((gPathExpression, expectedBooleanValue) -> {
            savedAsValidatableResponse.body(gPathExpression, Matchers.equalTo(Boolean.valueOf(expectedBooleanValue)));
        });

    }

    // TODO a step to validate response comparing previous saved values (context data)

    @Then("save response data")
    public void saveResponseData(Map<String, String> expectedData) {
        final JsonPath jsonPath = ResponseHandler.getSavedAsJsonPath();
        final Map<String, Object> scenarioData = ScenarioContextStorage.getScenarioData();

        expectedData.forEach((variableName, valuePath) -> {
            scenarioData.put(variableName, jsonPath.get(valuePath));
        });
    }

}
