import Foundation
import NIO

public struct NetworkResult {
	var url: String
	var data: Data
	var response: URLResponse?
}
