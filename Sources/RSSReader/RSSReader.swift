import Foundation
import Combine

@available(OSX 10.15, *)
public class Reader {
	
	//MARK: Initialization
	public init() {}
	
	//MARK: Properties
	private let networking = Networking()
	private var cancellables = [AnyCancellable]()
	
	//MARK: Methods
	public func read(feed feedPath: String) {
		Networking().publisher(for: feedPath)?
			.sink(receiveCompletion: { _ in }) { result in
				self.parse(data: result.data)
		}
		.store(in: &cancellables)
	}
	
	func parse(data: Data) {
		let channel = RSSChannelDescription(data: data)
		print(channel.title ?? "no title")
		print("\(channel.items[0].pubDate as Any)")
		print(channel.items[0].guidIsPermalink as Any)
	}
	
}
