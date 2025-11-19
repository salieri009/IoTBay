package utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateTimeParser {
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ISO_LOCAL_DATE;
    // DB에 저장된 포맷: "yyyy-MM-dd HH:mm:ss"
    private static final DateTimeFormatter DB_DATETIME_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    // ISO 형식 (SQLite가 반환하는 형식): "yyyy-MM-ddTHH:mm:ss" 또는 "yyyy-MM-ddTHH:mm:ss.SSSSSSSSS"
    private static final DateTimeFormatter ISO_DATETIME_FORMAT = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    public static String toText(LocalDate date) {
        return date != null ? date.format(DATE_FORMAT) : null;
    }

    public static String toText(LocalDateTime dateTime) {
        return dateTime != null ? dateTime.format(DB_DATETIME_FORMAT) : null;
    }

    public static LocalDate parseLocalDate(String text) {
        return text != null ? LocalDate.parse(text, DATE_FORMAT) : null;
    }

    public static LocalDateTime parseLocalDateTime(String text) {
        if (text == null || text.trim().isEmpty()) {
            return null;
        }
        
        // Try ISO format first (SQLite default)
        try {
            // Remove nanoseconds if present (e.g., "2025-11-20T02:41:07.707011500" -> "2025-11-20T02:41:07.707011500")
            String cleaned = text;
            if (cleaned.contains("T")) {
                // ISO format with T separator
                if (cleaned.contains(".")) {
                    // Has nanoseconds, try to parse with optional nanoseconds
                    int dotIndex = cleaned.indexOf('.');
                    int tIndex = cleaned.indexOf('T');
                    if (dotIndex > tIndex) {
                        // Remove excess nanoseconds (keep only up to 9 digits)
                        String beforeDot = cleaned.substring(0, dotIndex + 1);
                        String afterDot = cleaned.substring(dotIndex + 1);
                        if (afterDot.length() > 9) {
                            afterDot = afterDot.substring(0, 9);
                        }
                        cleaned = beforeDot + afterDot;
                    }
                }
                return LocalDateTime.parse(cleaned, ISO_DATETIME_FORMAT);
            } else {
                // Try DB format (space separator)
                return LocalDateTime.parse(cleaned, DB_DATETIME_FORMAT);
            }
        } catch (DateTimeParseException e) {
            // Try DB format as fallback
            try {
                return LocalDateTime.parse(text, DB_DATETIME_FORMAT);
            } catch (DateTimeParseException e2) {
                // Last resort: try ISO without nanoseconds
                try {
                    String cleaned = text.replace("T", " ").split("\\.")[0];
                    return LocalDateTime.parse(cleaned, DB_DATETIME_FORMAT);
                } catch (Exception e3) {
                    throw new IllegalArgumentException("Unable to parse date time: " + text, e3);
                }
            }
        }
    }
}
