import Foundation
import SWXMLHash

struct RSSChannelDescription {
	
	//MARK: Properties
	/// The title of this channel.
	var title: String?
	
	/// The description of this channel.
	var description: String?
	
	/// The URL of this channel.
	///
	/// This is public URL of channel, not the RSS feed. (i.e. It's a link to the website that hosts this feed.)
	var link: String?
	
	/// The language of the channel, represented as a `String`
	var languageRaw: String?
	
	/// The language of the channel.
	var language: RSSLanguage {
		RSSLanguage.from(languageRaw)
	}
	
	/// The last build date of the channel, as a `String`.
	var lastBuildDateRaw: String?
	
	/// The last build date of the channel, as a `Date` object.
	var lastBuildDate: Date? {
		Date.from(lastBuildDateRaw, format: .simple)
	}
	
	/// The URL of this channel's RSS feed, in atom format.
	var atom: String?
	
	/// The categories associated with the channel, aggregated from its items.
	var aggregateCategories: [String] = []
	var generator: String?
	
	/// The items associated with this channel.
	var items: [RSSItemDescription] = []
}

extension RSSChannelDescription {
	
	//MARK: Initialization
	/// Creates an `RSSChannelDescription` from a `SWXMLChannelAddressor` object.
	/// - Parameter addressor: The addressor to be used.
	init(addressor: SWXMLChannelAddressor) {
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
	
	init(data: Data) {
		let xml = SWXMLHash.parse(data)
		let addressor = SWXMLChannelAddressor(indexer: xml)
		self.init(addressor: addressor)
	}
}
