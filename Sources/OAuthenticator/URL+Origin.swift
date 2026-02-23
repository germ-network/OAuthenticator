import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

extension URL {
	var origin: String? {
		guard
			let host = self.host,
			let scheme = self.scheme
		else {
			return nil
		}

		var originComponents = URLComponents()
		originComponents.scheme = scheme
		originComponents.host = host

		guard let port = self.port else {
			return originComponents.string
		}

		if scheme == "http" || scheme == "https" {
			if scheme == "http" && port != 80 {
				originComponents.port = port
			} else if scheme == "https" && port != 443 {
				originComponents.port = port
			}
		} else {
			originComponents.port = port
		}

		return originComponents.string
	}
}
