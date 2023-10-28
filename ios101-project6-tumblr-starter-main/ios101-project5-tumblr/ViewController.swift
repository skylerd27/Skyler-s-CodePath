import UIKit
import Nuke

class ViewController: UIViewController {

    // Define the table view and posts array
    var tableView: UITableView!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Title
        title = "Blog Posts"

        setupTableView()
        fetchPosts()
    }

    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomPostCell.self, forCellReuseIdentifier: "customCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }

    func fetchPosts() {
        let urlString = "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk"
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)
                self?.posts = blog.response.posts

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomPostCell
        let post = posts[indexPath.row]

        // Reset image and text for reuse
        cell.postImageView.image = nil
        cell.postLabel.text = nil
        
        cell.postLabel.text = post.summary
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: cell.postImageView)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        navigationController?.pushViewController(postDetailVC, animated: true)

        // Unselect row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CustomPostCell: UITableViewCell {
    
    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16) // Adjust font size/style as needed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(postImageView)
        addSubview(postLabel)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            postImageView.heightAnchor.constraint(equalToConstant: 120),
            postImageView.widthAnchor.constraint(equalToConstant: 120),
            
            postLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            postLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 10),
            postLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            postLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        postLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


