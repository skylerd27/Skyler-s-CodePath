import Foundation


struct Task: Codable {
    var id: UUID // A unique identifier for each task.
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var createdDate: Date
    var completedDate: Date?

    // Existing initializers and methods...
}

// Task + UserDefaults extension.
extension Task {
    private static let tasksKey = "tasks"

    // Save an array of tasks to UserDefaults.
    static func save(tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getTasks() -> [Task] {
        let decoder = JSONDecoder()
        if let tasksData = UserDefaults.standard.data(forKey: tasksKey),
           let tasks = try? decoder.decode([Task].self, from: tasksData) {
            return tasks
        }
        return []
    }

    // Add a new task or update an existing task with the current task.
    func save() {
        var tasks = Task.getTasks()
        if let index = tasks.firstIndex(where: { $0.id == self.id }) {
            tasks[index] = self
        } else {
            tasks.append(self)
        }
        Task.save(tasks: tasks)
    }

    // Delete an existing task.
    func delete() {
        var tasks = Task.getTasks()
        tasks.removeAll { $0.id == self.id }
        Task.save(tasks: tasks)
    }
    
    // Initialize a new task
    init(title: String, isComplete: Bool, dueDate: Date, createdDate: Date) {
        self.id = UUID() // Assign a new unique identifier.
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.createdDate = createdDate
    }
}

