//
//  InterviewQuestions.h
//  InterviewDemo
//
//  Created by LHWen on 2018/11/21.
//  Copyright © 2018 LHWen. All rights reserved.
//

#ifndef InterviewQuestions_h
#define InterviewQuestions_h

/** 问题集合 */

/**
 * 问题：KWebView与UIWebView的区别？相对于UIWebView而言KWebView有什么优势？
 
 iOS8以后，苹果推出了新框架Wekkit，提供了替换UIWebView的组件WKWebView。使用WKWebView，加载速度会更快，占用内存少。
 摆脱了UIWebView的内存占用量巨大问题。
 WKWebView的特性：
 在性能、稳定性、功能方面有很大提升，直观体现是内存占用变少；
 增加加载精度条属性：estimatedProgress,不用再自己写假精度条；
 允许JavaScript的Nitro库加载并使用（UIWebView中限制）；
 支持了更多的HTML5特性，可以跟js直接互调函数，不需要使用第三方库或者自己写代理类实现原生与web交互；
 不支持页面缓存，需要自己注入cookie，而UIWebView是自动注入cookie需要手动清理缓存；
 */

/**
 * 问题：KVC 与 KVO实现原理？ KVCAndKVO 文件实践测试
 
 KVC: 通过键值进行值的获取跟赋值，通过运行时实现，拿到函数指针设置获取。
 KVC在设置时可能会设置错误的Key值导致程序崩溃，需要重写valueForUndefinedKey:和setValue:forUndefinedKey:,
 还有一种是在设置中不小心传递了nil，这时候需要重写setNilValueForKey:。
 
 KVO: 是一种设计模式，添加一个被观察对象A的属性，当被观察属性对象A的属性发生变化时，观察对象会活的通知，并作出相应处理。通过isa-swizzling指针s实现
 添加观察后:
 系统实现了一个子类，然后将被观察的类对象的isa指针指向这个子类。再重写了setter方法。并在当中添加了willChangeValueForKey:和didChangeValueForKey:。
 移除观察就是将isa指针指向原来的类对象中。
 */
 
/**
 * 问题：UITableView 优化
 
 缓存高度，由于UITableView在绘制 Cell 的时候每次会主动获取 Cell 的高度，所以这里的优化点是减少高度计算的执行时间。
 保存第一次计算出来的 Cell 高度(获取数据到数据时候进行计算),并保存到 Cell 对应的 Model 上，而不是每次重复计算 Cell 的高度，
 可以达到减少该方法的执行时间的目的。(每次cell出现直接去model上对应的行高属性)
 
 异步渲染内容到图片
 
 按需加载数据，不要一下把所有数据加载出来，分页加载或者滑动到底部，往后面多请求三条数据之类，减小Cell绘制工作量
 
 */

/**
 * 问题：GCD死锁问题？
 
 简单的说，在同一线程中出现并行线程，出现相互等待，导致死锁。
 比如：主队列中出现任务A(并行), 任务B(串行), 由于任务A是并行的，主队列在等待任务A执行完成再执行任务B，而任务A在等待主队列执行它，相互等待导致死锁。
 */

/**
 * 问题：iOS 数据缓存问题（机制、路径、原理）？
 
 数据缓存要求：固定数据、偶尔更新的数据（这类数据需要定时更新缓存以确保数据及时性）
 1、使用App应用的沙盒机制进行数据缓存，目录放在Library/Caches下，iTunes不会备份此路径下的目录。
 2、使用FMDB等第三方数据库进行数据缓存。
 */

/**
 * 问题：Masonry布局实现原理？
 
 AutoLayout 布局的封装
 Masonry的本质其实就是通过链式的语法将一个一个约束关系记录下来，
 然后通过创建一个一个NSLayoutConstraint对象进行布局约束.
 Masonry的主要流程其实就是每个view提供给用户一个MASConstraintMaker对象，
 让用户不断在MASConstraintMaker对象上添加一个一个MASConstraint的约束结构，
 最后将所有的MASConstraint转化成一个一个NSLayoutConstraint对象添加在相应的view上面.
 */

/**
 * 问题：数据持久化
 
 1、沙盒
 2、plist文件
 3、Preference ->NSUserDefaults 本地存储
 4、NSKeyedArchiver 归档在iOS中是另一种形式的序列化，只要遵循了NSCoding协议的对象都可以通过它实现序列化。
 由于决大多数支持存储数据的Foundation和Cocoa Touch类都遵循了NSCoding协议，因此，对于大多数类来说，归档相对而言还是比较容易实现的
 5、FMDB
 */

/**
 * 问题：消息转发机制
 
 如果一个对象无法响应一个方法，那么就会进入消息转发机制
 第一步，我们可以动态创建一个方法实现去响应这个消息，消息转发结束
 第一步未处理，第二步我们可以选择一个备选的消息接收者去处理这个消息
 第二步未实现，最后一步第三步，启动完整的消息转发机制，处理方法签名，实现NSInvocation对象转发。
 最好在第一步处理，次之第二步，如果第三步只是使用备选接收者处理，还不如直接第二步快速处理结束，毕竟第三步需要方法签名和封装NSInvocation。
 */

