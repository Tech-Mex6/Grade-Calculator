# Grade-Calculator
This is a college/university grade calculator that caters to both the 4-point and 5-point grade scale.

<img width="457" alt="Screen Shot 2022-02-11 at 1 46 19 PM" src="https://user-images.githubusercontent.com/61053657/153659360-87c44759-9e62-4133-8a94-eeec1c005b5c.png">

<img width="479" alt="Screen Shot 2022-02-11 at 1 49 42 PM" src="https://user-images.githubusercontent.com/61053657/153659786-2abe90bd-c676-4bc3-8a18-a8e18f64ff39.png">

# Prerequisite
What things you need to install the software
- Xcode: IDE to build and run the project

# Project Structure
The project has one major view controller. This is the first screen the user lands on and it contains a picker view at the top of the screen, which enables you to select the grade system that your calculations will be based upon. It also has a button at the bottom of the screen that enables you to add a new semester. Calculations are done simultaneously with the addition of new classes. The GPA label is updated with the user's most recent GPA(grade point average) and at the bottom of the screen, right above the "Add Semester" button, there is a CGPA(cumulative grade point average) label that is updated with your most recent CGPA after every semester.

# Architecture
This project is built upon the MVC design pattern

# View Layer
The entirety of this application is built programmatically. however, the tableview cells, headers and footers are built as Xib files.


