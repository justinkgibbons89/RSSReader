import Foundation
import RSSReader

@available(OSX 10.15, *)
class App {
	
	internal func run() {
		print("Running...")
		operations()
		RunLoop.main.run()
	}
	
	private func operations() {
		let reader = Reader()
		reader.read(feed: "http://feeds.feedburner.com/marginalrevolution/feed")
	}
}

if #available(OSX 10.15, *) {
	let app = App()
	app.run()
} else {
	// Fallback on earlier versions
}
