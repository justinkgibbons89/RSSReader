import Foundation

@available(OSX 10.15, *)
public class Reader {
	
	//MARK: Initialization
	public init() {}
	
	//MARK: Properties
	private let networking = Networking()
	
	//MARK: Methods
	public func channel(from feed: String, completion: @escaping (RSSChannelDescription) -> ()) {

		Networking().download(path: feed) { data in 
			let channel = self.parse(data: data)
			completion(channel)
		}
	}
	
	func parse(data: Data) -> RSSChannelDescription {
		RSSChannelDescription(data: data)
	}
	
}
