//
//  TaskCell.swift
//

import UIKit

class TaskCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!

    var onCompleteButtonTapped: ((Task) -> Void)?
    var task: Task?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here.
    }

    func configure(with task: Task, onCompleteButtonTapped: @escaping (Task) -> Void) {
        // Save the task
        self.task = task
        // Save the closure
        self.onCompleteButtonTapped = onCompleteButtonTapped
        // Set up the rest of your cell
        titleLabel.text = task.title

        // Adjust the appearance of the completeButton based on the task's completion status
        let buttonTitle = task.isComplete ? "Incomplete" : "Complete"
        completeButton.setTitle(buttonTitle, for: .normal)
        completeButton.backgroundColor = task.isComplete ? .gray : .green
    }

    @IBAction func completeButtonTapped(_ sender: UIButton) {
        guard let task = task else { return }
        // Call the completion handler when the button is tapped.
        onCompleteButtonTapped?(task)
    }
}

