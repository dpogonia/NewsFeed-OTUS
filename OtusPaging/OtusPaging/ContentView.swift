import SwiftUI
import OpenAPIClient

struct ArticleDetailView: View {
    let item: FeedItem
    @State var isSelected = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ArticleView(item: item, isSelected: $isSelected)
            FavoriteView(isSelected: $isSelected)
                .frame(width: 50, height: 50)
                .padding()
        }
    }
}

struct DetailScreen: View {
    let item: FeedItem
    @Bindable var navigator: Navigator

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Назад") { navigator.pop() }
                Spacer()
                Text(item.title)
                    .font(.headline)
                    .lineLimit(1)
                    .flyAway {
                        navigator.push(.info(item))
                    }
                Spacer()
            }
            .padding()

            ArticleDetailView(item: item)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct InfoScreen: View {
    let item: FeedItem
    @Bindable var navigator: Navigator

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button("Назад") { navigator.pop() }
                Spacer()
            }

            Text(item.title)
                .font(.title2.bold())

            if let site = item.newsSite {
                Text(site)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let date = item.publishedAt {
                Text(date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(item.summary)
                .font(.body)

            if let url = item.url {
                Text(url)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.systemBackground))
    }
}

struct ArticleView: UIViewControllerRepresentable {
    let item: FeedItem
    @Binding var isSelected: Bool

    func makeUIViewController(context: Context) -> ArticleViewController {
        ArticleViewController(item: item)
    }

    func updateUIViewController(_ uiViewController: ArticleViewController, context: Context) {
        uiViewController.makeSelected(isSelected)
    }
}

struct FavoriteView: UIViewRepresentable {
    @Binding var isSelected: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(view: self)
    }

    func makeUIView(context: Context) -> FavoriteUIView {
        let view = FavoriteUIView()
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: FavoriteUIView, context: Context) { }

    final class Coordinator: FavoriteUIViewDelegate {
        let view: FavoriteView

        init(view: FavoriteView) {
            self.view = view
        }

        func favoriteViewDidSelect(isSelected: Bool) {
            view.isSelected = isSelected
        }
    }
}

struct ContentView: View {
    @State private var navigator = Navigator()
    @State private var rubric: Rubric = .articles
    @State private var items: [FeedItem] = []
    @State private var page: Page? = Page(limit: 10, offset: 0)
    @State private var isLoading = false

    var body: some View {
        CustomNavigationStack(navigator: navigator) {
            VStack(spacing: 0) {
                Picker("Рубрика", selection: $rubric) {
                    ForEach(Rubric.allCases) { rubric in
                        Text(rubric.title).tag(rubric)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    ForEach(items) { item in
                        Text(item.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .flyAway {
                                navigator.push(.detail(item))
                            }
                    }
                    if page != nil {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .onAppear {
                            Task {
                                await loadNextPage()
                            }
                        }
                    }
                }
            }
        }
        .task(id: rubric) {
            items = []
            page = Page(limit: 10, offset: 0)
            await loadNextPage()
        }
    }

    @MainActor
    private func loadNextPage() async {
        guard let currentPage = page, !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            switch rubric {
            case .articles:
                let list = try await ArticlesAPI.articlesList(
                    limit: currentPage.limit,
                    offset: currentPage.offset,
                    apiConfiguration: .spaceflight
                )
                try Task.checkCancellation()
                items.append(contentsOf: list.results.map(FeedItem.init(article:)))
                page = getPage(from: list.next)
            case .blogs:
                let list = try await BlogsAPI.blogsList(
                    limit: currentPage.limit,
                    offset: currentPage.offset,
                    apiConfiguration: .spaceflight
                )
                try Task.checkCancellation()
                items.append(contentsOf: list.results.map(FeedItem.init(blog:)))
                page = getPage(from: list.next)
            case .reports:
                let list = try await ReportsAPI.reportsList(
                    limit: currentPage.limit,
                    offset: currentPage.offset,
                    apiConfiguration: .spaceflight
                )
                try Task.checkCancellation()
                items.append(contentsOf: list.results.map(FeedItem.init(report:)))
                page = getPage(from: list.next)
            }
        } catch {
        }
    }
}

#Preview {
    ContentView()
}
