import UIKit

class PostTableViewCell: UITableViewCell {
    
    var postImageView: UIImageView!
    var summaryLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        postImageView = UIImageView(frame: .zero)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postImageView)
        
        summaryLabel = UILabel(frame: .zero)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        contentView.addSubview(summaryLabel)
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postImageView.widthAnchor.constraint(equalToConstant: 100),
            postImageView.heightAnchor.constraint(equalToConstant: 100),
            
            summaryLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

