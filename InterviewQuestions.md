#### 部分问题

##### 1. WKWebView与UIWebView的区别？相对于UIWebView而已WKWebView有何优势？

WKWebView是iOS8之后新推出用于替换UIWebView的组件。使用WKWebView加载速度更快，内存占用少。
WKWebView特性：
在性能、稳定性、功能方面有很大的提升，直观体现占用内存少；
增加加载进度条属性，不需要自己写进度条；
允许JavaScript的Nitro库加载并使用（UIWebView中限制）;
支持了更多的HTML5特性，可直接与JS进行交互，不需要使用第三方库或者自己写代理类实现原生与web交互；
不支持页面缓存，很好解决了缓存问题，如果需要缓存需要自己添加cookie，而UIWebView是自动注入cookie需要手动清理缓存。

##### 2. KVC与KVO实现原理

KVC：通过键值对进行值的获取跟赋值，运行时实现，是拿函数指针设置获取。
KVC在设置时可能设置错误的key值导致程序崩溃，需要重写valueForUnderfinedKey: 和 setValue:forUnderfinedKey:
假如赋值时候将nil传递给值了，需要重写setNilValueForKey:以免程序崩溃。
KVO：是一种设计模式，通过添加一个被观察属性对象A的属性变化时，发送观察对象会话的通知，并对此通知做出相应处理。通过isa-swizzling指针实现。
添加观察后：系统实现了一子类，然后将被观察对象的isa指针指向这个子类，重写了setter方法，并在当中添加了willChangeValueForKey:和didChangeValueForKey:
移除观察就是将 isa 指针指向原来的类对象中。

##### 3. UITableView优化

缓存高度，由于UITableView在绘制Cell的时候每次会主动获取Cell的高度，所以这里的优化点是减少高度计算的执行时间。保存第一次计算出来的Cell高度（可在获取数据时进行高度计算保存在数据模型中model），而不是每次重复计算cell的高度。
异步渲染图片
按需加载数据，不要一下把数据加载出来，分页加载或者滑动到底部，往后多请求3-5条数据，减少Cell的绘制工作量。

##### 4. GCD死锁问题

简单的说就是在同一线程出现并行线程，导致互相等待，从而产生死锁。
eg. 主队列中执行任务A(并行)和B(串行)，由于任务A是并行的，主队了在等待任务A执行完再去执行任务B，而任务A在等待主队了执行它，出现相互等待(导致死锁).

##### 5. Masonry布局实现原理

masonry是通过对AutoLayout布局的封装。
masonry的本质是通过链式的语法将一个一个约束关系记录下来，然后通过创建一个一个NSLayoutConstraint对象进行布局约束。
masonry的主要流程其实就是每个View提供給用户的MASConstraintMaker对象，让用户不断在MASConstraintMaker对象上添加以一个一个的MASConstraint的约束结构，最后将所有MASConstraint转化成一个一个的NSLayoutConstraint对象添加在相应的View视图上。

##### 6. 数据缓存机制、路径、原理

数据缓存要求：固定数据，偶尔更新的数据(这类数据需要定时更新缓存以确保数据及时性)。
1、使用App应用的沙盒机制继续数据缓存，目录放在Library/Caches下，iTunes不会备份此路径下目录、
2、使用FMDB等第三方数据库进行数据缓存。

##### 7. 数据持久化

a. 沙盒
b. plist文件
c. Preference -> NSUserDefaults 本地缓存
d. NSKeyedArchiver 归档在iOS中是另一种形式的序列号，只是遵循了NSCoding协议的对象都可以通过它实现序列化。
由于绝大多数支持存储数据的Foundation和Cocoa Touch类都遵循了NSCoding协议，因此对大多数类来说，归档相对而言还是比较容易实现的
e. FMDB

##### 8. 消息转发机制

如果一个对象无法响应一个方法，那么就会进入消息转发机制（代理）
第一步，我们可以动态创建一个方法实现去响应这个消息，消息转发结束
第一步未处理，第二步我们可以选择一个备选的消息接收者去处理这个消息
第二步没实现，最后一步，启动完整的消息转发机制，处理方法签名，实现NSInvocation对象转发。
最好是在第一步处理，次之第二步，如果第三步只是使用备选接收者处理，还不如直接第二步快速处理结束，毕竟第三步需要方法签名和封装NSInvocation。

