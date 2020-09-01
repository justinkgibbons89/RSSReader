import Foundation
import NIO

#if os(Linux)
import FoundationNetworking
#endif

#if os(iOS)
import Combine
#endif

public class Networking {
	
	//MARK: Properties
	private let session = URLSession.shared
	
	//MARK: Initializer
	public init() {}
	
	//MARK: Methods
	/// Downloads the data at the given URL and passes it to the completion handler.
	/// - Parameters:
	///   - path: The URL to be downloaded from.
	///   - completion: The completion handler to receive the resulting data.
	public func download(path: String, completion: @escaping (Data) -> ()) {
		
		guard let url = URL(string: path) else {
			print("Couldn't construct URL from path. Aborted."); return
		}
		
		let task = session.dataTask(with: url) { (data, response, error) in
			print("Data task finished.")
			
			if let error = error {
				print("Data task error: \(error)")
			}
			
			if let data = data {
				completion(data)
			}
		}
		
		task.resume()
	}
	
	/// Downloads the data at the given URL and returns it as a future data object.
	/// - Parameters:
	///   - url: The URL to be downloaded from.
	///   - eventLoop: The event loop to create the underlying promise on.
	/// - Returns: A future which resolves into the downloaded data, or an error.
	public func download(from url: String, on eventLoop: EventLoop) -> EventLoopFuture<Data> {
		let promise = eventLoop.makePromise(of: Data.self)
		
		guard let url = URL(string: url) else {
			print("Couldn't construct URL from path. Aborted.");
			promise.completeWith(.failure(NetworkingError.unknown))
			return promise.futureResult
		}
		
		
		let task = session.dataTask(with: url) { (data, response, error) in
			
			if let error = error {
				print("Data task error: \(error)")
				promise.completeWith(.failure(NetworkingError.unknown))
			}
			
			if let data = data {
				promise.completeWith(.success(data))
			}
		}
		
		task.resume()
		return promise.futureResult
	}
	
	/// Ask for multiple downloads asynchronously, returning a collection of data futures that will resolve independently.
	/// - Parameters:
	///   - urls: The URLs of the resources to download.
	///   - eventLoop: The event loop to resolve the futures on.
	/// - Returns: The data objects, as a collection of futures.
	public func download(urls: [String], on eventLoop: EventLoop) -> [EventLoopFuture<Data>] {
		var results: [EventLoopFuture<Data>] = []
		
		for url in urls {
			let dataFuture = download(from: url, on: eventLoop)
			results.append(dataFuture)
		}
		
		return results
	}
	
	#if os(iOS)
	@available(OSX 10.15, *)
	func publisher(for path: String) -> URLSession.DataTaskPublisher? {
		guard let url = URL(string: path) else {
			print("Couldn't construct URL from path. Aborted."); return nil
		}
		
		return session.dataTaskPublisher(for: url)
	}
	#endif
}

enum NetworkingError: Error {
	case unknown
}
