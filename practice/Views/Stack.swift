
import Foundation
import UIKit


class Stack: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    var fourPointGradeSystemPickerData = [" ","A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F"]
    var fivePointGradeSystemPickerData = [" ","A", "B", "C", "D", "E", "F"]
    
    var gradeSystem: Int = 0
    
    var classInfoUpdated: ((Int, Int, String?, String?, String?)-> Void)?
    
    var semesterIndex: Int = 0
    var classIndex: Int = 0
    
    var activeTextField: UITextField? = nil
    
    @IBOutlet weak var courseTitleTextField: UITextField!
    @IBOutlet weak var Grades: UITextField!
    @IBOutlet weak var creditHoursTextField: UITextField!
    
    override func awakeFromNib() {
        
        let gradePickerView        = UIPickerView()
        gradePickerView.dataSource = self
        gradePickerView.delegate   = self
        Grades.inputView           = gradePickerView
        
        courseTitleTextField.delegate     = self
        courseTitleTextField.keyboardType = .default
        
        creditHoursTextField.delegate     = self
        creditHoursTextField.keyboardType = .numbersAndPunctuation
        
        super.awakeFromNib()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if gradeSystem == 0 {
            return fourPointGradeSystemPickerData.count
        }else if gradeSystem == 1{
            return fivePointGradeSystemPickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if gradeSystem == 0{
            return fourPointGradeSystemPickerData[row]
        }else if gradeSystem == 1{
            return fivePointGradeSystemPickerData[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if gradeSystem == 0 {
            Grades.text = fourPointGradeSystemPickerData[row]
            Grades.resignFirstResponder()
            if let handler = classInfoUpdated{
                handler(semesterIndex, classIndex,courseTitleTextField.text, Grades.text, creditHoursTextField.text)
            }
        }else if gradeSystem == 1{
            Grades.text = fivePointGradeSystemPickerData[row]
            Grades.resignFirstResponder()
        }
        
        delegateHandler()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegateHandler()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func delegateHandler(){
        if let handler = classInfoUpdated{
            handler(semesterIndex, classIndex,courseTitleTextField.text, Grades.text, creditHoursTextField.text)
        }
    }
}

