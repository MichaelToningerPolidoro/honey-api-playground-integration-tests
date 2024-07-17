package com.honey.apiplayground.context;

public final class ScenarioContext {

    private ScenarioContext() {}

    public void save(String key, String value) {
        ScenarioContextStorage.getScenarioData().put(key, value);
    }

    public Object get(String key) {
        return ScenarioContextStorage.getScenarioData().get(key);
    }

    public void delete(String key) {
        ScenarioContextStorage.getScenarioData().remove(key);
    }
}
