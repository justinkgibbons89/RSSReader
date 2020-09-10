import Foundation

public enum NetworkingError: Error {
	case unknown, invalidURL(path: String), dataTaskError(url: String, description: String)
	
	var localizedDescription: String {
		switch self {
			case .unknown: return "Unknown error"
			case .invalidURL(let path): return "Invalid URL: \(path)"
			case .dataTaskError(let url, let desc): return "Data task failed: \(desc) @ \(url)"
		}
	}
}

