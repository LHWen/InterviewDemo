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


#endif /* InterviewQuestions_h */
