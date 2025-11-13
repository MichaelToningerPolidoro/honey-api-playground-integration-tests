package com.honey.apiplayground.handlers;

import com.honey.apiplayground.constants.ReqResConstants;
import com.honey.apiplayground.context.ScenarioContext;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;

public final class ResponseHandler {

    private ResponseHandler() {}

    public static void save(Response response) {
        ScenarioContext.save(ReqResConstants.CONTEXT_KEY_RESPONSE, response);
    }

    public static Response getSaved() {
        return (Response) ScenarioContext.get(ReqResConstants.CONTEXT_KEY_RESPONSE);
    }

    public static ValidatableResponse getSavedAsValidatableResponse() {
        return getSaved().then();
    }

    public static JsonPath getSavedAsJsonPath() {
        return getSavedAsValidatableResponse().extract().jsonPath();
    }

}
