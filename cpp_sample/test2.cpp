#include <iostream>
 
int main()
{
    int a=10;
    int b=20;
    int c=30;
    a=b=c;
    std::cout << "a=" << a << " b=" << b << " c=" << c << "\n";
 
    a=10;
    b=20;
    c=30;
    a=(b=c);
    std::cout << "a=" << a << " b=" << b << " c=" << c << "\n";
 
    a=10;
    b=20;
    c=30;
    (a=b)=c;
    std::cout << "a=" << a << " b=" << b << " c=" << c << "\n";
 
    return 0;
}
