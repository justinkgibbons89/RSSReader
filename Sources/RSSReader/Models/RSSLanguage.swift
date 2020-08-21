import Foundation

public enum RSSLanguage {
	
	case english
	case unknown
	
	static func from(_ string: String?) -> RSSLanguage {
		guard let languageString = string else {
			return .unknown
		}
		switch languageString {
			case "en-US":
				return .english
			default:
				return .unknown
		}
	}
}
