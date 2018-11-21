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

#endif /* InterviewQuestions_h */
