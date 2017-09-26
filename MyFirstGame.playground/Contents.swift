//: Playground - noun: a place where people can play

import UIKit
import Foundation

struct Room {
    var w, h : Int

}

struct Point {
    var x, y : Int
}

enum MovePerson {
    case Left
    case Right
    case Up
    case Down
}


struct Person {
    static var target: Bool = false //глобальная цель, куда надо дотащить ящики
    
    var room: Room
    
    var hero: Point {
        didSet { //что бы герой не выходил за пределы поля
            if hero.x < 2 || hero.x == room.w {
                hero.x = oldValue.x
            }
            
            if hero.y < 2 || hero.y == room.h {
                hero.y = oldValue.y
            }
        }
        
    }


    let endPoint: Point
    var box: Point {
        didSet{
            if box.x < 2 || box.x > 6 {
                box.x = oldValue.x
            }
            if box.y < 2 || box.y > 6 {
                box.y = oldValue.y
            }
        }
    }
    
    func targetDone () {
        if box.x == endPoint.x && box.y == endPoint.y {
            Person.target = true
        }
    }
    
    mutating func move(direction: MovePerson, amount: Int = 1) {
        switch direction {
        case .Down:
            hero.y -= amount
            if hero.y == box.x && hero.x == box.x {
                box.y -= amount
                if box.y == hero.y{
                    
                    hero.y += amount
                    print("Не могу двигаться!")
               
                }
                
                targetDone()
            }
            
        case .Left:
            hero.x -= amount
            if hero.x == box.x && hero.y == box.y {
                box.y -= amount
                if box.y == hero.y {
                    hero.y += amount
                        print("Не могу двигаться")
                }
                
                targetDone()
            }
            
        case .Right:
            hero.x += amount
            if hero.x == box.x && hero.y == box.y {
                box.x += amount
                if box.x == hero.x {
                    hero.x -= amount
                    print("Не могу двигаться")
                }
                targetDone()
            }
            
        case .Up:
            hero.y += amount
            if hero.x == box.x && hero.y == box.y {
                box.y += amount
                if box.x == hero.y {
                    hero.y -= amount
                    print("Не могу двигаться")
                }
                targetDone()
            }
        }
    }
        
        func printField() {
            
            var str = ""
            
            for i in (1...room.h).reversed() {
                for j in 1...room.w {
                    if Person.target == true {
                        if i == 1 || i == room.h {
                            str.append("🆘") //красные границы по горизонтали
                        } else if j == 1 || j == room.w {
                            str.append("🆘") //красные границы по вертикали
                        } else {
                            str.append("👏") //выиграл!
                        }
                    }else if i == 1 || i == room.h {
                        str.append ("🆘")
                    } else if j == 1 || j == room.w {
                        str.append ("🆘")
                    } else if i == hero.y && j == hero.x {
                        str.append("🐶") //мой герой
                    } else if i == box.y && j == box.x {
                        str.append ("🎾") //мячик который нужно дотащить до цели
                    } else if i == endPoint.x && j == endPoint.y {
                        str.append ("🏁") //финиш куда нужно притащить мяч
                    } else {
                        str.append("◻") //границы фона для ходьбы
                    }
                }
                str.append("\n")
            }
        print(str)
        
        }
    }
    
        var person = Person (room: Room (w: 7, h: 7), hero: Point (x: 2, y: 2), endPoint: Point (x: 6, y: 6), box: Point (x: 4, y: 4))

person.printField()

person.move(direction: .Up)
person.move(direction: .Up)
person.move(direction: .Right)
person.move(direction: .Right)
person.move(direction: .Right)
person.move(direction: .Down)
person.move(direction: .Right)
person.move(direction: .Up)
person.move(direction: .Up)
person.printField()

