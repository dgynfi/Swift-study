//
//  ConstructorUsage.swift
//  Constructor
//
//  Created by dyf on 2017/10/20.
//  Copyright © 2017 dyf. All rights reserved.
//

import UIKit


//本页包含内容：

//存储属性的初始赋值
//自定义构造过程
//默认构造器
//值类型的构造器代理
//类的继承和构造过程
//可失败构造器
//必要构造器
//通过闭包或函数设置属性的默认值                                z

//构造过程是使用类、结构体或枚举类型的实例之前的准备过程。在新实例可用前必须执行这个过程，具体操作包括设置实例中每个存储型属性的初始值和执行其他必须的设置或初始化工作。

//通过定义构造器来实现构造过程，这些构造器可以看做是用来创建特定类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。

//类的实例也可以通过定义析构器在实例释放之前执行特定的清除工作。想了解更多关于析构器的内容，请参考析构过程。


//存储属性的初始赋值
//类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。

//你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。以下小节将详细介绍这两种方法。

//注意
//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。


//构造器
//构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字init命名：

//init() {
    // 在此处执行构造过程
//}

//下面例子中定义了一个用来保存华氏温度的结构体Fahrenheit，它拥有一个Double类型的存储型属性temperature：
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}


//默认属性值
//如前所述，你可以在构造器中为存储型属性设置初始值。同样，你也可以在属性声明时为其设置默认值。

//注意
//如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。两种方法的效果是一样的，只不过使用默认值让属性的初始化和声明结合得更紧密。使用默认值能让你的构造器更简洁、更清晰，且能通过默认值自动推导出属性的类型；同时，它也能让你充分利用默认构造器、构造器继承等特性，后续章节将讲到。
//你可以使用更简单的方式在定义结构体Fahrenheit时为属性temperature设置默认值：
struct Fahrenheit2 {
    var temperature = 32.0
}


//构造参数

//自定义构造过程时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方法的参数相同。

//下面例子中定义了一个包含摄氏度温度的结构体Celsius。它定义了两个不同的构造器：init(fromFahrenheit:)和init(fromKelvin:)，二者分别通过接受不同温标下的温度值来创建新的实例：
struct Celsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }

    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
}

//参数的内部名称和外部名称

//跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。

//然而，构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。

//以下例子中定义了一个结构体Color，它包含了三个常量：red、green和blue。这些属性可以存储0.0到1.0之间的值，用来指示颜色中红、绿、蓝成分的含量。

//Color提供了一个构造器，其中包含三个Double类型的构造参数。Color也可以提供第二个构造器，它只包含名为white的Double类型的参数，它被用于给上述三个构造参数赋予同样的值。

class Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
    
}


//不带外部名的构造器参数

//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名，以此重写上面所说的默认行为。

//下面是之前Celsius例子的扩展，跟之前相比添加了一个带有Double类型参数的构造器，其外部名用_代替：

struct Celsius2 {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}


//可选属性类型

//如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为可选类型。可选类型的属性将自动初始化为nil，表示这个属性是有意在初始化时设置为空的。

//下面例子中定义了类SurveyQuestion，它包含一个可选字符串属性response：

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

//调查问题的答案在回答前是无法确定的，因此我们将属性response声明为String?类型，或者说是可选字符串类型。当SurveyQuestion实例化时，它将自动赋值为nil，表明此字符串暂时还没有值。


//构造过程中常量属性的修改

//你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。

//注意
//对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
//你可以修改上面的SurveyQuestion示例，用常量属性替代变量属性text，表示问题内容text在SurveyQuestion的实例被创建之后不会再被修改。尽管text属性现在是常量，我们仍然可以在类的构造器中设置它的值：

class SurveyQuestionA {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}


//默认构造器
//如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。

//下面例子中创建了一个类ShoppingListItem，它封装了购物清单中的某一物品的属性：名字（name）、数量（quantity）和购买状态 purchase state：
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

//由于ShoppingListItem类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个可以为所有属性设置默认值的默认构造器（尽管代码中没有显式为name属性设置默认值，但由于name是可选字符串类型，它将默认设置为nil）。上面例子中使用默认构造器创造了一个ShoppingListItem类的实例（使用ShoppingListItem()形式的构造器语法），并将其赋值给变量item。