##### 9. assign与weak区别，代理为什么用weak？

assign适用于基本数据类型（int、double、float、bool），weak适用于NSObject对象，并且是一个弱引用。
使用assign修饰基本数据类型，因为基本数据类型一般都分配在栈上，栈的内存由系统自动处理，不会造成野指针。
如果使用assign修饰对象，在释放后，指针的地址还是存在，也就是说指针并没有被置为nil，造成野指针。
weak修饰的对象在释放后，指针地址也会被置空（nil）。
弱引用使用weak修饰，代理使用weak是为了防止循环引用。

##### 10. strong与copy的区别？

strong与copy都会使引用计数加1，strong的两个指针指向同一内存地址，copy会在内存里拷贝一份对象，两个指针指向不同的内存地址。

##### 11. _ _bolck与 _ _weak的区别?

_ block是用来修饰一个变量，这个变量就可以在block中被修改。_ block：使用 
_ block修饰的变量在 block代码块中会被retain（ARC下会retain，MRC下不会retain）
_ _weak：使用_ _ _weak修饰的变量不会在block代码块中被retain。
在ARC下，要避免block出现循环引用 使用 weak来代替self调用定义的全局属性； _ _weak typedof(self)weakSelf = self。

#### 12. block变量定义时为什么用copy？block是放在哪里的？

 block创建在栈上，可能随时被回收，使用copy将block拷贝到堆上，保证block在声明域外使用。
 block本身是像对象一样可以retain，和release。但是，block在创建的时候，它的内存是分配不是在堆(heap)上而是在栈(stack)上，可能被随时回收。
他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。
通过copy可以把block拷贝（copy）到堆，保证block的声明域外使用。
特别需要注意的地方就是在把block放到集合类当中去的时候，如果直接把生成的block放入到集合类中，是无法在其他地方使用block，必须要对block进行copy。 

##### 13. 性能、内存优化

使用Instruments分析代码，检查代码需要提高的地方。

**1)** 使用ARC管理内存
**2) **适当地方使用reuseIdentifier (重用标识)
常见的为UITableViewCells，UICollectionViewCells，UITableViewHeaderFooterViews设置一个正确的reuseIdentifier(重用标识)。
 如果不用tableview每显示一行将会配置一个全新的cell。这是非常费事的操作而且绝对会影响你app滚动的性能。
**3) **视图的透明尽可能不设置为透明，非得设置透明，背景色尽可能跟父视图颜色一致。
**4) **避免臃肿的Xib文件，如果要使用，尽可能使之简单
 注意当加载一个Xib到内存的时候，它所有的内容都会载入内存，包括所有的图片。如果有视图但不是要立即使用，那就浪费了珍贵的内存。
**5) **不要阻塞主线程
UIKIt的所有工作都在主线程中进行，比如绘画，管理触摸，和响应输出，大多数阻塞主线程的是App进行网络请求跟读写外部资源，这些都可以使用异步处理。
**6) **调整图像在视图中的的图像尺寸
如果你用UIImageView呈现app束中的图片时，确认图片和UIImageView的尺寸相同。缩放图片会非常的耗时，特别是当你的UIImageView被嵌入UIScrollView。
如果图片是从远程服务器上下载的，有时你没法控制图片尺寸，或者你不能在服务器上在下载之前缩放它。
在这些情况下你可以在图片下载完成后手动缩放一次，最好是在后台进程中。然在UIImageView中使用调整尺寸之后的图片。
**7) **选择正确集合
Arrays:有序的值列表，用index快速查找，通过值查找慢，insert/delete操作慢。
 Dictionaries:存储键/值对，用index快速查找。
