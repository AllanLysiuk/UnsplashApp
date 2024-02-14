import Foundation

extension Date {
    func convertFromISO8601String(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ConstStrings.Public.iso8601DateFormat
        let date = dateFormatter.date(from: dateStr) ?? Date()
        dateFormatter.dateFormat = ConstStrings.Public.defaultDateFormat
        return dateFormatter.string(from: date)
    }
}
