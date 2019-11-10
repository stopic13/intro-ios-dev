import Foundation
import UIKit

class DisplayQuestionViewController: UIViewController{
    var quizObject: ApiResponse.QuizObject?
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func chooseTrue(_ sender: Any) {
        isAnswerCorrect(selectedAnswer: true)
    }
    
    @IBAction func chooseFalse(_ sender: Any) {
        isAnswerCorrect(selectedAnswer: false)
    }
    
    override func viewDidLoad() {
        questionLabel.text = quizObject!.question?.removingPercentEncoding
    }
    
    func isAnswerCorrect(selectedAnswer: Bool)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DisplayResultViewController") as! DisplayResultViewController
        controller.modalPresentationStyle = .overCurrentContext
        if ( Bool(quizObject!.correct_answer!.lowercased()) == selectedAnswer)
        {
            controller.imageName = "correctImage"
        }
        else
        {
            controller.imageName = "wrongImage"
        }
        present(controller, animated: true, completion: nil)
    }
}
