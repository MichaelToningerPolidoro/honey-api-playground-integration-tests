package com.honey.apiplayground;

import com.honey.apiplayground.context.ScenarioContextStorage;

public enum DataType {

    STRING {
        @Override
        public Object getValue(String rawValue) {
            return rawValue;
        }
    },

    BOOLEAN {
        @Override
        public Object getValue(String rawValue) {
            return Boolean.parseBoolean(rawValue);
        }
    },

    STORAGE {
        @Override
        public Object getValue(String rawValue) {
            return ScenarioContextStorage.getScenarioData().get(rawValue);
        }
    }

    ;

    public abstract Object getValue(String rawValue);

}
