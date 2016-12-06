#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

unsigned int convert(unsigned int number,unsigned int base){
    if(number == 0 || base == 10)
        return number;
    return (number % base) + 10*convert(number/base, base);
}

int main(int argc, char** argv) {
    
    unsigned int number, base, result;
    
    string digit = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    string n = "";
    
    cout << "Enter a base 10 unsigned integer you want to convert: ";
    cin >> number;
    
    cout << "Enter the base you wish to convert to: ";
    cin >> base;
    
    if(base == 2 && number > 0)
        cout << convert(number, base);
    else{
        unsigned int divide = number;
        unsigned int rem; 
        do{
        unsigned int divide2= divide/base;
        rem = divide - divide2 * base;
        divide = divide2;
        n=digit[rem]+n;
        }
        while(divide > base);
        
        cout <<  number << " base 10 is " << n << " base " << base << endl; 
    }
    
    return 0;
}

