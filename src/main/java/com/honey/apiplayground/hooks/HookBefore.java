package com.honey.apiplayground.hooks;

import com.honey.apiplayground.context.ScenarioContextStorage;
import com.honey.apiplayground.managers.RequestManager;
import io.cucumber.java.Before;
import io.cucumber.java.BeforeAll;
import io.restassured.RestAssured;

public final class HookBefore {

    @BeforeAll
    public static void beforeAllConfig() {
        RestAssured.enableLoggingOfRequestAndResponseIfValidationFails();
    }

    @Before
    public void before() {
        ScenarioContextStorage.startScenarioData();
        RequestManager.createNewScenarioRequestSpecification();
    }

}
