package com.honey.apiplayground.context;

import java.util.HashMap;
import java.util.Map;

public final class ScenarioContextStorage {

    private static final ThreadLocal<Map<String, Object>> scenarioContextData = new ThreadLocal<>();

    private ScenarioContextStorage() {}

    public static void startScenarioData() {
        scenarioContextData.set(new HashMap<>());
    }

    public static Map<String, Object> getScenarioData() {
        return scenarioContextData.get();
    }

    public static void removeScenarioData() {
        scenarioContextData.remove();
    }

}