//结构体的逐一成员构造器

//除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。

//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。

//下面例子中定义了一个结构体Size，它包含两个属性width和height。Swift 可以根据这两个属性的初始赋值0.0自动推导出它们的类型为Double。

//结构体Size自动获得了一个逐一成员构造器init(width:height:)。你可以用它来为Size创建新的实例：
struct Size {
    var width = 0.0, height = 0.0
}

//值类型的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。

//构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。这些责任将在后续章节类的继承和构造过程中介绍。

//对于值类型，你可以使用self.init在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用self.init。

//如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用自动生成的构造器

//注意
//假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节。
//下面例子将定义一个结构体Rect，用来代表几何矩形。这个例子需要两个辅助的结构体Size和Point，它们各自为其所有的属性提供了初始值0.0。
struct SizeA {
    var width = 0.0, height = 0.0
}

struct PointA {
    var x = 0.0, y = 0.0
}

//你可以通过以下三种方式为Rect创建实例——使用被初始化为默认值的origin和size属性来初始化；提供指定的origin和size实例来初始化；提供指定的center和size来初始化。在下面Rect结构体定义中，我们为这三种方式提供了三个自定义的构造器：
struct Rect {
    var size = SizeA()
    var origin = PointA()
    
    init(origin: PointA, size: SizeA) {
        self.origin = origin
        self.size = size
    }
    
    init(center: PointA, size: SizeA) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: PointA(x: originX, y: originY), size: size)
    }
    
}


//类的继承和构造过程
//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。

//Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。


//指定构造器和便利构造器

//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。

//每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。

//便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。

//你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。

//类的指定构造器的写法跟值类型简单构造器一样：

//init(parameters) {
//    statements
//}

//便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：

//convenience init(parameters) {
//    statements
//}

//类的构造器代理规则
//为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：

//规则 1
//指定构造器必须调用其直接父类的的指定构造器。
//规则 2
//便利构造器必须调用同类中定义的其它构造器。
//规则 3
//便利构造器必须最终导致一个指定构造器被调用。

//一个更方便记忆的方法是：
//指定构造器必须总是向上代理
//便利构造器必须总是横向代理


//构造器的继承和重写
//跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误地用来创建子类的实例。

//注意
//父类的构造器仅会在安全和适当的情况下被继承。具体内容请参考后续章节构造器的自动继承。
//假如你希望自定义的子类中能提供一个或多个跟父类相同的构造器，你可以在子类中提供这些构造器的自定义实现。

//当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上override修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上override修饰符，具体内容请参考默认构造器。

//正如重写属性，方法或者是下标，override修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否正确。

//注意
//当你重写一个父类的指定构造器时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器。

//在下面的例子中定义了一个叫Vehicle的基类。基类中声明了一个存储型属性numberOfWheels，它是值为0的Int类型的存储型属性。numberOfWheels属性用于创建名为descrpiption的String类型的计算型属性：
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

//下面例子中定义了一个Vehicle的子类Bicycle：
class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

//注意
//子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。


//构造器的自动继承
//如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。

//假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
//规则 1
//如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
//规则 2
//如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
//即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。

//注意
//对于规则 2，子类可以将父类的指定构造器实现为便利构造器。


//指定构造器和便利构造器实践
//接下来的例子将在实践中展示指定构造器、便利构造器以及构造器的自动继承。这个例子定义了包含三个类Food、RecipeIngredient以及ShoppingListItem的类层次结构，并将演示它们的构造器是如何相互作用的。

//类层次中的基类是Food，它是一个简单的用来封装食物名字的类。Food类引入了一个叫做name的String类型的属性，并且提供了两个构造器来创建Food实例：
class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unnamed")
    }
}

//类层级中的第二个类是Food的子类RecipeIngredient。RecipeIngredient类用来表示食谱中的一项原料。它引入了Int类型的属性quantity（以及从Food继承过来的name属性），并且定义了两个构造器来创建RecipeIngredient实例：

