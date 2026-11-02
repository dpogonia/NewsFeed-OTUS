import Foundation
import OpenAPIClient

struct Page {
    let limit: Int
    let offset: Int
}

extension OpenAPIClientAPIConfiguration {
    static let spaceflight = OpenAPIClientAPIConfiguration(basePath: "https://api.spaceflightnewsapi.net")
}

func getPage(from next: String?) -> Page? {
    guard let next else {
        return nil
    }

    let components = URLComponents(string: next)
    let limitStr = components?.queryItems?.first(where: { $0.name == "limit" })?.value
    let offsetStr = components?.queryItems?.first(where: { $0.name == "offset" })?.value

    guard let limitStr, let limit = Int(limitStr), let offsetStr, let offset = Int(offsetStr) else {
        return nil
    }

    return Page(limit: limit, offset: offset)
}
