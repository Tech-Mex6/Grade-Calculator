

import Foundation
import UIKit

class Classes{
    var courseName: String
    var gradeLetter: String
    var gradePoint: Double = 0.000
    var creditHours: Double
    
    init(courseName: String, gradeLetter: String, creditHours: Double, gradePoint: Double) {
        self.courseName   = courseName
        self.gradeLetter  = gradeLetter
        self.creditHours  = creditHours
    }
    
    static func calculateGPA(for classes: [Classes])-> Double?{
        guard !classes.isEmpty else{
            return nil
        }
        var totalCredits     = 0.0
        var totalCreditHours = 0.0
        for _class in classes{
            totalCredits     = totalCredits + (_class.gradePoint * _class.creditHours)
            totalCreditHours = totalCreditHours + _class.creditHours
        }
        guard totalCreditHours != 0 else {return 0.00}
        let gpa = round(totalCredits * 100/totalCreditHours)/100
        return gpa
    }
    
    static func fourPointGrades(gradeLetter: String) -> Double{
        var gradePoint = 0.0
        if gradeLetter == "A+"{
            gradePoint = 4.0
        }else if gradeLetter == "A"{
            gradePoint = 4.0
        }else if gradeLetter == "A-"{
            gradePoint = 3.7
        }else if gradeLetter == "B+"{
            gradePoint = 3.0
        }else if gradeLetter == "B-"{
            gradePoint = 2.7
        }else if gradeLetter == "C+"{
           gradePoint = 2.3
        }else if gradeLetter == "C-"{
            gradePoint = 1.7
        }else if gradeLetter == "D+"{
            gradePoint = 1.3
        }else if gradeLetter == "D"{
           gradePoint = 1.0
        }else if gradeLetter == "F"{
            gradePoint = 0.0
        }
        return gradePoint
    }
    
    static func fivePointGrades(gradeLetter: String) -> Double{
        var gradePoint = 0.0
            if gradeLetter == "A"{
                gradePoint = 5.0
            }else if gradeLetter == "B"{
                gradePoint = 4.0
            }else if gradeLetter == "C"{
                gradePoint = 3.0
            }else if gradeLetter == "D"{
                gradePoint = 2.0
            }else if gradeLetter == "E"{
                gradePoint = 1.0
            }else if gradeLetter == "F"{
                gradePoint = 0.0
            }
        return gradePoint
    }
}

