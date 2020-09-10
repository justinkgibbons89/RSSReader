import Foundation

public enum NetworkingError: Error {
	case unknown, invalidURL(url: String), dataTaskFailed(url: String, description: String)
}


extension NetworkingError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .unknown: return "Unknown error"
			case .invalidURL(let url): return "Invalid URL: \(url)"
			case .dataTaskFailed(let url, let desc): return "Data task failed: \(desc) @ \(url)"
		}
	}
}
