import Foundation
import NIO

@available(OSX 10.15, *)
public class Reader {
	
	//MARK: Initialization
	public init(verbose: Bool = false) {
		self.verbose = verbose
	}
	
	//MARK: Properties
	private let networking = Networking()
	private var verbose: Bool
	
	//MARK: Methods
	/// Downloads the XML from the given URL, parses it to an `RSSChannelDescription` and passes the result to a completion handler.
	/// - Parameters:
	///   - feed: The URL of the desired channel.
	///   - completion: The closure which receives the resultant channel.
	public func channel(from feed: String, completion: @escaping (RSSChannelDescription) -> ()) {

		Networking().download(path: feed) { data in
			if self.verbose {
				print("Download finished for \(feed)")
			}
			let channel = self.parse(data: data)
			completion(channel)
		}
	}
	
	/// Downloads the XML from the given URL, parses it into an `RSSChannelDescription` and returns a future.
	/// - Parameters:
	///   - url: The URL of the desired channel.
	///   - eventLoop: The event loop to make the promise on.
	/// - Returns: A future that resolves to a channel or an error.
	public func channel(from url: String, on eventLoop: EventLoop) -> EventLoopFuture<RSSChannelDescription> {
		let promise = eventLoop.makePromise(of: RSSChannelDescription.self)
		
		Networking().download(path: url) { data in
			let channel = self.parse(data: data)
			
			promise.completeWith(.success(channel))
		}
		
		return promise.futureResult
	}
	
	/// Downloads the XML from the given URLs asynchronously, maps the XML to `RSSChannelDescription` objects, and returns a collection of futures that resolve indepedently.
	/// - Parameters:
	///   - urls: The URLs of the resourcse to be downloaded and parsed.
	///   - eventLoop: The event loop to resolve futures on.
	/// - Returns: A collection of future channel descriptions.
	public func channels(from urls: [String], on eventLoop: EventLoop) -> [EventLoopFuture<RSSChannelDescription>] {
		let dataFutures = Networking().download(urls: urls, on: eventLoop)
		var channelFutures: [EventLoopFuture<RSSChannelDescription>] = []
		
		for future in dataFutures {
			let channelFuture = future.map { (data) in
				self.parse(data: data)
			}
			
			channelFutures.append(channelFuture)
		}
		
		return channelFutures
	}
	
//	public func channels(from futureURLs: [EventLoopFuture<[String]>], on eventLoop: EventLoop) -> [EventLoopFuture<RSSChannelDescription>] {
//		let dataFutures = Networking().download(urls: urls, on: eventLoop)
//		var channelFutures: [EventLoopFuture<RSSChannelDescription>] = []
//
//		for future in dataFutures {
//			let channelFuture = future.map { (data) in
//				self.parse(data: data)
//			}
//
//			channelFutures.append(channelFuture)
//		}
//
//		return channelFutures
//	}
	
	/// Parses XML data into an `RSSChannelDescription`
	/// - Parameter data: The channel as data.
	/// - Returns: The channel as a rich object.
	func parse(data: Data) -> RSSChannelDescription {
		RSSChannelDescription(data: data)
	}
	
}
