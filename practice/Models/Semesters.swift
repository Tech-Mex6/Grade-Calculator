//
//  Semesters.swift
//  practice
//
//  Created by meekam okeke on 3/2/21.
//

import Foundation
import UIKit

class Semesters {
    var classes: [Classes] = []
    
    init(classes: [Classes]) {
        self.classes = classes
    }
    
    static func calculateCGPA (for semesters: [Semesters])-> Double? {
        guard !semesters.isEmpty else{
            return nil
        }
       
        var totalCreditHours = 0.0
        var totalGPA         = 0.00
        var weighedAverage   = 0.0
       
        for semester in semesters {
            var semesterTotalCredits = 0.00
            var semesterTotalCreditHours = 0.0
            var semesterGPA = 0.00
            
            for _class in semester.classes {
                semesterTotalCredits = semesterTotalCredits + (_class.gradePoint * _class.creditHours)
                semesterTotalCreditHours = semesterTotalCreditHours + _class.creditHours
            }
            if semesterTotalCreditHours > 0 {
            totalCreditHours = totalCreditHours + semesterTotalCreditHours
            semesterGPA = semesterTotalCredits / semesterTotalCreditHours
            totalGPA = totalGPA + semesterGPA
            weighedAverage = weighedAverage + (totalCreditHours * totalGPA)
            }
        }
        //let cumulativeGradePoint = round(weighedAverage * 100/totalCreditHours)/100
        let cumulativeGradePoint =  round(totalGPA * 100 / Double(semesters.count))/100
        
        return cumulativeGradePoint
    }
}

//totalCreditHours = totalCreditHours + _class.creditHours
//totalCredits     = totalCredits + (_class.gradePoint * _class.creditHours)
//totalGPA         = totalGPA + (totalCredits * totalCreditHours)
//weighedAverage   = weighedAverage + (totalCreditHours * totalGPA)
