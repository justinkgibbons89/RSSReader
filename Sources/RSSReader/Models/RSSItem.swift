import Foundation

public struct RSSItemDescription {

	//MARK: Properties
	/// The title of this item.
	public var title: String?
	
	/// This item's link.
	public var link: String?
	
	/// The author of this item.
	public var dcCreator: String?
	
	/// The publication date of the item, as a `String`.
	public var pubDateRaw: String?
	
	/// The categories associated with this item.
	public var categories: [String] = []
	
	public var guid: String?
	public var guidIsPermalink: Bool?
	
	/// The description of this item.
	public var description: String?
	
	/// The content of the item.
	public var content: String?
	
	/// The URL of this item's comments.
	public var comments: String?
	
	/// The publication date of the item, as a `Date` object.
	public var pubDate: Date? {
		Date.from(pubDateRaw, format: .simple)
	}
}

extension RSSItemDescription {
	
	//MARK: Initialization
	/// Initializes an `RSSItemDescription` from  a `SWXMLItemAddressor`.
	/// - Parameter addressor: The addressor used to decode the channel.
	public init(addressor: SWXMLItemAddressor) {
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
