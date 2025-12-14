package com.honey.apiplayground.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class RegexUtil {

    private RegexUtil() {}

    public static List<String> extractOccurrencesFromText(String text, Pattern pattern) {
        final List<String> foundValues = new ArrayList<>();
        final Matcher matcher = pattern.matcher(text);

        // TODO use group count
//        int a = matcher.groupCount();
        while (matcher.find()) {
            foundValues.add(matcher.group());
        }

        return foundValues;

    }
}
