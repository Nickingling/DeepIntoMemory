Arc原理:
ARC只是一个编译前的步骤，它为我们的代码自动加上retain/release/autorelease语句。
ARC并不是垃圾收集，并且引用计数也没有消失，只是变成自动而已。

arc规则:
1、不能使用retain/release/retainCount/autorelease
2、不能使用NSAllocateObject/NSDeallocateObject
3、必须遵守内存管理的方法命名规则
4、不要显式调用dealloc
5、使用@autoreleasepool块替代NSAutoreleasePool
6、不能使用区域NSZone
7、对象型变量不能作为c语言结构体的成员
8、显式转换id和void*
9、使用CF底层函数是需要自己维护引用计数 cfretain / cfrelease

@property属性分为三类:
1.读写属性（Writability）包含：readwrite / readonly
    readwrite生成setter / getter方法
    readonly只生成getter方法
2.setter语义（Setter Semantics）
    a.mrc下包含：assign / retain / copy
    b.arc下包含：weak / strong / copy
3.原子性（Atomicity）包含：nonatomic / atomic
    如果对象无需考虑多线程的情况，请加入nonatomic属性，这样会让编译器少生成一些互斥加锁代码，可以提高效率