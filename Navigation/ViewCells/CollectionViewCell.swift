
import UIKit

class CollectionViewCell: UICollectionViewCell {


    private var fotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    func setupCell(name: String, cornerRadius: CGFloat) {
        fotoImageView.image = UIImage(named: name)
        fotoImageView.layer.cornerRadius = cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func layout() {
        contentView.addSubview(fotoImageView)

        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}
