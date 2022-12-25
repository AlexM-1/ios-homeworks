

import UIKit
import StorageService
import CoreData

class ProfileViewController: UIViewController, UISearchResultsUpdating {
    
    private let viewModel: ProfileViewModel

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search by author".localizable
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        return searchController
    }()

    var fetchedResultsController: NSFetchedResultsController<Post>!

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
        
    }()

    private lazy var addFavotiteView: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image!)
        imageView.tintColor = .systemPink
        imageView.alpha = 0.0
        imageView.backgroundColor = nil
        return imageView
    }()
    
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let profileHeaderView = ProfileHeaderView(frame: frame, user: viewModel.user)
        return profileHeaderView
    }()


    func updateSearchResults(for searchController: UISearchController) {
        initFetchResultsController()
        tableView.reloadData()
    }


    func initFetchResultsController() {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: false)]


        if let searchText = searchController.searchBar.text,
           searchText != "" {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchText)
        }


        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.default.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try? frc.performFetch()
        fetchedResultsController = frc
        fetchedResultsController.delegate = self
    }


    override func viewWillAppear(_ animated: Bool) {
        initFetchResultsController()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupView()
        dragInteractionSetup()
        if viewModel.state == .favorite {
            navigationItem.title = "Favorite posts".localizable
        }
    }

    private func dragInteractionSetup() {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self

    }


    private func setupGesture() {

        if viewModel.state == .profile {
            let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
            doubleTap.numberOfTapsRequired = 2
            self.tableView.addGestureRecognizer(doubleTap)
            doubleTap.delaysTouchesBegan = true
        }

    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        view.addSubview(addFavotiteView)
        createViewConstraint()
    }
    
    private func createViewConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }


    @objc func handleDoubleTap(dpgr: UITapGestureRecognizer) {

        let point = dpgr.location(in: tableView)
        tableView.indexPathForRow(at: point)
        guard let indexPath = tableView.indexPathForRow(at: point) else {return}

        let modelPost = viewModel.posts[indexPath.row]

        CoreDataManager.default.addPost(author: modelPost.author, description: modelPost.description, image: modelPost.image, likes: modelPost.likes, views: modelPost.views)
        let center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        addFavotiteView.center = center
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.addFavotiteView.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
            self.addFavotiteView.center = center

            self.addFavotiteView.alpha = 0.7
            self.view.layoutIfNeeded()
        }   completion: { _ in

            UIView.animate(withDuration: 0.5, delay: 0) {
                self.addFavotiteView.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
                self.addFavotiteView.center = center
                self.addFavotiteView.alpha = 0.0
                self.view.layoutIfNeeded()
            }

        }
    }



    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {

        if let itemCell = tableView.cellForRow(at: indexPath) as? PostTableViewCell,
           let image = itemCell.getPostImageViewImage(),
           let description = itemCell.getDescriptionLabelText() as? NSString {
            let dragItemImage = UIDragItem(itemProvider: NSItemProvider(object: image))
            let dragItemString = UIDragItem(itemProvider: NSItemProvider(object: description))
            return [dragItemImage, dragItemString]
        } else {
            return []
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if viewModel.state == .profile { return 2 }
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel.state == .profile {
            if section == 0 { return 1 }
            else { return viewModel.posts.count }
        } else {
            return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0, viewModel.state == .profile {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        }

        if viewModel.state == .profile {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.setupCell(model: viewModel.posts[indexPath.row])
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        let post = fetchedResultsController.object(at: indexPath)
        cell.setupCell(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.changeState(.cellDidTap)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if viewModel.state == .favorite {
            if editingStyle == .delete {
                let post = fetchedResultsController.object(at: indexPath)
                CoreDataManager.default.deletePost(post: post)
            } else if editingStyle == .insert {
            }
        }
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if viewModel.state == .profile {
            return false
        }
        return true
    }
}


extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0, viewModel.state == .profile {
            return profileHeaderView
        }
        return nil
    }
    
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 { return 0 }
        return UITableView.automaticDimension
    }


}


extension ProfileViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        if viewModel.state == .favorite {
            switch type {
            case .insert:
                guard let newIndexPath = newIndexPath else { return }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .delete:
                guard let indexPath = indexPath else { return }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .move:
                guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { return }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                print("Fatal error")
            }

        }
    }

    //    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    //        tableView.reloadData()
    //    }



}


extension ProfileViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        // session.localContext = tableView
        return dragItems(at: indexPath)
    }
}

extension ProfileViewController: UITableViewDropDelegate {




    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        var newPostDescription: String?
        var newPostImage: UIImage?

        guard coordinator.items.count == 2 else {return}
        guard coordinator.session.localDragSession == nil else {return}

        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: 0, section: 1)

        for item in coordinator.items {

            item.dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (provider, error) in
                if let image = provider as? UIImage {
                    newPostImage = image
                }

                item.dragItem.itemProvider.loadObject(ofClass: NSString.self) { (provider, error) in
                    if let description = provider as? NSString {
                        newPostDescription = description as String
                    }

                    DispatchQueue.main.async {
                        if newPostDescription != nil, newPostImage != nil {
                            let newPost = PostModel(author: "Drag&Drop", description: newPostDescription!, image: newPostImage!, likes: 0, views: 0)
                            self.viewModel.posts.insert(newPost, at: destinationIndexPath.row)
                            self.tableView.reloadData()
                        }
                    }

                }
            }
        }
    }


    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {

        return session.canLoadObjects(ofClass: UIImage.self) && (session.canLoadObjects(ofClass: NSString.self))
    }


    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }

}







