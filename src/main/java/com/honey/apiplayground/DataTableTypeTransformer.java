package com.honey.apiplayground;

import com.honey.apiplayground.utils.RegexUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public final class DataTableTypeTransformer {

    private static final Pattern PATTERN = Pattern.compile("^\\{([A-Z_]+)}(.*)");

    private DataTableTypeTransformer() {}

    public static Map<String, Object> transformMap(Map<String, String> stringMap) {
        final Map<String, Object> transformedMap = new HashMap<>();

        stringMap.forEach((k, v) -> {
            if (v.startsWith("{")) {
                final List<String> foundValues = RegexUtil.extractOccurrencesFromText(v, PATTERN);
                final DataType dataType = DataType.valueOf(foundValues.get(0));
                final Object transformedData = dataType.getValue(foundValues.get(1));

                transformedMap.put(k, transformedData);

            } else {
                transformedMap.put(k, v);

            }

        });

        return transformedMap;
    }
}
