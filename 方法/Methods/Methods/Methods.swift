//
//  Methods.swift
//  Methods
//
//  Created by dyf on 2017/10/10.
//  Copyright © 2017 dyf. All rights reserved.
//

import UIKit

class Methods: NSObject {
    
    func execute() -> Void {
//        实例方法
//        类型方法
        
//        方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。
        
//        结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
        
//        实例方法 (Instance Methods)
//        实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致，详情参见函数。
        
//        实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。
        
//        下面的例子，定义一个很简单的Counter类，Counter能被用来对一个动作发生的次数进行计数：
        class Counter {
            var count: Int = 0
            
            func increment() -> Void {
                count += 1
            }
            
            func increment(by amount: Int) {
                count += amount
            }
        
            func reset() {
                count = 0
            }
        }
        
//        Counter这个类还声明了一个可变属性count，用它来保持对当前计数器值的追踪。
        
//        和调用属性一样，用点语法（dot syntax）调用实例方法：
        let counter = Counter()
        // 初始计数值是0
        counter.increment()
        // 计数值现在是1
        counter.increment(by: 5)
        // 计数值现在是6
        counter.reset()
        // 计数值现在是0
        
//        函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用），详情参见指定外部参数名。方法参数也一样，因为方法就是函数，只是这个函数与某个类型相关联了。
        
//        self 属性
//        类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例。
        class Counter2 {
            var count: Int = 0
            
            func increment() {
                self.count += 1
            }
        }
        
//        你不必在你的代码里面经常写self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的Counter中已经示范了：Counter中的三个实例方法中都使用的是count（而不是self.count）。
        
//        使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
        
//        下面的例子中，self消除方法参数x和实例属性x之间的歧义：
        
        struct Point {
            var x = 0.0, y = 0.0
            func isToTheRightOfX(_ x: Double) -> Bool {
                return self.x > x
            }
        }
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOfX(1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        // 打印 "This point is to the right of the line where x == 1.0"
//        如果不使用self前缀，Swift 就认为两次使用的x都指的是名称为x的函数参数。
        
//        在实例方法中修改值类型
//        结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
        
//        但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
        
//        要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
        struct PointB {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self.x += deltaX
                self.y += deltaY
            }
        }
        var somePointB = PointB(x: 1.0, y: 1.0)
        somePointB.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePointB.x), \(somePointB.y))")
        // 打印 "The point is now at (3.0, 4.0)"

//        注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性，详情参见常量结构体的存储属性：
        let fixedPoint = PointB(x: 3.0, y: 3.0)
        //fixedPoint.moveByXy(x: 2.0, y: 3.0)
        // 这里将会报告一个错误
        
//        在可变方法中给 self 赋值
//        可变方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：
        struct PointC {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = PointC(x: x + deltaX, y: y + deltaY)
            }
        }

//        枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
        
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case .Off:
                    self = .Low
                case .Low:
                    self = .High
                case .High:
                    self = .Off
                }
            }
        }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off

//        类型方法
//        实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
        
//        注意
//        在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
//        类型方法和实例方法一样用点语法调用。但是，你是在类型上调用这个方法，而不是在实例上调用。下面是如何在SomeClass类上调用类型方法的例子：
        
        class SomeClass {
            class func someTypeMethod() {
                // 在这里实现类型方法
            }
        }
        
        SomeClass.someTypeMethod()
        
//        一般来说，在类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称。类似地，在结构体和枚举中，也能够直接通过类型属性的名称访问本类中的类型属性，而不需要前面加上类型名称。
        
//        下面的例子定义了一个名为LevelTracker结构体。它监测玩家的游戏发展情况（游戏的不同层次或阶段）。这是一个单人游戏，但也可以存储多个玩家在同一设备上的游戏信息。
        
//        游戏初始时，所有的游戏等级（除了等级 1）都被锁定。每次有玩家完成一个等级，这个等级就对这个设备上的所有玩家解锁。LevelTracker结构体用类型属性和方法监测游戏的哪个等级已经被解锁。它还监测每个玩家的当前等级。
        
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            var currentLevel = 1
            
            static func unlock(_ level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }
            
            static func isUnlocked(_ level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
            
            @discardableResult
            mutating func advance(to level: Int) -> Bool {
                if LevelTracker.isUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
//        为了便于管理currentLevel属性，LevelTracker定义了实例方法advance(to:)。这个方法会在更新currentLevel之前检查所请求的新等级是否已经解锁。advance(to:)方法返回布尔值以指示是否能够设置currentLevel。因为允许在调用advance(to:)时候忽略返回值，不会产生编译警告，所以函数被标注为@ discardableResult属性，更多关于属性信息，请参考属性章节。
        
//        下面，Player类使用LevelTracker来监测和更新每个玩家的发展进度：
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            
            func complete(level: Int) {
                LevelTracker.unlock(level)
                tracker.advance(to: level)
            }
            
            init(name: String) {
                playerName = name;
            }
        }
        
        let player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印 "level 6 has not yet been unlocked"
    }

}
