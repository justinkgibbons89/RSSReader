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
	public func channel(from feed: String, completion: @escaping (RSSChannelDescription) -> ()) {

		Networking().publisher(for: feed)?
			.map { result in self.parse(data: result.data) }
			.catch { (failure) in Just(RSSChannelDescription()) }
			.sink { channel in completion(channel) }
			.store(in: &cancellables)
		
	}
	
	func parse(data: Data) -> RSSChannelDescription {
		RSSChannelDescription(data: data)
	}
	
}
