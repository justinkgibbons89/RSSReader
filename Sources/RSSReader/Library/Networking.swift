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
			print("Couldn't construct URL from path: \(path)"); return
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
	
	/// Downloads the data at the given URL and returns it as a future `NetworkResult`.
	/// - Parameters:
	///   - path: The URL to be downloaded from.
	///   - eventLoop: The event loop to create the underlying promise on.
	/// - Returns: A future which resolves into the downloaded data, or an error.
	public func download(from path: String, on eventLoop: EventLoop, v verbose: Bool = false) -> EventLoopFuture<NetworkResult> {
		let promise = eventLoop.makePromise(of: NetworkResult.self)
		
		guard let url = URL(string: path) else {
			let error = NetworkingError.invalidURL(url: path)
			promise.completeWith(.failure(error))
			return promise.futureResult
		}
		
		
		let task = session.dataTask(with: url) { (data, response, error) in
			
			if let nsError = error as NSError? {
				let error = NetworkingError.dataTaskFailed(url: path, description: nsError.localizedDescription)
				promise.completeWith(.failure(error))
			}
			
			if let data = data {
				let result = NetworkResult(path: path, url: url, data: data, response: response)
				promise.completeWith(.success(result))
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
	public func download(urls: [String], on eventLoop: EventLoop) -> [EventLoopFuture<NetworkResult>] {
		var results: [EventLoopFuture<NetworkResult>] = []
		
		for url in urls {
			let request = download(from: url, on: eventLoop)
			results.append(request)
		}
		
		return results
	}
	
	/// Asynchronously downloads the file from a given URL and returns it as a `NetworkResult`.
	/// - Parameters:
	///   - futureURL: The URL to be downloaded.
	///   - eventLoop: The event loop to perform work on.
	/// - Returns: The data from the given URL, as a future.
	public func download(_ futureURL: EventLoopFuture<String>, eventLoop: EventLoop) -> EventLoopFuture<NetworkResult> {
		futureURL.flatMap { (url) in
			self.download(from: url, on: eventLoop)
		}
	}
	
	/// Asynchronously downloads any files at the given URLs and returns them as a collection of `NetworkResult` objects.
	/// - Parameters:
	///   - futureURLs: The URLs to be downloaded.
	///   - eventLoop: The event loop to perform work on.
	/// - Returns: A collection of downloaded data, as futures.
	public func download(_ futureURLs: [EventLoopFuture<String>], eventLoop: EventLoop) -> [EventLoopFuture<NetworkResult>] {
		futureURLs.map { (futureURL) -> EventLoopFuture<NetworkResult> in
			self.download(futureURL, eventLoop: eventLoop)
		}
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
