package com.honey.apiplayground.steps;

import com.honey.apiplayground.DataTableTypeTransformer;
import com.honey.apiplayground.context.ScenarioContext;
import io.cucumber.java.en.Given;

import java.util.Map;

public final class StorageSteps {

    /**
     * Resolves the values supplied by the data table and saves them in the
     * current scenario context.
     *
     * @param dataToSave the scenario context keys and their values
     *                    Example:<br>
     *                    | userEmail    | {EMAIL}             |<br>
     *                    | userNickname | {NICKNAME}          |<br>
     *                    | userActive   | {BOOLEAN}true       |<br>
     *                    | savedValue   | {STORAGE}userEmail  |<br><br>
     *                    Check {@link com.honey.apiplayground.DataType} for
     *                    the supported value types.
     */
    @Given("save data in storage")
    public void saveDataInStorage(Map<String, String> dataToSave) {
        DataTableTypeTransformer.transformMap(dataToSave).forEach(ScenarioContext::save);
    }
}
