package com.honey.apiplayground.utils;

import java.util.concurrent.ThreadLocalRandom;

public final class RandomDataUtils {

    private static final String LOWER_CASE_LETTERS = "abcdefghijklmnopqrstuvwxyz";
    private static final String UPPER_CASE_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String ALL_LETTERS = LOWER_CASE_LETTERS + UPPER_CASE_LETTERS;
    private static final String EMAIL_DOMAIN = "@example.com";
    private static final int EMAIL_LOCAL_PART_LENGTH = 20;
    private static final int NICKNAME_LENGTH = 16;

    private RandomDataUtils() {}

    public static String generateEmail() {
        return generateString(EMAIL_LOCAL_PART_LENGTH, LOWER_CASE_LETTERS) + EMAIL_DOMAIN;
    }

    public static String generateNickname() {
        return generateString(NICKNAME_LENGTH, ALL_LETTERS);
    }

    private static String generateString(int length, String alphabet) {
        final StringBuilder value = new StringBuilder(length);
        final ThreadLocalRandom threadLocalRandom = ThreadLocalRandom.current();

        while (value.length() < length) {
            value.append(alphabet.charAt(threadLocalRandom.nextInt(alphabet.length())));
        }

        return value.toString();
    }

}
