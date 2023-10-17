import Foundation

class TriviaQuestionService {
    private let baseURL = "https://opentdb.com/api.php"
    
    func fetchTriviaQuestions(amount: Int = 5, completion: @escaping ([TriviaQuestion]?) -> Void) {
        guard let url = URL(string: "\(baseURL)?amount=\(amount)&type=multiple") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            if let apiResponse = try? decoder.decode(APIResponse.self, from: data) {
                let triviaQuestions = apiResponse.results.enumerated().map { index, apiQuestion in
                    TriviaQuestion(id: index, from: apiQuestion)
                }
                completion(triviaQuestions)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    struct APIResponse: Codable {
        var results: [APIQuestion]
    }
    
    struct APIQuestion: Codable {
        var category: String
        var question: String
        var correct_answer: String
        var incorrect_answers: [String]
    }
}

