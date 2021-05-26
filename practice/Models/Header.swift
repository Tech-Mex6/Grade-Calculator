
import Foundation
import UIKit

class Header: UITableViewHeaderFooterView {
    
    var sectionIndex: Int = 0
    var deleteSemesterTapped:((Int)-> Void)?

    @IBAction func deleteSemester(_ sender: Any) {
        guard let deleteSemesterHandler = deleteSemesterTapped else {return}
        deleteSemesterHandler(sectionIndex)
    }
}
