import Foundation

public enum RSSLanguage: Int {
	
    case unknown = 0
	case english = 1
    case french = 2
	
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
