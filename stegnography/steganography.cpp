#include "steganography.h"
#include <iostream>
#include <string>
#include <vector>
#include <fstream>

using namespace std;

Steganography::Steganography()
{
  string image_type = "a";
  int width = 0, height = 0;
  int max_color_depth = 0;
  string ciphertext = "s";
}

Steganography::~Steganography()
{
  // fss
}

void Steganography::readImage(string file_name)
{
  ifstream imageFile; 
  imageFile.open(file_name.c_str());
  
  imageFile >> image_type;
  imageFile.get();

  imageFile >> width;
  imageFile.get();

  imageFile >> height;
  imageFile.get();
 
  imageFile >> max_color_depth;
  imageFile.get();

  for(int i; imageFile >> i;){
    color_data.push_back(i);
    i++;
  }
  imageFile.close();	
} 
  
void Steganography::printImage(string file_name)
{  
  ofstream myFile;
  myFile.open(file_name.c_str());
  
  myFile << image_type << endl;
  myFile << width << " " << height << endl;
  myFile << max_color_depth << endl;
  
  for(vector<int>::iterator it = color_data.begin(); it != color_data.end(); it++)
    myFile << *it << " ";

}

void Steganography::readCipherText(string file_name)
{
  string temp_counter;
  ifstream myFile;
  
  myFile.open(file_name.c_str());
  getline(myFile,temp_counter);

  while(myFile)
    {
      ciphertext += temp_counter;
      ciphertext += '\n';
      getline(myFile, temp_counter);
    }
  myFile.close();
}

void Steganography::printCipherText(string file_name)
{
  ofstream outFile;

  outFile.open(file_name.c_str());
  outFile << ciphertext ;
  
  outFile.close();
}

void Steganography::cleanImage()
{
  ofstream outFile;
  outFile.open("Cipher_out");
  
  for(vector<int>::iterator it = color_data.begin(); it != color_data.end(); it++)
    {
      if(*it % 2 != 0)
	  *it = *it - 1;
	 
      outFile << *it << " ";
    }
}

int Steganography::getNthBit(char cipher_char, int n)
{
  return (cipher_char >> n) % 2;
}

void Steganography::encipher()
{
  int counter = 0;
  for (int i = 0; i < ciphertext.length(); i++)
    {
      for(int j = 7; j >=  0; j--){
	color_data[counter] += getNthBit(ciphertext[i], j);
	counter++;
      }
    }
}  

void Steganography::decipher()
{
  int itemp = 0;
  int j = 0;
  
  while(j < color_data.size()){
    if(color_data.size() - j >= 8)
      {
	for(int i =0; i < 8; i++){
	  
	  if(i == 0)
	    itemp += ((i % 2) * 128);
	  else if( i == 1)
	    itemp += ((i % 2) * 64);
	  else if(i == 2)
	    itemp += ((i % 2) * 32);
	  else if(i == 3)
	    itemp += ((i % 2) * 16);
	  else if(i == 4)
	    itemp += ((i % 2) * 8);
	  else if(i == 5)
	    itemp += ((i % 2) * 4);
	  else if(i == 6)
	    itemp += ((i % 2) * 2);
	  else if(i == 7)
	    itemp += ((i % 2) * 1);  
	}
	ciphertext += char(itemp);
	itemp = 0;
	j++;
      }
    else {
      j = color_data.size();
      return;
    }
  }
}
