package com.honey.apiplayground.steps;

import com.honey.apiplayground.handlers.ResponseHandler;
import com.honey.apiplayground.utils.FileUtils;
import com.honey.apiplayground.utils.PathUtils;
import io.cucumber.java.en.Then;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;

/**
 * Cucumber steps responsible for validating response contracts represented by
 * JSON Schema files stored in the test resources.
 */
public final class SchemaSteps {

    /**
     * Validates the saved response body against a schema file.
     *
     * @param schemaFileName the schema file name inside request/schemas
     */
    @Then("validate response body against schema {string}")
    public void validateResponseAgainstSchema(String schemaFileName) {
        ResponseHandler.getSavedAsValidatableResponse().body(
                matchesJsonSchema(FileUtils.getJsonFileText(PathUtils.getCompleteJsonFilePathForSchemas(schemaFileName)))
        );
    }
}
