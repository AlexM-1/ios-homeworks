

import UIKit
import StorageService
class ProfileViewController: UIViewController, UISearchResultsUpdating {
    
    private let viewModel: ProfileViewModel

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search by author"
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        return searchController
    }()



    private var posts: [Post] {
        if (searchController.searchBar.text ?? "") == "" {
            return CoreDataManager.default.posts
        } else {
            return CoreDataManager.default.searchPost(searchController.searchBar.text ?? "")
        }
    }
    

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
        //let user = viewModel.userService.getUser(name: viewModel.name)
        //  let user = User()

        let profileHeaderView = ProfileHeaderView(frame: .zero, user: viewModel.user)
        return profileHeaderView
    }()


    func updateSearchResults(for searchController: UISearchController) {
        // let searchText = searchController.searchBar.text ?? ""
        //        if searchText != ""

        self.tableView.reloadData()
    }


    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupView()
        if viewModel.state == .favorite {
            navigationItem.title = "Favorite posts"
        }
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

        CoreDataManager.default.addPost(author: modelPost.author, description: modelPost.description, imageName: modelPost.image, likes: modelPost.likes, views: modelPost.views)
        let center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
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


}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if viewModel.state == .profile { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel.state == .profile {
            if section == 0 { return 1 }
            else { return viewModel.posts.count }

        } else { return posts.count}

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

        let post = posts[indexPath.row]
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
                let post = CoreDataManager.default.posts[indexPath.row]
                CoreDataManager.default.deletePost(post: post)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
            }
        }
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