class RecipeIngredient: Food {
    var quantity = 1
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

//RecipeIngredient类拥有一个指定构造器init(name: String, quantity: Int)，它可以用来填充RecipeIngredient实例的所有属性值。这个构造器一开始先将传入的quantity参数赋值给quantity属性，这个属性也是唯一在RecipeIngredient中新引入的属性。随后，构造器向上代理到父类Food的init(name: String)。这个过程满足两段式构造过程中的安全检查 1。

//RecipeIngredient还定义了一个便利构造器init(name: String)，它只通过name来创建RecipeIngredient的实例。这个便利构造器假设任意RecipeIngredient实例的quantity为1，所以不需要显式指明数量即可创建出实例。这个便利构造器的定义可以更加方便和快捷地创建实例，并且避免了创建多个quantity为1的RecipeIngredient实例时的代码重复。这个便利构造器只是简单地横向代理到类中的指定构造器，并为quantity参数传递1。

//注意，RecipeIngredient的便利构造器init(name: String)使用了跟Food中指定构造器init(name: String)相同的参数。由于这个便利构造器重写了父类的指定构造器init(name: String)，因此必须在前面使用override修饰符（参见构造器的继承和重写）。

//尽管RecipeIngredient将父类的指定构造器重写为了便利构造器，它依然提供了父类的所有指定构造器的实现。因此，RecipeIngredient会自动继承父类的所有便利构造器。

//在这个例子中，RecipeIngredient的父类是Food，它有一个便利构造器init()。这个便利构造器会被RecipeIngredient继承。这个继承版本的init()在功能上跟Food提供的版本是一样的，只是它会代理到RecipeIngredient版本的init(name: String)而不是Food提供的版本。


//类层级中第三个也是最后一个类是RecipeIngredient的子类，叫做ShoppingListItem。这个类构建了购物单中出现的某一种食谱原料。

//购物单中的每一项总是从未购买状态开始的。为了呈现这一事实，ShoppingListItem引入了一个布尔类型的属性purchased，它的默认值是false。ShoppingListItem还添加了一个计算型属性description，它提供了关于ShoppingListItem实例的一些文字描述：
class AShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

//注意
//ShoppingListItem没有定义构造器来为purchased提供初始值，因为添加到购物单的物品的初始状态总是未购买。
//由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，ShoppingListItem将自动继承所有父类中的指定构造器和便利构造器。


//可失败构造器
//如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。

//为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。

//注意
//可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过return nil语句来表明可失败构造器在何种情况下应该“失败”。

//注意
//严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。
//例如，实现针对数字类型转换的可失败构造器。确保数字类型之间的转换能保持精确的值，使用这个 init(exactly:) 构造器。如果类型转换不能保持值不变，则这个构造器构造失败。

//下例中，定义了一个名为Animal的结构体，其中有一个名为species的String类型的常量属性。同时该结构体还定义了一个接受一个名为species的String类型参数的可失败构造器。这个可失败构造器检查传入的参数是否为一个空字符串。如果为空字符串，则构造失败。否则，species属性被赋值，构造成功。
struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}


//枚举类型的可失败构造器

//你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
//下例中，定义了一个名为TemperatureUnit的枚举类型。其中包含了三个可能的枚举成员(Kelvin，Celsius，和Fahrenheit)，以及一个根据Character值找出所对应的枚举成员的可失败构造器：

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


//带原始值的枚举类型的可失败构造器

//带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)，该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。

//因此上面的TemperatureUnit的例子可以重写为：

enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}


//构造失败的传递

//类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。

//无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。

//注意
//可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
//下面这个例子，定义了一个名为CartItem的Product类的子类。这个类建立了一个在线购物车中的物品的模型，它有一个名为quantity的常量存储型属性，并确保该属性的值至少为1：

