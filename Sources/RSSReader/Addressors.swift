import Foundation
import SWXMLHash

public struct SWXMLChannelAddressor {
	
	//MARK: Properties
	internal let indexer: XMLIndexer
	
	var channelIndex: XMLIndexer {
		indexer["rss"]["channel"]
	}
	
	var itemIndices: [XMLIndexer] {
		channelIndex["item"].all
	}
	
	var itemAddressors: [SWXMLItemAddressor] {
		itemIndices.map { (indexer) in
			SWXMLItemAddressor(indexer: indexer)
		}
	}
	
	//MARK: Elements
	var title: String? {
		channelIndex["title"].element?.text
	}
	
	var description: String? {
		channelIndex["description"].element?.text
	}
	
	var link: String? {
		channelIndex["link"].element?.text
	}
	
	var lastBuildDate: String? {
		channelIndex["lastBuildDate"].element?.text
	}
	
	var language: String? {
		channelIndex["language"].element?.text
	}
	
	var atom: String? {
		channelIndex["atom:link"].element?.value(ofAttribute: "href")
	}
	
	var categories: [String] {
		var results: [String] = []
		for itemAddressor in itemAddressors {
			results += itemAddressor.categories
		}
		return results
	}
	
	var generator: String? {
		indexer["generator"].element?.text
	}
}

public struct SWXMLItemAddressor {
	
	//MARK: Properties
	internal let indexer: XMLIndexer
	
	//MARK: Elements
	var title: String? {
		indexer["title"].element?.text
	}
	
	var description: String? {
		indexer["description"].element?.text
	}
	
	var content: String? {
		indexer["content:encoded"].element?.text
	}
	
	var link: String? {
		indexer["link"].element?.text
	}
	
	var dcCreator: String? {
		indexer["dc:creator"].element?.text
	}
	
	var pubDate: String? {
		indexer["pubDate"].element?.text
	}
	
	var categories: [String] {
		var results = [String]()
		for categoryIndexer in indexer["category"].all {
			if let category = categoryIndexer.element?.text {
				results.append(category)
			}
		}
		return results
	}
	
	var guid: String? {
		indexer["guid"].element?.text
	}
	
	var guidIsPermalink: Bool? {
		indexer["guid"].element?.value(ofAttribute: "isPermaLink") as Bool?
	}
	
	var comments: String? {
		indexer["comments"].element?.text
	}
	
}
