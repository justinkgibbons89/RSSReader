import Foundation

public enum NetworkingError: Error {
	case unknown, invalidURL(url: String), dataTaskFailed(url: String, description: String)
}


extension NetworkingError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .unknown: return "Unknown error"
			case let .invalidURL(url): return "Invalid URL: \(url)"
			case let .dataTaskFailed(url, desc): return "Data task failed: \(desc) @ \(url)"
		}
	}
}
