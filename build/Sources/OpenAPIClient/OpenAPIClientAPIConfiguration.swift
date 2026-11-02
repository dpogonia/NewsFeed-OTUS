import Foundation

open class OpenAPIClientAPIConfiguration: @unchecked Sendable {
    public var basePath: String

    public init(basePath: String = "") {
        self.basePath = basePath
    }

    public static let shared = OpenAPIClientAPIConfiguration()
}
