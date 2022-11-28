//
//  main.swift
//  MyCreditManager
//
//  Created by 김진우 on 2022/11/11.
//

import Foundation

struct Student {
    var name: String
    var subjectAndGrades: [String: Grades]
}

struct Grades {
    var num: Int
    var grades: String
}


var studentList = [String: Student]()

mainLogic()

func mainLogic() {
    while true {
        PrintMention()
        let input = readLine()!
        
        switch input {
        case "1":
            AddStudent()
        case "2":
            DelStudent()
        case "3":
            ChangeGrades()
        case "4":
            DelGrades()
        case "5":
            AvgGrades()
        case "X":
            print("프로그램을 종료합니다...")
            exit(0)
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            continue
        }
    }
}

func PrintMention() {
    var menuList = [String]()
    menuList.append("학생추가")
    menuList.append("학생삭제")
    menuList.append("성적추가(변경)")
    menuList.append("성적삭제")
    menuList.append("평점보기")
    menuList.append("종료")
    
    print("원하는 기능을 입력해주세요")
    menuList.enumerated().forEach { (index, item) in
        if menuList.count != index + 1 {
            print("\(index + 1): \(item)," ,terminator: " ")
        } else {
            print("X: \(item)")
        }
    }
}

func AddStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    let studentName = readLine()!
    
    if studentName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        if studentList[studentName] == nil {
            print("\(studentName) 학생을 추가했습니다.")
            studentList[studentName] = Student(name: studentName, subjectAndGrades: [:])
        } else {
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
    }
}

func DelStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let studentName = readLine()!
    
    if studentList[studentName] != nil {
        print("\(studentName) 학생을 삭제하였습니다.")
        studentList[studentName] = nil
    } else {
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
}

func ChangeGrades() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    let inputData = readLine()!.components(separatedBy: " ")
    
    if studentList[inputData[0]] == nil || inputData.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        let subjectCount = studentList[inputData[0]]?.subjectAndGrades.count ?? 0
        if let item = studentList[inputData[0]]?.subjectAndGrades[inputData[1]] {
            studentList[inputData[0]]?.subjectAndGrades[inputData[1]] = Grades(num: item.num, grades: inputData[2])
        } else {
            studentList[inputData[0]]?.subjectAndGrades[inputData[1]] = Grades(num: subjectCount - 1, grades: inputData[2])
        }
        print("\(inputData[0]) 학생의 \(inputData[1]) 과목이 \(inputData[2])로 추가(변경)되었습니다.")
    }
}

func DelGrades() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    let inputData = readLine()!.components(separatedBy: " ")
    
    if inputData.count == 2 {
        if studentList[inputData[0]] == nil {
            print("\(inputData[0]) 학생을 찾지 못했습니다.")
        } else {
            studentList[inputData[0]]?.subjectAndGrades[inputData[1]] = nil
            print("\(inputData[0]) 학생의 \(inputData[1]) 과목의 성적이 삭제되었습니다.")
        }
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
}

func AvgGrades() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    let name = readLine()!
    var avg = 0.0
    var count = 0.0
    if studentList[name] != nil {
        count = Double(studentList[name]?.subjectAndGrades.count ?? 0)
        studentList[name]?.subjectAndGrades.sorted {
            $0.value.num > $1.value.num
        }.forEach {
            print("\($0.key): \($0.value.grades)")
            switch $0.value.grades {
            case "A+":
                avg += 4.5
            case "A":
                avg += 4
            case "B+":
                avg += 3.5
            case "B":
                avg += 3
            case "C+":
                avg += 2.5
            case "C":
                avg += 2
            case "D+":
                avg += 1.5
            case "D":
                avg += 1
            case "F":
                avg += 0
                
            default:
                break
            }
        }
        avg /= count
        print("평점 : \(String(format: "%.2f", avg))")
    } else if name != "" {
        print("\(name) 학생을 찾지 못했습니다.")
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
}