/**
 * 问题：assign与weak区别？代理为什么用weak？
 
 assign适用于基本数据类型（int, double, float, bool），weak是适用于NSObject对象，并且是一个弱引用。
 用assign修饰基本数据类型，因为基础数据类型一般分配在栈上，栈的内存会由系统自己自动处理，不会造成野指针。
 如果使用assign修饰对象，在释放之后，指针的地址还是存在的，也就是说指针并没有被置为nil，造成野指针。
 weak修饰的对象在释放之后，指针地址会被置为nil。所以现在一般弱引用就是用weak。
 代理使用weak，防止循环引用。
 */

/**
 * 问题：strong 与copy的区别?
 
 strong 与copy都会使引用计数加1，但strong是两个指针指向同一个内存地址，copy会在内存里拷贝一份对象，两个指针指向不同的内存地址.
 */

/**
 * 问题：__block与__weak的区别？
 
 __block是用来修饰一个变量，这个变量就可以在block中被修改。
 __block：使用 __block修饰的变量在block代码块中会被retain（ARC下会retain，MRC下不会retain）。
 __weak：使用__weak修饰的变量不会在block代码块中被retain。
 在ARC下，要避免block出现循环引用 使用 weak来代替self调用定义的全局属性； __weak typedof(self)weakSelf = self。
 */

/**
 * 问题：block变量定义时为什么用copy？block是放在哪里的？
 
 block创建在栈上，可能随时被回收，使用copy将block拷贝到堆上，保证block在声明域外使用。
 
 block本身是像对象一样可以retain，和release。但是，block在创建的时候，它的内存是分配不是在堆(heap)上而是在栈(stack)上，可能被随时回收。
 他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。
 通过copy可以把block拷贝（copy）到堆，保证block的声明域外使用。
 
 特别需要注意的地方就是在把block放到集合类当中去的时候，如果直接把生成的block放入到集合类中，是无法在其他地方使用block，必须要对block进行copy。
 */

/**
 * 性能、内存优化
 
 使用Instruments分析代码，检查代码需要提高的地方。
 
 1、使用ARC管理内存
 
 2、适当地方使用reuseIdentifier (重用标识)
 常见的为UITableViewCells，UICollectionViewCells，UITableViewHeaderFooterViews设置一个正确的reuseIdentifier(重用标识)。
 如果不用tableview每显示一行将会配置一个全新的cell。这是非常费事的操作而且绝对会影响你app滚动的性能。
 
 3、视图的透明尽可能不设置为透明，非得设置透明，背景色尽可能跟父视图颜色一致。
 
 4、避免臃肿的Xib文件，如果要使用，尽可能使之简单
 注意当加载一个Xib到内存的时候，它所有的内容都会载入内存，包括所有的图片。如果有视图但不是要立即使用，那就浪费了珍贵的内存。
 
 5、不要阻塞主线程
 UIKIt的所有工作都在主线程中进行，比如绘画，管理触摸，和响应输出，大多数阻塞主线程的是App进行网络请求跟读写外部资源，这些都可以使用异步处理。
 
 6、调整图像在视图中的的图像尺寸
 如果你用UIImageView呈现app束中的图片时，确认图片和UIImageView的尺寸相同。缩放图片会非常的耗时，特别是当你的UIImageView被嵌入UIScrollView。
 如果图片是从远程服务器上下载的，有时你没法控制图片尺寸，或者你不能在服务器上在下载之前缩放它。
 在这些情况下你可以在图片下载完成后手动缩放一次，最好是在后台进程中。然在UIImageView中使用调整尺寸之后的图片。
 
 7、选择正确集合
 Arrays:有序的值的列表，用index快速查找，通过值查找慢，insert/delete操作慢。
 Dictionaries:存储键/值对，用index快速查找。
 Sets: 无序的值列表。通过值快速查找，insert/delete快。
 
 8、重用和延迟加载视图
 
 9、缓存
 固定数据、偶尔更新的数据、cell高度（在接收到数据时进行高度计算，保存到数据model中）
 
 10、考虑绘图
 
 11、处理内存警告
 当系统内存低的时候iOS会通知所有的正在运行的app。
 如果你的应用收到这个警告，它必须尽可能多的释放内存。最好的方法是移除对缓存，图像对象，和其他稍后要创建的对象的强引用。
 
 12、重用大开销对象
 
 13、使用JSONKit （速度快，速度比NSJSONSerialization快上25% to 40%）
 
 14、适当的设置背景图片
 你可以设置你的视图的背景颜色为UIColor的colorWithPatternImage创建的颜色。
 你可以添加一个UIImageView子试图给View 。
 如果你有全尺寸的背景图片，你绝对要用UIImageView，因为UIColor的colorWithPatternImage是重复的创建小的模式图片，
 在这种情况下用UIImageView方式会节约很多内存。
 
 15、减小网络占用
 所以为了获得最佳的性能，你需要调整你的HTML。第一件事是尽可能多的避免JavaScript，包括避免大的框架比如jQuery。
 
 16、设置阴影路径，减少阴影属性设置（shadowOffset）
 设置阴影路径，iOS不需要总是计算如何绘制阴影。而是用已经计算好的的路径。
 坏消息是它依赖与你的视图格式，你是视图可能很难计算这个路径。另一个问题是你需要在每次视图的框架改变时更新阴影路径
 
 17、表格视图优化
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
 
 18、选择正确的数据存储方式
 使用 NSUserDefaults存储bool值或者简单的数据
 存储在结构化文件中，XML，JSON，Plist格式中
 沙盒
 归档
 FMDB
 
 19、加速启动时间
 
 20、缓存图片

 */


#endif /* InterviewQuestions_h */
