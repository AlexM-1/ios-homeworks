
import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private let contentMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()


    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()


    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupCell(model: PostModel) {
        
        if let image = UIImage(named: model.image) {
            let imageProcessor =  ImageProcessor()
            let filter = [
                ColorFilter.colorInvert,
                ColorFilter.crystallize(radius: 10),
                ColorFilter.gaussianBlur(radius: 10),
                ColorFilter.posterize
            ].randomElement()!


            imageProcessor.processImage(
                sourceImage: image,
                filter: filter) {
                    filterPicture in
                    postImageView.image = filterPicture
                }
        }

        authorLabel.text = model.author
        descriptionLabel.text = model.description
        likesLabel.text = String(format: "any_likes".localizable, model.likes)
        viewsLabel.text = "Views".localizable + ": \(model.views)"
    }


    func setupCell(post: Post) {

        authorLabel.text = post.author
        descriptionLabel.text = post.text
        likesLabel.text = String(format: "any_likes".localizable, post.likes)
        viewsLabel.text = "Views".localizable + ": \(post.views)"

        // get Image from binary data

        if let image = UIImage(data: post.image ?? Data()) {
            postImageView.image = image
        }


    }


    private func layout() {

        [contentMainView, authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            contentMainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentMainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentMainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentMainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            authorLabel.topAnchor.constraint(equalTo: contentMainView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -16),

            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 16),

            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentMainView.bottomAnchor, constant: -16)
        ])

    }

}
