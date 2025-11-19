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
        
        String cleaned = text.trim();
        
        // Handle ISO format with T separator (e.g., "2025-11-20T02:41:07" or "2025-11-20T02:41:07.707011500")
        if (cleaned.contains("T")) {
            try {
                // Remove nanoseconds if present (keep only up to 9 digits for nanoseconds)
                if (cleaned.contains(".")) {
                    int dotIndex = cleaned.indexOf('.');
                    int tIndex = cleaned.indexOf('T');
                    if (dotIndex > tIndex) {
                        String beforeDot = cleaned.substring(0, dotIndex + 1);
                        String afterDot = cleaned.substring(dotIndex + 1);
                        // Remove any non-digit characters after the dot and limit to 9 digits
                        afterDot = afterDot.replaceAll("[^0-9]", "");
                        if (afterDot.length() > 9) {
                            afterDot = afterDot.substring(0, 9);
                        }
                        cleaned = beforeDot + afterDot;
                    }
                }
                // Try parsing with ISO format
                return LocalDateTime.parse(cleaned, ISO_DATETIME_FORMAT);
            } catch (DateTimeParseException e) {
                // If ISO parsing fails, try converting to DB format
                try {
                    // Replace T with space and remove nanoseconds
                    cleaned = cleaned.replace("T", " ");
                    if (cleaned.contains(".")) {
                        cleaned = cleaned.split("\\.")[0];
                    }
                    return LocalDateTime.parse(cleaned, DB_DATETIME_FORMAT);
                } catch (DateTimeParseException e2) {
                    // Last resort: try with just date and time parts
                    try {
                        String[] parts = cleaned.split(" ");
                        if (parts.length >= 2) {
                            return LocalDateTime.parse(parts[0] + " " + parts[1].split("\\.")[0], DB_DATETIME_FORMAT);
                        }
                    } catch (Exception e3) {
                        // Fall through to throw
                    }
                }
            }
        } else {
            // Try DB format (space separator: "yyyy-MM-dd HH:mm:ss")
            try {
                // Remove nanoseconds if present
                if (cleaned.contains(".")) {
                    cleaned = cleaned.split("\\.")[0];
                }
                return LocalDateTime.parse(cleaned, DB_DATETIME_FORMAT);
            } catch (DateTimeParseException e) {
                // Try ISO format as fallback (in case it's stored without T)
                try {
                    return LocalDateTime.parse(cleaned, ISO_DATETIME_FORMAT);
                } catch (DateTimeParseException e2) {
                    throw new IllegalArgumentException("Unable to parse date time: " + text + ". Expected format: 'yyyy-MM-dd HH:mm:ss' or 'yyyy-MM-ddTHH:mm:ss'", e2);
                }
            }
        }
        
        // Should not reach here, but just in case
        throw new IllegalArgumentException("Unable to parse date time: " + text);
    }
}
