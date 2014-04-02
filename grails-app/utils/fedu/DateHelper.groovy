package fedu

import java.text.SimpleDateFormat

class DateHelper {
    static monthDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d")
        dateFormat.format(date)
    }
}
