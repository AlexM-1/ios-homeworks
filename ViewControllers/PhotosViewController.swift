
import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    //    private let imagePublisherFacade = ImagePublisherFacade()
    //    private var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo Gallery"
        self.navigationController?.isNavigationBarHidden = true
        layout()
        setupCollections()
        imageProcessing()
        
        //        imagePublisherFacade.subscribe(self)
        //
        //        imagePublisherFacade.addImagesWithTimer(
        //            time: 0.2,
        //            repeat: 30,
        //            userImages: nil
        //        )
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //
        //        self.imagePublisherFacade.removeSubscription(for: self)
        //        self.imagePublisherFacade.rechargeImageLibrary()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.layer.cornerRadius = 6
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    
    
    
    private func setupCollections() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func layout(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func imageProcessing() {
        
        let imageProcessor = ImageProcessor()
        
        
        // filter: .chrome
        
        let startTimeChrome = CACurrentMediaTime()
        print("imageProcessor start with filter: .chrome, qos: .userInteractive")
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .chrome, qos: .userInteractive) { _ in
            
            let endTime = CACurrentMediaTime()
            print("Total Runtime with filter: .chrome, qos: .userInteractive: \(endTime - startTimeChrome) s")
            
        }
        
        // filter: .posterize
        
        let startTimePosterize = CACurrentMediaTime()
        print("imageProcessor start with filter: .posterize, qos: .userInitiated")
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .posterize, qos: .userInitiated) {  _ in
            
            let endTime = CACurrentMediaTime()
            print("Total Runtime with filter: .posterize, qos: .userInitiated: \(endTime - startTimePosterize) s")
            
        }
        
        // filter: .crystallize
        
        let startTimeCrystallize = CACurrentMediaTime()
        print("imageProcessor start with filter: .crystallize, qos: .utility")
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .crystallize(radius: 4.0), qos: .utility) {  _ in
            
            let endTime = CACurrentMediaTime()
            print("Total Runtime with filter: .crystallize, qos: .utility: \(endTime - startTimeCrystallize) s")
            
        }
        
        // filter: .gaussianBlur
        
        let startTimeGaussianBlur = CACurrentMediaTime()
        print("imageProcessor start with filter: .gaussianBlur, qos: .default")
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .gaussianBlur(radius: 7.5), qos: .default) {  _ in
            
            let endTime = CACurrentMediaTime()
            print("Total Runtime with filter: filter: .gaussianBlur, qos: .default: \(endTime - startTimeGaussianBlur) s")
            
        }
        
        // filter: .colorInvert
        
        let startTimeColorInvert = CACurrentMediaTime()
        print("imageProcessor start with filter: .colorInvert, qos: .background")
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .colorInvert, qos: .background) {  _ in
            
            let endTime = CACurrentMediaTime()
            print("Total Runtime with filter: .colorInvert, qos: .background: \(endTime - startTimeColorInvert) s")
            
        }
        
        
        
    }
    
    
    
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.setupCell(image: images[indexPath.item], cornerRadius: 0)
        return cell
    }
    
    
    
}


//extension PhotosViewController: ImageLibrarySubscriber {
//
//    func receive(images: [UIImage]) {
//        self.images = images
//        collectionView.reloadData()
//    }
//
//}


// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    //        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //            print("Ячейка  \(indexPath.item)")
    //        }
    
}




