/*
Ethan Nguyen
CMPR 154 - Fall 2023
16 September 2023

Homework #2

Collaboration: None
*/

#include <iostream>
#include <string>
using namespace std;

void convertToDecimal(string str)
{
    int num = 0;
    int exponent = 0;
    
    for (int i = str.length() - 1; i >= 0; i--)
    {
        if (str[i] == '1')
        {
            num += (1 << exponent);
        }
        exponent++;
    }
    
    cout << num << endl;
}

void reverseString(string str1)
{
    for (int i = str1.length() - 1; i >= 0; i--)
    {
        cout << str1[i];
    }
    cout << endl;
}

int main()
{
    cout << "convertToDecimal function:\n";
    convertToDecimal("10101");
    convertToDecimal("00000000001");
    convertToDecimal("1111111111");
    
    cout << endl;
    
    cout << "reverseString function:\n";
    reverseString("Hello");
    reverseString("Beautiful World");

    return 0;
}

