package com.honey.apiplayground.context;

public final class ScenarioContext {

    private ScenarioContext() {}

    public static void save(String key, Object value) {
        ScenarioContextStorage.getScenarioData().put(key, value);
    }

    public static Object get(String key) {
        return ScenarioContextStorage.getScenarioData().get(key);
    }

    public static void delete(String key) {
        ScenarioContextStorage.getScenarioData().remove(key);
    }
}
