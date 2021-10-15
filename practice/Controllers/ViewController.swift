

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var gradeSystemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var cumulativeGradePointAverage: UILabel!
    
    private var numberOfClasses             = 0
    private var numberOfSemesters           = 0
    
    var gradeSystemPickerData          = [String]()
    var fourPointGradeSystemPickerData = [String]()
    var fivePointGradeSystemPickerData = [String]()
    
    var selectedGradeSystemPicker = 0
    var selectedThePicker         = 0
    
    var classDict: [[Classes]] = [[Classes]]()
    var footer: Footer?            = nil
    
    
    var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        title                = "Grader"
        
        self.tableView.dataSource      = self
        self.tableView.delegate        = self
        
        
        let gradeSystemPicker          = UIPickerView()
        gradeSystemPicker.delegate     = self
        gradeSystemPicker.dataSource   = self
        gradeSystemTextField.inputView = gradeSystemPicker
        gradeSystemPickerData          = ["4 Points", "5 Points"]
        
        fourPointGradeSystemPickerData = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F"]
        fivePointGradeSystemPickerData = ["A", "B", "C", "D", "E", "F"]
        
        self.tableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.register(UINib(nibName: "Footer", bundle: nil), forHeaderFooterViewReuseIdentifier: "footer")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: Notification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        let bottomSafeAreaHeight = self.view.safeAreaInsets.bottom
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height - bottomSafeAreaHeight - 91.33 , right: 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc func keyboardWillHide(){
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        // reset the content inset back to zero after keyboard is dismissed
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }

    
    //MARK: - PICKER VIEW
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.gradeSystemPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGradeSystemPicker = row
        gradeSystemTextField.text = gradeSystemPickerData[row]
        gradeSystemTextField.resignFirstResponder()
        tableView.reloadData()
    }
    //MARK: - TABLE VIEW DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfClasses = classDict[section].count
        return numberOfClasses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _classes =  classDict[indexPath.section]
        if _classes.count > indexPath.row {
            let _class = _classes[indexPath.row]
            var cell = tableView.dequeueReusableCell(withIdentifier: "Stack")
            if (cell == nil)
            {
                tableView.register(UINib.init(nibName: "Stack", bundle: nil), forCellReuseIdentifier: "Stack")
                cell = tableView.dequeueReusableCell(withIdentifier: "Stack")
            }
            if let stackCell = cell as? Stack {
                stackCell.gradeSystem               = selectedGradeSystemPicker
                stackCell.courseTitleTextField.text = _class.courseName
                stackCell.creditHoursTextField.text = String(_class.creditHours)
                stackCell.Grades.text               = _class.gradeLetter
                stackCell.classIndex                = indexPath.row
                stackCell.semesterIndex             = indexPath.section
                stackCell.classInfoUpdated          = self.didUpdateClassInfo
            }
        
            return cell!
        }else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSemesters = classDict.count
        return numberOfSemesters
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// implements the swipe to delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
            numberOfClasses = classDict[indexPath.section].count
            classDict[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            numberOfClasses -= 1
    }
    
    
    
    //MARK: - SECTION HEADER AND FOOTER
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header"), let headerView = view as? Header else{
            return nil
        }
        if headerView.deleteSemesterTapped == nil{
            headerView.deleteSemesterTapped = self.didDeleteSemester
        }
        headerView.sectionIndex = section
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer"), let footerView = view as? Footer else{
            return nil
        }
        if footerView.addClassTapped == nil {
            footerView.addClassTapped = self.didAddClass
        }
        footerView.sectionNumber = section
        footerView.backgroundColor = .systemGray
        footerView.classGPA = Classes.calculateGPA(for: self.classDict[section])
        
        var semesters = [Semesters]()
        
        for i in 0..<self.classDict.count {
            let semester = Semesters.init(classes: self.classDict[i])
            semesters.append(semester)
        }
        self.cumulativeGradePointAverage.text = String.init (Semesters.calculateCGPA(for: semesters)!)

        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Semester \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    
    //MARK: - ADD CLASS, ADD SEMESTER & DELETE SEMESTER METHODS
    
    /// Responsible for the addition of sections/semesters to the table view
    @IBAction func addSemesterButton(_ sender: Any) {
        classDict.append([Classes]())
        //tableView.insertSections(IndexSet(arrayLiteral: classDict.count), with: .automatic)
        numberOfSemesters += 1
        tableView.reloadData()
    }
    
    func didAddClass(sectionNumber: Int) {
        let newClass = Classes(courseName: "", gradeLetter: "", creditHours: 0.0, gradePoint: 0.00)
        classDict[sectionNumber].append(newClass)
        numberOfClasses += 1
        tableView.reloadData()
    }
    
    func didUpdateClassInfo(semesterIndex:Int, classIndex: Int, courseName: String?, grade: String?, creditHours: String?) {
        let _classes =  classDict[semesterIndex]
        if _classes.count > classIndex {
            let _class = _classes[classIndex]
            _class.courseName = courseName ?? ""
            _class.gradeLetter = grade ?? ""
            _class.creditHours = Double(creditHours ?? "") ?? 0.0
            
            if selectedGradeSystemPicker == 0 {
            _class.gradePoint = Classes.fourPointGrades(gradeLetter: _class.gradeLetter)
            } else if selectedGradeSystemPicker == 1 {
                _class.gradePoint = Classes.fivePointGrades(gradeLetter: _class.gradeLetter)
            }
        }
        tableView.reloadData()
    }
    
    /// Responsible for the deletion of section/semesters from the table view
    func didDeleteSemester(sectionIndex: Int) {
        //classDict.removeValue(forKey: sectionIndex)
        classDict.remove(at: sectionIndex)
        tableView.reloadData()
    }
    
}

