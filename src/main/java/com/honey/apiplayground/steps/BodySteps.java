package com.honey.apiplayground.steps;

import com.honey.apiplayground.DataTableTypeTransformer;
import com.honey.apiplayground.handlers.RequestHandler;
import com.honey.apiplayground.utils.FileUtils;
import com.honey.apiplayground.utils.RequestBodyRetriever;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import io.cucumber.java.en.Given;

import java.util.Map;

/**
 * Cucumber step definitions responsible for configuring the request body of the
 * current scenario.
 */
public final class BodySteps {

    /**
     * Loads a JSON file and assigns its contents as the request body.
     *
     * @param jsonFileName the name of the JSON file to load
     */
    @Given("add body from json file {word}")
    public void addBody(String jsonFileName) {
        RequestHandler.addBody(RequestBodyRetriever.getJsonFileBodyAsString(jsonFileName));
    }

    /**
     * Loads a JSON file, replaces the specified JSON paths with scenario data,
     * and assigns the resulting JSON as the request body.
     *
     * @param jsonFileName the name of the JSON file to load
     * @param dataToChange the JSON paths and replacement values
     *                     Example:<br>
     *                     | $.data.path.to.be.changed1 | testing                         |<br>
     *                     | $.data.path.to.be.changed2 | {BOOLEAN}true                   |<br>
     *                     | $.data.path.to.be.changed3 | {STORAGE}previousDataSaved      |<br><br>
     *                     Check DataTypesEnum {@link com.honey.apiplayground.DataType}
     */
    @Given("add body from json file {word} changing data")
    public void addBodyChangingData(String jsonFileName, Map<String, String> dataToChange) {
        final DocumentContext parsedJsonFile = JsonPath.parse(FileUtils.getJsonFileText(jsonFileName));
        DataTableTypeTransformer.transformMap(dataToChange).forEach(parsedJsonFile::set);
        RequestHandler.addBody(parsedJsonFile.jsonString());
    }

    /**
     * Removes the request body configured for the current scenario.
     */
    @Given("remove body")
    public void removeBody() {
        RequestHandler.removeBody();
    }
}
