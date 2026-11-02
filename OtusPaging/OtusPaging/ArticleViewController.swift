import UIKit

final class ArticleViewController: UIViewController {
    private let item: FeedItem

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let authorLabel = UILabel()

    init(item: FeedItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.spacing = 8
        stackView.axis = .vertical

        titleLabel.text = item.title
        textLabel.text = item.summary
        authorLabel.text = item.authorName

        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        textLabel.font = .systemFont(ofSize: 16, weight: .regular)
        authorLabel.font = .systemFont(ofSize: 13, weight: .regular)

        authorLabel.textColor = .lightGray

        titleLabel.numberOfLines = 0
        textLabel.numberOfLines = 0

        view.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(UIView())

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    func makeSelected(_ isSelected: Bool) {
        titleLabel.backgroundColor = isSelected ? UIColor.red.withAlphaComponent(0.3) : .clear
    }
}
