package fedu

import java.text.SimpleDateFormat

class DateHelper {
    static monthDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d")
        dateFormat.format(date)
    }

    static format(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        dateFormat.format(date)
    }
}