class Product {
    let name: String
    
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

//CartItem 可失败构造器首先验证接收的 quantity 值是否大于等于 1 。倘若 quantity 值无效，则立即终止整个构造过程，返回失败结果，且不再执行余下代码。同样地，Product 的可失败构造器首先检查 name 值，假如 name 值为空字符串，则构造器立即执行失败。


//重写一个可失败构造器
//如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
//注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。

//注意
//你可以用非可失败构造器重写可失败构造器，但反过来却不行。

//下例定义了一个名为Document的类，name属性的值必须为一个非空字符串或nil，但不能是一个空字符串：

class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

//下面这个例子，定义了一个Document类的子类AutomaticallyNamedDocument。这个子类重写了父类的两个指定构造器，确保了无论是使用init()构造器，还是使用init(name:)构造器并为参数传递空字符串，生成的实例中的name属性总有初始"[Untitled]"：

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//AutomaticallyNamedDocument用一个非可失败构造器init(name:)重写了父类的可失败构造器init?(name:)。因为子类用另一种方式处理了空字符串的情况，所以不再需要一个可失败构造器，因此子类用一个非可失败构造器代替了父类的可失败构造器。
//你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。比如，下面的UntitledDocument子类的name属性的值总是"[Untitled]"，它在构造过程中使用了父类的可失败构造器init?(name:)：

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//在这个例子中，如果在调用父类的可失败构造器init?(name:)时传入的是空字符串，那么强制解包操作会引发运行时错误。不过，因为这里是通过非空的字符串常量来调用它，所以并不会发生运行时错误。


//可失败构造器 init!
//通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
//你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。


//必要构造器
//在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：

class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

//在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加override修饰符：

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

//注意
//如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。



//通过闭包或函数设置属性的默认值
//如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。

//这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。

//下面介绍了如何用闭包为属性提供默认值：
/*
class SomeClass {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
    }()
}
*/
//注意闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。

//注意
//如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。

//下面例子中定义了一个结构体Checkerboard，它构建了西洋跳棋游戏的棋盘：

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlank = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlank)
                isBlank = !isBlank
            }
            isBlank = !isBlank
        }
        
        return temporaryBoard
    }()
    func isBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

class ConstructorUsage: NSObject {
    
