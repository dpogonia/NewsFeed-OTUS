import Foundation

enum APIClient {
    static func fetch<T: Decodable>(
        path: String,
        limit: Int,
        offset: Int,
        apiConfiguration: OpenAPIClientAPIConfiguration
    ) async throws -> T {
        var components = URLComponents(string: apiConfiguration.basePath + path)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
