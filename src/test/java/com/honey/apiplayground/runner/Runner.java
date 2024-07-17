package com.honey.apiplayground.runner;

import com.honey.apiplayground.constants.RunnerConstants;
import io.cucumber.core.options.Constants;
import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.Suite;

@Suite
@IncludeEngines("cucumber")
@ConfigurationParameter(key = Constants.GLUE_PROPERTY_NAME, value = RunnerConstants.GLUE_PATH)
@ConfigurationParameter(key = Constants.FEATURES_PROPERTY_NAME, value = RunnerConstants.FEATURES_PATH)
@ConfigurationParameter(key = Constants.PLUGIN_PROPERTY_NAME, value = RunnerConstants.PLUGINS)
@ConfigurationParameter(key = Constants.FILTER_TAGS_PROPERTY_NAME,value = "@regression")
public class Runner {
}
