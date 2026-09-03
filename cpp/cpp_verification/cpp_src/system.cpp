#define _CRT_SECURE_NO_WARNINGS
#include "Matrix.h"
#include <iostream>
#include <fstream>
#include <Windows.h>
#include <cmath>

#define INT4  1
#define INT8  2
#define FP16  3
#define FP32  4
#define INT32 5

using namespace std;

/*文件路径*/
extern std::string txt_path;


/*读写文件*/
FILE* fid_write;
ifstream infile;


void set_font_color_green() {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 2);
}

void set_font_color_red() {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 4);
}

void reset_font_color() {
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 7);
}


/*写coe文件初始化，返回值0为初始化失败，1为成功*/
int coe_initial(const char* path)
{
	fid_write = fopen(path, "w");
	char T1[] = "MEMORY_INITIALIZATION_RADIX = 2;";
	char T2[] = "MEMORY_INITIALIZATION_VECTOR = ";
	fprintf(fid_write, "%s\n", T1);
	fprintf(fid_write, "%s\n", T2);
	if (fid_write == NULL)
	{
		//cout << "Error: Failed to open .coe file." << endl;
		return 0;
	}
	return 1;
}


void coe_end() {
	fclose(fid_write);
}


/*读txt文件初始化，返回值0为初始化失败，1为成功*/
int get_data_initial() {
	infile.open(txt_path.c_str(), ios::in);
	if (!infile.is_open())
	{
		set_font_color_red();
		cout << "错误：";
		reset_font_color();
		cout << "txt文件打开失败！请检查文件路径配置" << endl;
		return 0;
	}
	return 1;
}

void get_data_end() {
	infile.close();
}

short FP32_to_FP16(float value)
{
	union {
		unsigned int u;
		float f;
		} input;
	input.f = value;

	unsigned int f = input.u;

	unsigned int sign = (f >> 31) & 0x1;
	int exponent = ((f >> 23) & 0xFF) - 127 + 15; // adjust exponent bias
	unsigned int mantissa = f & 0x7FFFFF;

	unsigned short result;

	if (exponent <= 0) {
		// Too small to be normalized in float16
		if (exponent < -10) {
			// Underflow to zero
			result = (unsigned short)(sign << 15);
		}
		else {
			// Subnormal float16
			mantissa |= 0x800000; // add implicit leading 1
			int shift = 14 - exponent;
			unsigned short submantissa = mantissa >> shift;
			result = (unsigned short)((sign << 15) | submantissa);
		}
	}
	else if (exponent >= 31) {
		// Overflow to Inf
		result = (unsigned short)((sign << 15) | (0x1F << 10));
	}
	else {
		// Normalized float16
		unsigned short half_exponent = (unsigned short)(exponent & 0x1F);
		unsigned short half_mantissa = (unsigned short)(mantissa >> 13); // truncate mantissa from 23 to 10 bits
		result = (unsigned short)((sign << 15) | (half_exponent << 10) | half_mantissa);
	}

	return result;
}

float FP16_to_FP32(short n)
{
	unsigned short frac = (n & 0x3ff);
	int bias = 15;
	int exp = ((n & 0x7c00) >> 10);
	float m;

	if (frac == 0 && exp == 0x1f)
		m = INFINITY;
	else if (frac && exp)
		m = (frac | 0x400) * pow(2, exp - bias - 10);
	else if (!exp)
		m = frac * pow(2, 1 - bias - 10);
	else
		m = 0;

	return (n & 0x8000) ? -m : m;
}