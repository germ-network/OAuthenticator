import Foundation

#if canImport(FoundationNetworking)
	import FoundationNetworking
#endif

public enum URLError: Error, Hashable {
	case relative(String)
}

let insecureSchemes = ["http", "ws"]
let secureSchemes = ["https", "wss"]

extension URL {
	var origin: String? {
		guard
			let host = self.host,
			let scheme = self.scheme
		else {
			// throw URLError.relative("Cannot calculate an origin for a relative URL")
			return nil
		}
		
		var originComponents = URLComponents()
		originComponents.scheme = scheme
		originComponents.host = host
		
		guard let port = self.port else {
			return originComponents.string
		}

		let isStandardPort =
			(insecureSchemes.contains(scheme) && port == 80)
			|| (secureSchemes.contains(scheme) && port == 443)

		let isHttp = insecureSchemes.contains(scheme) || secureSchemes.contains(scheme)

		if (isHttp && !isStandardPort) || !isHttp {
			originComponents.port = port
		}

		return originComponents.string
	}
}
