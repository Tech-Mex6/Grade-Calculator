

import Foundation
import UIKit

class Footer: UITableViewHeaderFooterView{
    
    @IBOutlet weak var gpaLabel: UILabel!
    var sectionNumber: Int = 0
    var addClassTapped:((Int)-> Void)?
    var classGPA: Double? {
        didSet{
            if let gpa = classGPA{
                gpaLabel.text = "GPA: \(gpa)"
                gpaLabel.textColor = .black
            }else{
                gpaLabel.text = "GPA: Add a class"
                gpaLabel.textColor = .gray
            }
        }
    }
    @IBAction func addClassButton(_ sender: Any) {
        print("add class button called")
        guard let addClassHandler = addClassTapped else { return }
        addClassHandler(sectionNumber)
    }
    
}
