package com.honey.apiplayground.constants;

public final class RunnerConstants {

    private RunnerConstants() {}

    public static final String GLUE_PATH = "com/honey/apiplayground/steps";
    public static final String FEATURES_PATH = "src/test/resources/features";
    public static final String PLUGINS = "pretty, summary, html:src/test/resources/evidences/cucumber-html-report.html";
}
