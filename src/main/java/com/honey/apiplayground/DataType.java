package com.honey.apiplayground;

import com.honey.apiplayground.context.ScenarioContextStorage;
import com.honey.apiplayground.utils.RandomDataUtils;

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
    },

    EMAIL {
        @Override
        public Object getValue(String rawValue) {
            return RandomDataUtils.generateEmail();
        }
    },

    NICKNAME {
        @Override
        public Object getValue(String rawValue) {
            return RandomDataUtils.generateNickname();
        }
    };

    public abstract Object getValue(String rawValue);

}
