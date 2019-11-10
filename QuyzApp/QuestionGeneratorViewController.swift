//
//  QuestionGeneratorViewController.swift
//  QuyzApp
//
//  Created by Sara Topic on 10/6/19.
//  Copyright © 2019 Sara Topic. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct pickerItem {
    let categoryName: String?
    let categoryId: Int?
}

class QuestionGeneratorViewController: UIViewController{
    @IBOutlet weak var difficultySelector: UISegmentedControl!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBAction func generateQuestion(_ sender: Any) {
        let parameters: Parameters = [
            "amount": 1,
            "type": "boolean",
            "category": pickerData[categoryPicker.selectedRow(inComponent: 0)].categoryId!,
            "difficulty": difficultyData[difficultySelector.selectedSegmentIndex],
            "encode": "url3986"
        ]
        Alamofire.request("https://opentdb.com/api.php", method: .get,
                          parameters: parameters
            ).response { response in
                guard let data = response.data else { return }
                do {
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    let quizObject = apiResponse.results[0]
                    self.navigateToNextViewController(quizObject: quizObject)
                }
                catch {} //TODO: Handle error
        }
    }
    var pickerData: [pickerItem]  = [
            pickerItem(categoryName: "Books", categoryId: 10),
            pickerItem(categoryName: "Movies", categoryId: 12),
            pickerItem(categoryName: "Music", categoryId: 12),
            pickerItem(categoryName: "Mathematics", categoryId: 19),
            pickerItem(categoryName: "Politics", categoryId: 24),
            pickerItem(categoryName: "Art", categoryId: 25),
            pickerItem(categoryName: "Celebrities", categoryId: 26)
        ]
        
    var difficultyData: [String]  = [
            "easy", "medium", "hard"
        ]
    
    func navigateToNextViewController(quizObject: ApiResponse.QuizObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DisplayQuestionViewController") as! DisplayQuestionViewController
        controller.quizObject = quizObject
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func returnToFirstViewController(segue:UIStoryboardSegue) { }

}

extension QuestionGeneratorViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
}

extension QuestionGeneratorViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].categoryName;
    }
}