Sets: 无序的值列表。通过值快速查找，insert/delete快。
**8) **重用和延迟加载视图（懒加载）
**9) **缓存
固定数据、偶尔更新的数据、cell高度（在接收到数据时进行高度计算，保存到数据model中）
**10) **考虑绘图
**11) **处理内存警告
当系统内存低的时候iOS会通知所有的正在运行的app。
如果你的应用收到这个警告，它必须尽可能多的释放内存。最好的方法是移除对缓存，图像对象，和其他稍后要创建的对象的强引用。
**12) **重用大开销对象 比如: NSDateFormatter和NSCalendar(日历📅)
**13) **使用JSONKit （速度快，速度比NSJSONSerialization快上25% to 40%）
**14) **适当的设置背景图片
你可以设置你的视图的背景颜色为UIColor的colorWithPatternImage创建的颜色。
你可以添加一个UIImageView子试图给View 。
如果你有全尺寸的背景图片，你绝对要用UIImageView，因为UIColor的colorWithPatternImage是重复的创建小的模式图片，
在这种情况下用UIImageView方式会节约很多内存。
**15) **减小网络占用
所以为了获得最佳的性能，你需要调整你的HTML。第一件事是尽可能多的避免JavaScript，包括避免大的框架比如jQuery。
**16) **设置阴影路径，减少阴影属性设置（shadowOffset）
设置阴影路径，iOS不需要总是计算如何绘制阴影。而是用已经计算好的的路径。
坏消息是它依赖与你的视图格式，你是视图可能很难计算这个路径。另一个问题是你需要在每次视图的框架改变时更新阴影路径
**17) **表格视图优化
通过正确的reuseIdentifier重用cells
尽量多的设置views 为不透明，包括cell本身。
避免渐变，图像缩放，屏幕以外的绘制。
如果行高不总是一样，缓存它们，在数据返回时就计算高度（保存model中）。
如果cell显示的内容来自网络，确保异步和缓存。
使用shadowPath来建立阴影。
减少子视图的数目。
cellForRowAtIndexPath:中做尽量少的工作，如果需要做相同的工作，那么只做一次并缓存结果。
使用适当的数据结构存储你要的信息，不同的结构有对于不同的操作有不同的代价。
使用rowHeight，sectionFooterHeight，sectionHeaderHeight为常数，而不是询问代理。
**18) **选择正确的数据存储方式
使用 NSUserDefaults存储bool值或者简单的数据
存储在结构化文件中，XML，JSON，Plist格式中
沙盒
归档
 FMDB
**19) **加速启动时间
**20) **缓存图片

##### 14. 设计模式有哪些？

**1).** MVC模式：Model View Control，把模型 视图 控制器 层进行解耦合编写。
**2).** MVVM模式：Model View ViewModel 把模型 视图 业务逻辑 层进行解耦和编写。
**3).** 单例模式：通过static关键词，声明全局变量。在整个进程运行期间只会被赋值一次。
**4).** 观察者模式：KVO是典型的通知模式，观察某个属性的状态，状态发生变化时通知观察者。
**5).** 委托模式：代理+协议的组合。实现1对1的反向传值操作。
**6).** 工厂模式：通过一个类方法，批量的根据已有模板生产对象。

##### 15. #import与#include有什么区别？@class作用？#import<> 与 #import""有什么区别？

1) #import是Objective-C导入头文件的关键字，#include是C/C++导入头文件的关键字；使用#import头文件会自动导入一次，不会重复导入
2) @class告诉编辑器某个类的向前声明，当执行该类时才去查看累的实现文件，可解决头文件的相互包含
3) #import<>用来包含系统的头文件，#import""用来包含用户头文件

##### 16. frame和boundsd有什么不同

frame是指View在父视图坐标系统中的位置，参考的是父视图的坐标系
bounds是指View在本身视图坐标系统中的位置，参考self.view

##### 17. Objectiv-C的类可以多重继承吗？可以实现多个接口吗？Category是什么？重写一个类的方式用继承还是分类好？为什么？

Objectiv-C的类不可以多重继承
可以实现多个接口协议
 category是类别
 一般情况下用分类好，用Category去重写类方法，仅对本Category有效，不会影响原有类的关系。

##### 18. 问题：怎么用 copy 关键字？

NSString、NSArray、NSDictionary等经常使用copy关键字，是因为他们有对应的可变类型：NSMutableString、NSMutableArray、NSMutableDictionary；
block 也经常使用 copy 关键字（block在栈空间上，随时都可能被释放，使用copy将block拷贝到堆上）。

##### 19. 用@property声明的 NSString / NSArray / NSDictionary 经常使用 copy 关键字，为什么？如果改用strong关键字，可能造成什么问题？

