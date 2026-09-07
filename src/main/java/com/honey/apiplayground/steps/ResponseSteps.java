package com.honey.apiplayground.steps;

import com.honey.apiplayground.DataTableTypeTransformer;
import com.honey.apiplayground.context.ScenarioContext;
import com.honey.apiplayground.handlers.ResponseHandler;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;
import io.restassured.response.ValidatableResponse;
import org.hamcrest.Matchers;

import java.util.Map;

/**
 * Cucumber step definitions responsible for validating and preserving data from
 * responses received during the current scenario.
 */
public final class ResponseSteps {


    /**
     * Verifies that the saved response has the expected HTTP status code.
     *
     * @param statusHttp the expected HTTP status code
     *                   Example: 200
     */
    @Then("validate response status equals {int}")
    public void validateResponse(int statusHttp) {
        ResponseHandler.getSavedAsValidatableResponse().statusCode(statusHttp);
    }

    /**
     * Verifies response-body values at the paths provided by the Cucumber data
     * table after resolving scenario placeholders.
     *
     * @param expectedData the response paths and their expected values
     *                     Example:<br>
     *                     | data.path.to.be.valid1 | 123                        |<br>
     *                     | data.path.to.be.valid2 | testing                    |<br>
     *                     | data.path.to.be.valid3 | {STORAGE}previousDataSaved |<br><br>
     *                     Check DataTypesEnum {@link com.honey.apiplayground.DataType}
     */
    @Then("validate response body")
    public void validateResponseBody(Map<String, String> expectedData) {
        final ValidatableResponse savedAsValidatableResponse = ResponseHandler.getSavedAsValidatableResponse();

        DataTableTypeTransformer.transformMap(expectedData).forEach((expression, expectedValue) -> {
            savedAsValidatableResponse.body(expression, Matchers.equalTo(expectedValue));
        });

    }

    /**
     * Saves values from the response body into the scenario context.
     *
     * @param dataToSave the context variable names and corresponding response paths
     *                     Example:
     *                     | contextKeyName | path.to.json.data |
     */
    @Then("save response data")
    public void saveResponseData(Map<String, String> dataToSave) {
        final JsonPath jsonPath = ResponseHandler.getSavedAsJsonPath();
        dataToSave.forEach((variableName, valuePath) -> ScenarioContext.save(variableName, jsonPath.get(valuePath)));
    }

}
