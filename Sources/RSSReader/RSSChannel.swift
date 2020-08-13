import Foundation
import SWXMLHash

public struct RSSChannelDescription {
	
	//MARK: Properties
	/// The title of this channel.
	public var title: String?
	
	/// The description of this channel.
	public var description: String?
	
	/// The URL of this channel.
	///
	/// This is public URL of channel, not the RSS feed. (i.e. It's a link to the website that hosts this feed.)
	public var link: String?
	
	/// The language of the channel, represented as a `String`
	public var languageRaw: String?
	
	/// The language of the channel.
	public var language: RSSLanguage {
		RSSLanguage.from(languageRaw)
	}
	
	/// The last build date of the channel, as a `String`.
	public var lastBuildDateRaw: String?
	
	/// The last build date of the channel, as a `Date` object.
	public var lastBuildDate: Date? {
		Date.from(lastBuildDateRaw, format: .simple)
	}
	
	/// The URL of this channel's RSS feed, in atom format.
	public var atom: String?
	
	/// The categories associated with the channel, aggregated from its items.
	public var aggregateCategories: [String] = []
	public var generator: String?
	
	/// The items associated with this channel.
	public var items: [RSSItemDescription] = []
}

extension RSSChannelDescription {
	
	//MARK: Initialization
	/// Creates an `RSSChannelDescription` from a `SWXMLChannelAddressor` object.
	/// - Parameter addressor: The addressor to be used.
	public init(addressor: SWXMLChannelAddressor) {
		self.title = addressor.title
		self.description = addressor.description
		self.link = addressor.link
		self.languageRaw = addressor.language
		self.lastBuildDateRaw = addressor.lastBuildDate
		self.atom = addressor.atom
		self.aggregateCategories = addressor.categories
		self.generator = addressor.generator
		
		items = addressor.itemAddressors.map { itemAddressor in
			RSSItemDescription(addressor: itemAddressor)
		}
	}
	
	public init(data: Data) {
		let xml = SWXMLHash.parse(data)
		let addressor = SWXMLChannelAddressor(indexer: xml)
		self.init(addressor: addressor)
	}
}
