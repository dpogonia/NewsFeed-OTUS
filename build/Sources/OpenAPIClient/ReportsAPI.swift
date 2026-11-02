import Foundation

public enum ReportsAPI {
    public static func reportsList(
        limit: Int,
        offset: Int,
        apiConfiguration: OpenAPIClientAPIConfiguration = .shared
    ) async throws -> PaginatedReportList {
        try await APIClient.fetch(
            path: "/v4/reports/",
            limit: limit,
            offset: offset,
            apiConfiguration: apiConfiguration
        )
    }
}
