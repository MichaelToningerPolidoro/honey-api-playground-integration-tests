package com.honey.apiplayground.managers;

import com.honey.apiplayground.constants.ReqResConstants;
import com.honey.apiplayground.context.ScenarioContext;
import com.honey.apiplayground.factory.RequestSpecificationFactory;
import io.restassured.specification.RequestSpecification;

public final class RequestManager {

    public static void createNewScenarioRequestSpecification() {
        ScenarioContext.save(ReqResConstants.CONTEXT_KEY_REQUEST, RequestSpecificationFactory.create());
    }

    public static RequestSpecification getScenarioRequest() {
        return (RequestSpecification) ScenarioContext.get(ReqResConstants.CONTEXT_KEY_REQUEST);
    }

    public static void deleteScenarioRequestSpecification() {
        ScenarioContext.delete(ReqResConstants.CONTEXT_KEY_REQUEST);
    }
}
