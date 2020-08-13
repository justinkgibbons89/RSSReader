import Foundation

struct RSSItemDescription {

	//MARK: Properties
	/// The title of this item.
	var title: String?
	
	/// This item's link.
	var link: String?
	
	/// The author of this item.
	var dcCreator: String?
	
	/// The publication date of the item, as a `String`.
	var pubDateRaw: String?
	
	/// The categories associated with this item.
	var categories: [String] = []
	
	var guid: String?
	var guidIsPermalink: Bool?
	
	/// The description of this item.
	var description: String?
	
	/// The content of the item.
	var content: String?
	
	/// The URL of this item's comments.
	var comments: String?
	
	/// The publication date of the item, as a `Date` object.
	var pubDate: Date? {
		Date.from(pubDateRaw, format: .simple)
	}
}

extension RSSItemDescription {
	
	//MARK: Initialization
	/// Initializes an `RSSItemDescription` from  a `SWXMLItemAddressor`.
	/// - Parameter addressor: The addressor used to decode the channel.
	init(addressor: SWXMLItemAddressor) {
		self.title = addressor.title
		self.link = addressor.link
		self.dcCreator = addressor.dcCreator
		self.pubDateRaw = addressor.pubDate
		self.guid = addressor.guid
		self.description = addressor.description
		self.content = addressor.content
		self.categories = addressor.categories
		self.comments = addressor.comments
		self.guidIsPermalink = addressor.guidIsPermalink
	}
}
