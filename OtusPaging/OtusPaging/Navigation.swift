import SwiftUI
import OpenAPIClient

enum Rubric: String, CaseIterable, Identifiable {
    case articles
    case blogs
    case reports

    var id: String { rawValue }

    var title: String {
        switch self {
        case .articles: "Articles"
        case .blogs: "Blogs"
        case .reports: "Reports"
        }
    }
}

struct FeedItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let summary: String
    let authorName: String?
    let newsSite: String?
    let publishedAt: String?
    let url: String?

    init(article: Article) {
        id = article.id
        title = article.title
        summary = article.summary ?? ""
        authorName = article.authors.first?.name
        newsSite = article.newsSite
        publishedAt = article.publishedAt
        url = article.url
    }

    init(blog: Blog) {
        id = blog.id
        title = blog.title
        summary = blog.summary ?? ""
        authorName = blog.authors.first?.name
        newsSite = blog.newsSite
        publishedAt = blog.publishedAt
        url = blog.url
    }

    init(report: Report) {
        id = report.id
        title = report.title
        summary = report.summary ?? ""
        authorName = report.authors.first?.name
        newsSite = report.newsSite
        publishedAt = report.publishedAt
        url = report.url
    }
}

enum AppRoute: Hashable {
    case detail(FeedItem)
    case info(FeedItem)
}

@Observable
final class Navigator {
    var routes: [AppRoute] = []

    func push(_ route: AppRoute) {
        guard routes.count < 2 else { return }
        routes.append(route)
    }

    func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
    }

    func popToRoot() {
        routes.removeAll()
    }
}

struct CustomNavigationStack<Content: View>: View {
    @Bindable var navigator: Navigator
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            content()
                .opacity(navigator.routes.isEmpty ? 1 : 0)

            if let route = navigator.routes.last {
                routeView(route)
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: navigator.routes.count)
    }

    @ViewBuilder
    private func routeView(_ route: AppRoute) -> some View {
        switch route {
        case .detail(let item):
            DetailScreen(item: item, navigator: navigator)
        case .info(let item):
            InfoScreen(item: item, navigator: navigator)
        }
    }
}