    func execute() {
        
        let f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // 打印 "The default temperature is 32.0° Fahrenheit"

        //第一个构造器拥有一个构造参数，其外部名字为fromFahrenheit，内部名字为fahrenheit；第二个构造器也拥有一个构造参数，其外部名字为fromKelvin，内部名字为kelvin。这两个构造器都将唯一的参数值转换成摄氏温度值，并保存在属性temperatureInCelsius中。
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        print(" boilingPointOfWater.temperatureInCelsius \(boilingPointOfWater.temperatureInCelsius)")
        // boilingPointOfWater.temperatureInCelsius 是 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        print("freezingPointOfWater.temperatureInCelsius \(freezingPointOfWater.temperatureInCelsius)")
        // freezingPointOfWater.temperatureInCelsius 是 0.0
        
        
        //两种构造器都能用于创建一个新的Color实例，你需要为构造器每个外部参数传值：
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        
        print(magenta, halfGray)
        
        //注意，如果不通过外部参数                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     名称

        //调用Celsius2(37.0)意图明确，不需要外部参数名称。因此适合使用init(_ celsius: Double)这样的构造器，从而可以通过提供Double类型的参数值调用构造器，而不需要加上外部名。
        let bodyTemperature = Celsius2(37.0)
        print("bodyTemperature \(bodyTemperature)")
        // bodyTemperature.temperatureInCelsius 为 37.0
        
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // 打印 "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        print("cheeseQuestion.response \(cheeseQuestion.response!)")
        
        let beetsQuestion = SurveyQuestionA(text: "How about beets?")
        beetsQuestion.ask()
        // 打印 "How about beets?"
        beetsQuestion.response = "I also like beets. (But not with cheese.)"
        print("cheeseQuestion.response \(cheeseQuestion.response!)")

        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        print("twoByTwo \(twoByTwo)")

        //Vehicle类只为存储型属性提供默认值，而不自定义构造器。因此，它会自动获得一个默认构造器，具体内容请参考默认构造器。自动获得的默认构造器总会是类中的指定构造器，它可以用于创建numberOfWheels为0的Vehicle实例：
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")
        // Vehicle: 0 wheel(s)

        //如果你创建一个Bicycle实例，你可以调用继承的description计算型属性去查看属性numberOfWheels是否有改变：
        let bicycle = Bicycle()
        print("Bicycle: \(bicycle.description)")
        // 打印 "Bicycle: 2 wheel(s)"

        //类类型没有默认的逐一成员构造器，所以Food类提供了一个接受单一参数name的指定构造器。这个构造器可以使用一个特定的名字来创建新的Food实例：
        let namedMeat = Food(name: "Bacon")
        print("namedMeat: \(namedMeat.name)")
        // namedMeat 的名字是 "Bacon"

        //Food类同样提供了一个没有参数的便利构造器init()。这个init()构造器为新食物提供了一个默认的占位名字，通过横向代理到指定构造器init(name: String)并给参数name传值[Unnamed]来实现：
        let mysteryMeat = Food()
        print("mysteryMeat: \(mysteryMeat.name)")
        // mysteryMeat 的名字是 Unnamed
        
        //所有的这三种构造器都可以用来创建新的RecipeIngredient实例：
        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        print("oneMysteryItem: \(oneMysteryItem.name)")
        print("oneBacon: \(oneBacon.name)")
        print("sixEggs: \(sixEggs.name)")

        var breakfastList = [
            AShoppingListItem(),
            AShoppingListItem(name: "Bacon"),
            AShoppingListItem(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x orange juice ✔
        // 1 x bacon ✘
        // 6 x eggs ✘
        
        //如上所述，例子中通过字面量方式创建了一个数组breakfastList，它包含了三个ShoppingListItem实例，因此数组的类型也能被自动推导为[ShoppingListItem]。在数组创建完之后，数组中第一个ShoppingListItem实例的名字从[Unnamed]更改为Orange juice，并标记为已购买。打印数组中每个元素的描述显示了它们都已按照预期被赋值。
        
        // 可失败构造器举例
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value ", "valueMaintained: \(valueMaintained)")
        }
        // 打印 "12345.0 conversion to Int maintains value"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged 是 Int? 类型, 不是 Int 类型
        
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        // 打印 "3.14159 conversion to Int does not maintain value"
        
        //你可以通过该可失败构造器来构建一个Animal的实例，并检查构造过程是否成功：
        let someCreature = Animal(species: "Giraffe")
        // someCreature 的类型是 Animal? 而不是 Animal
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // 打印 "An animal was initialized with a species of Giraffe"
        //如果你给该可失败构造器传入一个空字符串作为其参数，则会导致构造失败：
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // 打印 "The anonymous creature could not be initialized"
        //注意
        //空字符串（如""，而不是"Giraffe"）和一个值为nil的可选类型的字符串是两个完全不同的概念。上例中的空字符串（""）其实是一个有效的，非可选类型的字符串。这里我们之所以让Animal的可失败构造器构造失败，只是因为对于Animal这个类的species属性来说，它更适合有一个具体的值，而不是空字符串。
        

        //你可以利用该可失败构造器在三个枚举成员中获取一个相匹配的枚举成员，当参数的值不能与任何枚举成员相匹配时，则构造失败：
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // 打印 "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // 打印 "This is not a defined temperature unit, so initialization failed."
    
        
        let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
        if fahrenheitUnit2 != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // 打印 "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit2 = TemperatureUnit2(rawValue: "X")
        if unknownUnit2 == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // 打印 "This is not a defined temperature unit, so initialization failed."
        
        //如果你通过传入一个非空字符串 name 以及一个值大于等于 1 的 quantity 来创建一个 CartItem 实例，那么构造方法能够成功被执行：
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }
        // 打印 "Item: sock, quantity: 2"
        
        //倘若你以一个值为 0 的 quantity 来创建一个 CartItem 实例，那么将导致 CartItem 构造器失败：
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }
        // 打印 "Unable to initialize zero shirts"
        
        //同样地，如果你尝试传入一个值为空字符串的 name来创建一个 CartItem 实例，那么将导致父类 Product 的构造过程失败：
        if let oneUnnamed = CartItem(name: "", quantity: 1) {
            print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
        } else {
            print("Unable to initialize one unnamed product")
        }
        // 打印 "Unable to initialize one unnamed product"
        
        //每当一个新的Checkerboard实例被创建时，赋值闭包会被执行，boardColors的默认值会被计算出来并返回。上面例子中描述的闭包将计算出棋盘中每个格子对应的颜色，并将这些值保存到一个临时数组temporaryBoard中，最后在构建完成时将此数组作为闭包返回值返回。这个返回的数组会保存到boardColors中，并可以通过工具函数squareIsBlackAtRow来查询：
        let board = Checkerboard()
        print(board.isBlackAtRow(row: 0, column: 1))
        // 打印 "true"
        print(board.isBlackAtRow(row: 7, column: 7))
        // 打印 "false"
    }
    
}
