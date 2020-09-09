import Foundation
import NIO

public struct NetworkResult {
	public var url: String
	public var data: Data
	public var response: URLResponse?
}
