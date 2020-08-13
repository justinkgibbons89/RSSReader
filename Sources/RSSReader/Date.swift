import Foundation

extension Date {
	
	/// Converts a date string to a date object, or nil if the conversion fails.
	/// - Parameter string: The date to be converted, represented as a string.
	/// - Parameter format: The format of the date string, as an `RSSDateFormat`.
	/// - Returns: The converted date, or `nil`.
	static internal func from(_ string: String?, format: RSSDateFormat = .simple) -> Date? {
		guard let dateString = string else {
			print("Couldn't resolve string from pubDate."); return nil
		}
		let formatter = DateFormatter()
		formatter.dateFormat = format.string
		return formatter.date(from: dateString)
	}
}
