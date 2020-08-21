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
		Reader().channel(from: "http://feeds.feedburner.com/marginalrevolution/feed") { channel in
			print(channel.title ?? "no title")
			print(channel.categoriesDescription)
		}
	}
}

if #available(OSX 10.15, *) {
	let app = App()
	app.run()
} else {
	// Fallback on earlier versions
}
