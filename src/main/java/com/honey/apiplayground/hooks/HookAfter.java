package com.honey.apiplayground.hooks;

import com.honey.apiplayground.context.ScenarioContextStorage;
import io.cucumber.java.After;

public final class HookAfter {

    @After
    public void after() {
        ScenarioContextStorage.removeScenarioData();
    }
}
