package com.honey.apiplayground.steps;

import com.honey.apiplayground.DataTableTypeTransformer;
import com.honey.apiplayground.handlers.RequestHandler;
import com.honey.apiplayground.utils.FileUtils;
import com.honey.apiplayground.utils.RequestBodyRetriever;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import io.cucumber.java.en.Given;

import java.util.Map;

public final class BodySteps {

    @Given("add body from json file {word}")
    public void addBody(String jsonFileName) {
        RequestHandler.addBody(RequestBodyRetriever.getJsonFileBodyAsString(jsonFileName));
    }

    @Given("add body from json file {word} changing data")
    public void addBodyChangingData(String jsonFileName, Map<String, String> dataToChange) {
        final DocumentContext parsedJsonFile = JsonPath.parse(FileUtils.getJsonFileText(jsonFileName));
        DataTableTypeTransformer.transformMap(dataToChange).forEach(parsedJsonFile::set);
        RequestHandler.addBody(parsedJsonFile.jsonString());
    }

    @Given("remove body")
    public void removeBody() {
        RequestHandler.removeBody();
    }
}