用 @property 声明 NSString、NSArray、NSDictionary 经常使用 copy 关键字，是因为他们有对应的可变类型：NSMutableString、NSMutableArray、NSMutableDictionary，他们之间可能进行赋值操作（就是把可变的赋值给不可变的），为确保对象中的字符串值不会无意间变动，应该在设置新属性值时拷贝一份。
 1) 因为父类指针可以指向子类对象，使用 copy 的目的是为了让本对象的属性不受外界影响，使用 copy 无论给我传入是一个可变对象还是不可对象，我本身持有的就是一个不可变的副本。
2) 如果我们使用是 strong ，那么这个属性就有可能指向一个可变对象，如果这个可变对象在外部被修改了，那么会影响该属性。
copy来修饰NSMutable *** 时 在添加,删除，修改数组内的元素的时候，程序会因为找不到对应的方法而崩溃，因为copy复制一个不可变对象，可变——>不可变
总结：使用copy的目的是，防止把可变类型的对象赋值给不可变类型的对象时，可变类型对象的值发送变化会无意间篡改不可变类型对象原来的值。

##### 20. 浅拷贝和深拷贝的区别？

浅拷贝：只复制指向对象的指针，而不复制引用对象本身。
深拷贝：复制引用对象本身。内存中存在了两份独立对象本身，当修改A时，A_copy不变。

##### 21. 系统对象的copy与mutableCopy方法有什么不同？

1）copy 返回的是不可变对象（immutableObject）；如果用copy返回值调用mutable对象的方法就会crash。
2）mutableCopy 返回的是可变对象（mutableObject）。
只有对不可变对象进行copy操作是指针复制（浅copy），其它情况都是内容复制（深copy）！

##### 22. 这个写法会出什么问题：@property (nonatomic, copy) NSMutableArray *arr;？

添加,删除,修改数组内的元素的时候,程序会因为找不到对应的方法而崩溃。
如：-[__NSArrayI removeObjectAtIndex:]: unrecognized selector sent to instance 0x7fcd1bc30460
copy后返回的是不可变对象（即arr 是 NSArray 类型，NSArray 类型对象不能调用 NSMutableArray 类型对象的方法）
**原因：**是因为 copy 就是复制一个不可变 NSArray 的对象，不能对 NSArray 对象进行添加/修改。

##### 23. 如何让自己的类用 copy 修饰符？如何重写带 copy 关键字的 setter？

若想令自己所写的对象具有拷贝功能，则需实现 NSCopying 协议。如果自定义的对象分为可变版本与不可变版本，那么就要同时实现 NSCopying 与 NSMutableCopying 协议。

 具体步骤：
1）需声明该类遵从 NSCopying 协议
2）实现 NSCopying 协议的方法。
该协议只有一个方法:

- (id)copyWithZone:(NSZone *)zone;

 **注意：**使用 copy 修饰符，调用的是copy方法，其实真正需要实现的是 “copyWithZone” 方法。

##### 24. id 声明的对象有什么特性？

 id 声明的对象具有运行时的特性，即可以指向任意类型的Objcetive-C的对象。

##### 25. Category（类别）、 Extension（扩展）和继承的区别?

分类有名字，类扩展没有分类名字，是一种特殊的分类。
分类只能扩展方法（属性仅仅是声明，并没真正实现），类扩展可以扩展属性、成员变量和方法。
继承可以增加，修改或者删除方法，并且可以增加属性。

##### 26. ViewController生命周期

按照执行顺序排列：
**initWithCoder：**通过nib文件初始化时触发。
**awakeFromNib：**nib文件被加载的时候，会发生一个awakeFromNib的消息到nib文件中的每个对象。
**loadView：**开始加载视图控制器自带的view。
**viewDidLoad：**视图控制器的view被加载完成。
**viewWillAppear：**视图控制器的view将要显示在window上。
**updateViewConstraints：**视图控制器的view开始更新AutoLayout约束。
**viewWillLayoutSubviews**：视图控制器的view将要更新内容视图的位置。
**viewDidLayoutSubviews：**视图控制器的view已经更新视图的位置。
**viewDidAppear：**视图控制器的view已经展示到window上。
**viewWillDisappear：**视图控制器的view将要从window上消失。
**viewDidDisappear：**视图控制器的view已经从window上消失。

##### 27. 如何对iOS设备进行性能测试？开发项目时怎么检查内存泄露？

性能测试：Profile-> Instruments ->Time Profiler
检查内存泄漏：1). 静态分析analyze。 2). instruments工具里面有个leak可以动态分析。