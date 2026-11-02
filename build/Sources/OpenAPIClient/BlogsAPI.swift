import Foundation

public enum BlogsAPI {
    public static func blogsList(
        limit: Int,
        offset: Int,
        apiConfiguration: OpenAPIClientAPIConfiguration = .shared
    ) async throws -> PaginatedBlogList {
        try await APIClient.fetch(
            path: "/v4/blogs/",
            limit: limit,
            offset: offset,
            apiConfiguration: apiConfiguration
        )
    }
}
