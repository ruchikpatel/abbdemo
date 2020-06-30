#include "steganography.h"
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

int main()
{
  string coolString;
  Steganography MJ; // I was missing michael jackson.  
  int extract;

  cout << "Please chose one from the following option or press -1 to quit." << endl;
  
  cout << "1) Read image. " << endl;
  cout << "2) Print image." << endl;
  cout << "3) Read cipher text. " << endl;
  cout << "4) Print cipher text." << endl;
  cout << "5) Clean image." << endl;
  cout << "6) Encipher " << endl;
  cout << "7) Decipher " << endl; 
  //  cout << "NOTE: You must call all the available function 
  
  cout << "Enter your choice: " ;
  cin >> extract;
  
  while (extract != -1)
    {
      if(extract == 1)	{
	  cout << "Please enter your file name to read in an image: ";
	  getline(cin, coolString);
	  MJ.readImage(coolString);
	}

      else if(extract == 2){
	
      }
      
      else if (extract != 3)
	{
	  cout << "Enter file name to input cipher text: ";
	  getline(cin,coolString);
	  MJ.readCipherText(coolString);
	}
      else
  MJ.cleanImage();

  MJ.encipher();
  cout << "Enter file name to output cipher text: ";
  getline(cin, coolString);
  MJ.printCipherText(coolString);
  
  cout << "Enter file name for output: ";
  getline(cin, coolString);
  MJ.printImage(coolString);
  
  return 0;
}
