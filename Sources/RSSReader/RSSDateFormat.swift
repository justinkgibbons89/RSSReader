import Foundation

enum RSSDateFormat {
	
	/// The "simple date format" used by most feeds.
	case simple
	
	/// iso-80 date format
	case iso80
	
	var string: String {
		switch self {
			case .simple: return "E, d MMM yyyy HH:mm:ss Z"
			case .iso80: return "Error"
		}
	}
}
