#include <iostream>
 
class   Foo
{
    int     mData;
public:
    Foo(int iData) : mData(iData)
    {
        std::cout << "Foo::Foo()     : this=" << this << "\n";
    }
    ~Foo()
    {
        std::cout << "Foo::~Foo()    : this=" << this << "\n";
    }
};
 
struct Bar
{
    Foo*    mFoo;
    Bar() : mFoo(nullptr)
    {
        std::cout << "Bar::Bar()\n";
    }
    Bar(Foo* iFoo) : mFoo(iFoo)
    {
        std::cout << "Bar::Bar(Foo*) : mFoo=" << mFoo << "\n";
    }
    ~Bar()
    {
        std::cout << "Bar::~Bar()    : mFoo=" << mFoo << "\n";
        delete mFoo;
    }
 
    // ムーブ・コンストラクタ
    Bar(Bar&& iRhs) : mFoo(iRhs.mFoo)
    {
        std::cout << "Bar::Bar(Foo&&): mFoo=" << mFoo << "\n";
        iRhs.mFoo = nullptr;
    }
};
 
Bar baz()
{
    std::cout << "baz()\n";
    Bar ret(new Foo(456));          // Fooコンストラクト・・・①
                                    // Barコンストラクト
    std::cout << "return from baz\n";
    return std::move(ret);          // 戻り値へムーブ（ムーブ・コンストラクタ）
}                                   // retデストラクト（ここで①のFooデストラクト）
 
Bar baz_not_move()
{
    std::cout << "baz()\n";
    Bar ret(new Foo(456));          // Fooコンストラクト・・・①
                                    // Barコンストラクト
    std::cout << "return from baz\n";
    // std::moveをつけないようにすると、コンパイラによるNRVO最適化により
    return ret;                     // moveすら発生しない！
}

int main()
{
    // Bar aBar=baz();
    Bar aBar=baz_not_move();
    std::cout << "post baz()     : mFoo=" << aBar.mFoo << "\n";
}                                   // aBarデストラクト（ここで①のFooデストラクト）
