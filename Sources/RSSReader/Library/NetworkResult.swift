import Foundation
import NIO

public struct NetworkResult {
	public var path: String
	public var url: URL
	public var data: Data
	public var response: URLResponse?
}
