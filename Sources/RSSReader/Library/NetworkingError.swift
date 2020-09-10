import Foundation

enum NetworkingError: Error {
	case unknown, invalidURL(path: String), dataTaskError(url: String, domain: String)
	
	var localizedDescription: String {
		switch self {
			case .unknown: return "Unknown error"
			case .invalidURL(let path): return "Invalid URL: \(path)"
			case .dataTaskError(let url, let domain): return "Data task failed: \(domain) @ \(url)"
		}
	}
}

