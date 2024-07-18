package com.honey.apiplayground.hooks;

import com.honey.apiplayground.context.ScenarioContextStorage;
import com.honey.apiplayground.managers.RequestManager;
import io.cucumber.java.Before;

public final class HookBefore {

    @Before
    public void before() {
        ScenarioContextStorage.startScenarioData();
        RequestManager.createNewScenarioRequestSpecification();
    }

}
