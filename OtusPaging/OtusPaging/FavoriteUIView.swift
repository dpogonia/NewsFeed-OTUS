import UIKit

protocol FavoriteUIViewDelegate: AnyObject {
    func favoriteViewDidSelect(isSelected: Bool)
}

final class FavoriteUIView: UIView {
    weak var delegate: FavoriteUIViewDelegate?

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFill

        button.tintColor = .red
        button.backgroundColor = .white

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            button.isSelected.toggle()
            delegate?.favoriteViewDidSelect(isSelected: button.isSelected)
        }
        button.addAction(action, for: .touchUpInside)

        addSubview(button)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        button.frame = bounds
        layer.cornerRadius = bounds.height / 2
        button.layer.cornerRadius = bounds.height / 2
    }
}
