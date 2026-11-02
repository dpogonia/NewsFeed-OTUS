import Foundation

public struct Author: Codable, Hashable, Sendable {
    public let name: String?
    public let socials: [String: String]?

    public init(name: String? = nil, socials: [String: String]? = nil) {
        self.name = name
        self.socials = socials
    }
}

public struct Article: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let title: String
    public let authors: [Author]
    public let url: String?
    public let imageUrl: String?
    public let newsSite: String?
    public let summary: String?
    public let publishedAt: String?
    public let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url, summary
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

public struct Blog: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let title: String
    public let authors: [Author]
    public let url: String?
    public let imageUrl: String?
    public let newsSite: String?
    public let summary: String?
    public let publishedAt: String?
    public let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url, summary
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

public struct Report: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let title: String
    public let authors: [Author]
    public let url: String?
    public let imageUrl: String?
    public let newsSite: String?
    public let summary: String?
    public let publishedAt: String?
    public let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url, summary
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

public struct PaginatedArticleList: Codable, Sendable {
    public let count: Int?
    public let next: String?
    public let previous: String?
    public let results: [Article]
}

public struct PaginatedBlogList: Codable, Sendable {
    public let count: Int?
    public let next: String?
    public let previous: String?
    public let results: [Blog]
}

public struct PaginatedReportList: Codable, Sendable {
    public let count: Int?
    public let next: String?
    public let previous: String?
    public let results: [Report]
}
