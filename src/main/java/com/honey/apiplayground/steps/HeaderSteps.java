package com.honey.apiplayground.steps;

import com.honey.apiplayground.DataTableTypeTransformer;
import com.honey.apiplayground.handlers.RequestHandler;
import io.cucumber.java.en.Given;

import java.util.HashMap;
import java.util.Map;

/**
 * Cucumber step definitions responsible for configuring request headers for the
 * current scenario.
 */
public final class HeaderSteps {

    /**
     * Adds the configured authorization header to the current request.
     */
    @Given("add authorization header")
    public void addAuthorizationHeader() {
        RequestHandler.addAuthorizationHeader();
    }

    /**
     * Resolves scenario placeholders and adds the provided headers to the
     * current request.
     *
     * @param headers the header names and values supplied by the Cucumber data table
     *                Example:<br>
     *                | X-Feature-Enabled  | {BOOLEAN}true  |<br>
     *                | X-Client-Name      | api-playground |<br><br>
     *                Check DataTypesEnum {@link com.honey.apiplayground.DataType}
     */
    @Given("add headers")
    public void addHeader(Map<String, String> headers) {
        final Map<String, String> transformedHeaders = new HashMap<>();

        DataTableTypeTransformer.transformMap(headers).forEach((key, value) -> transformedHeaders.put(key, value.toString()));

        RequestHandler.addHeaders(transformedHeaders);
    }

}
