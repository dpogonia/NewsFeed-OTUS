import Foundation

public enum ArticlesAPI {
    public static func articlesList(
        limit: Int,
        offset: Int,
        apiConfiguration: OpenAPIClientAPIConfiguration = .shared
    ) async throws -> PaginatedArticleList {
        try await APIClient.fetch(
            path: "/v4/articles/",
            limit: limit,
            offset: offset,
            apiConfiguration: apiConfiguration
        )
    }
}
