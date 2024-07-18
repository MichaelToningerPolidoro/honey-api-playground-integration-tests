package com.honey.apiplayground.factory;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;

public final class RequestSpecificationFactory {

    private RequestSpecificationFactory() {}

    public static RequestSpecification create() {
        return new RequestSpecBuilder().build();
    }

}
