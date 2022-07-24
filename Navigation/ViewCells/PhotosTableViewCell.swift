
import UIKit

class PhotosTableViewCell: UITableViewCell {

    private var leftMargin: CGFloat { return 12 }
    private var rightMargin: CGFloat { return 12 }
    private var inset: CGFloat { return 8 }

    private let contentMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()

    private var arrowForwardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()


    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()






    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func layout() {

        [contentMainView, label, arrowForwardImageView, collectionView].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            contentMainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentMainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentMainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentMainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),


            label.topAnchor.constraint(equalTo: contentMainView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -50),


            arrowForwardImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            arrowForwardImageView.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -12),
            arrowForwardImageView.heightAnchor.constraint(equalTo: label.heightAnchor),
            arrowForwardImageView.widthAnchor.constraint(equalTo: arrowForwardImageView.heightAnchor),


            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 3 * inset - leftMargin - rightMargin) / 4 + 24),
            collectionView.bottomAnchor.constraint(equalTo: contentMainView.bottomAnchor)
        ])

    }

}


extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell

        cell.setupCell(name: photos[indexPath.item], cornerRadius: 6)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - inset * 3 - rightMargin - leftMargin) / 4
        return CGSize(width: width, height: width)
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }


}
