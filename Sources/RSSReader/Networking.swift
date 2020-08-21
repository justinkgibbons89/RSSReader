import Foundation

#if os(iOS)
import Combine
#endif

public class Networking {
	
	//MARK: Properties
	private let session = URLSession.shared
	
	//MARK: Methods
	public func download(path: String, completion: @escaping (Data) -> ()) {
		print("Downloading...")
		
		guard let url = URL(string: path) else {
			print("Couldn't construct URL from path. Aborted."); return
		}
		
		let task = session.dataTask(with: url) { (data, response, error) in
			print("Data task finished.")
			
			if let error = error {
				print("Data task error: \(error)")
			}
			
			if let data = data {
				completion(data)
			}
		}
		
		task.resume()
	}
	
	#if os(iOS)
	@available(OSX 10.15, *)
	func publisher(for path: String) -> URLSession.DataTaskPublisher? {
		guard let url = URL(string: path) else {
			print("Couldn't construct URL from path. Aborted."); return nil
		}
		
		return session.dataTaskPublisher(for: url)
	}
	#endif
}
