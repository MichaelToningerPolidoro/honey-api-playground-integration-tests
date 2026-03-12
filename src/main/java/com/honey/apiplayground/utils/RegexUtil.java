package com.honey.apiplayground.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class RegexUtil {

    private RegexUtil() {}

    public static List<String> extractOccurrencesFromText(String text, Pattern pattern) {
        final List<String> foundValues = new ArrayList<>();
        final Matcher matcher = pattern.matcher(text);

        if (!matcher.matches()) {
            throw new NoSuchElementException("Couldn't find any matches!");
        }

        for (int i = 1; i <= matcher.groupCount(); i++) {
            foundValues.add(matcher.group(i));
        }

        return foundValues;

    }
}
