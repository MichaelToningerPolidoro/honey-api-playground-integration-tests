package com.honey.apiplayground;

import com.honey.apiplayground.context.ScenarioContextStorage;

import java.util.List;

public enum DataType {

    STRING {
        @Override
        public Object getValue(String rawValue) {
            return rawValue;
        }
    },

    BLANK_STRING {
        @Override
        public Object getValue(String rawValue) {
            return "";
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
    },

    EMPTY_LIST {
        @Override
        public Object getValue(String rawValue) {
            return List.of();
        }
    },

    NULL {
        @Override
        public Object getValue(String rawValue) {
            return null;
        }
    };

    public abstract Object getValue(String rawValue);

}
