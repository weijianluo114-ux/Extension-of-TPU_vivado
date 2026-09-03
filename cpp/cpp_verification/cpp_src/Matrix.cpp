#define _CRT_SECURE_NO_WARNINGS
#include "Matrix.h"
#include "system.h"
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cmath>
#include <random>
#include <ctime>
#include <stdio.h>
#include <fstream>
#include <string>
#include <vector>
#include <Windows.h>
#include <bitset>

#define INT4  1
#define INT8  2
#define FP16  3
#define FP32  4
#define INT32 5

#define PRECISION 1e-4

using namespace std;

extern FILE* fid_write;
extern ifstream infile;


/*生成随机序列*/
//default_random_engine e(time(0));
default_random_engine e(0);
uniform_int_distribution<int> fp32(-99999, 99999);

uniform_int_distribution<int> int4(-8, 7);

uniform_int_distribution<int> int8(-128, 127);



void print_bin(float& f) {
	float* pf = &f;
	char* pc = (char*)pf;
	pc = pc + 3;
	for (int j = 0; j < 4; j++) {
		int i = 0;
		while (i < 8 * sizeof(char))
		{
			printf("%d", (*pc & (0x80 >> i++)) >> (8 * sizeof(char) - i) );
		}
		//if (j != 3) cout << " ";
		//else cout << endl;
		pc--;
	}
}

Matrix::Matrix(int _row, int _col) {
	row = _row;
	col = _col;
	precision = FP32;
	arr = new float* [row];
	for (int i = 0; i < row; i++) {
		arr[i] = new float[col];
	}
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			arr[i][j] = 0;
		}
	}
}

Matrix::Matrix() {
	row = 0;
	col = 0;
	precision = FP32;
	arr = NULL;
}

void Matrix::dimension_set(int _row, int _col) {
	if (row == 0 && col == 0 && arr == NULL) {
		row = _row;
		col = _col;
		arr = new float* [row];
		for (int i = 0; i < row; i++) {
			arr[i] = new float[col];
		}
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				arr[i][j] = 0;
			}
		}
	}
}

void Matrix::precision_set(int _precision) {
	precision = _precision;
}

Matrix::~Matrix() {
	for (int i = 0; i < row; i++) {
		delete[] arr[i];
	}
	delete arr;
}

void Matrix::print() {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			if (precision == FP32 || precision == FP16)
				cout << scientific << setprecision(6) << setw(15) << arr[i][j];
			if (precision == INT4 || precision == INT8)
				cout << setw(7) << int(arr[i][j]);
			if (precision == INT32)
				cout << setw(15) << *(int*)&arr[i][j];
			if (j != col - 1) cout << ", ";
		}
		cout << endl;
	}
}

void Matrix::print(Matrix& mask) {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			if (mask.arr[i][j]) set_font_color_red();
			if (precision == FP32 || precision == FP16)
				cout << scientific<< setw(15) << arr[i][j];
			if (precision == INT4 || precision == INT8)
				cout << setw(7) << int(arr[i][j]);
			if (precision == INT32)
				cout << setw(15) << *(int*)&arr[i][j];
			if (j != col - 1) cout << ", ";
			reset_font_color();
		}
		cout << endl;
	}
}

void Matrix::random() {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			if (precision == FP32 || precision == FP16)
				arr[i][j] = float(fp32(e)) / 1e4;
			if (precision == INT4)
				arr[i][j] = int4(e);
			if (precision == INT8)
				arr[i][j] = int8(e);
		}
	}
}

Matrix::Matrix(const Matrix& C) {
	if ((row != C.row) || (col != C.col)) {
		if (arr != NULL) {
			for (int i = 0; i < row; i++) {
				delete[] arr[i];
			}
			delete arr;
		}
		row = C.row;
		col = C.col;
		arr = new float* [row];
		for (int i = 0; i < row; i++) {
			arr[i] = new float[col];
		}
	}
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			arr[i][j] = C.arr[i][j];
		}
	}
}

int Matrix::get_elem_num() {
	return row * col;
}

void Matrix::operator=(const Matrix& C) {
	precision = C.precision;
	if ((row != C.row) || (col != C.col)) {
		if (arr != NULL) {
			for (int i = 0; i < row; i++) {
				delete[] arr[i];
			}
			delete arr;
		}
		row = C.row;
		col = C.col;
		arr = new float* [row];
		for (int i = 0; i < row; i++) {
			arr[i] = new float[col];
		}
	}
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			arr[i][j] = C.arr[i][j];
		}
	}
}

Matrix Matrix::operator+(const Matrix& C) {
	Matrix Temp(row, col);
	if (precision == FP16 || precision == FP32 || C.precision == FP16 || C.precision == FP32) {
		Temp.precision = FP32;
	}
	else {
		Temp.precision = INT32;
	}
	if ((row != C.row) || (col != C.col)) {
		set_font_color_red();
		cout << "错误：";
		reset_font_color();
		cout << "加法运算两矩阵行列数需相同！" << endl;
	}
	else {
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				if (Temp.precision == FP32) {
					//Temp.arr[i][j] = arr[i][j] + C.arr[i][j];
					float add1, add2;
					add1 = (precision == INT32) ? *(int*)&arr[i][j] : arr[i][j];
					add2 = (C.precision == INT32) ? *(int*)&C.arr[i][j] : C.arr[i][j];
					float sum = add1 + add2;
					Temp.arr[i][j] = sum;
				}
				if (Temp.precision == INT32) {
					int add1, add2;
					add1 = (precision == INT32) ? *(int*)&arr[i][j] : int(arr[i][j]);
					add2 = (C.precision == INT32) ? *(int*)&C.arr[i][j] : int(C.arr[i][j]);
					int sum = add1 + add2;
					Temp.arr[i][j] = *(float*)&sum;
				}
			}
		}
	}
	return Temp;
}

Matrix Matrix::operator*(const Matrix& C) {
	Matrix Temp(row, C.col);
	if (precision == FP16 || precision == FP32 || C.precision == FP16 || C.precision == FP32) {
		Temp.precision = FP32;
	}
	else {
		Temp.precision = INT32;
	}
	if (col != C.row) {
		set_font_color_red();
		cout << "错误：";
		reset_font_color();
		cout << "乘法运算两矩阵前者列数需等于后者行数！" << endl;
	}
	else {
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < C.col; j++) {
				float f_sum = 0;
				int i_sum = 0;
				for (int k = 0; k < col; k++) {
					if (Temp.precision == FP32) {
						float mul1, mul2;
						mul1 = (precision == INT32) ? *(int*)&arr[i][k] : arr[i][k];
						mul2 = (C.precision == INT32) ? *(int*)&C.arr[k][j] : C.arr[k][j];
						f_sum += mul1 * mul2;
						Temp.arr[i][j] = f_sum;
					}
					if (Temp.precision == INT32) {
						int mul1, mul2;
						mul1 = (precision == INT32) ? *(int*)&arr[i][k] : int(arr[i][k]);
						mul2 = (C.precision == INT32) ? *(int*)&C.arr[k][j] : int(C.arr[k][j]);
						i_sum += mul1 * mul2;
						Temp.arr[i][j] = *(float*)&i_sum;
					}
				}
			}
		}
	}
	return Temp;
}

void Matrix::bin_print() {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			print_bin(arr[i][j]);
			cout << endl;
		}
		//cout << endl;
	}
}

// 生成coe文件
// @brief 将矩阵中的值输出至指定coe文件（该函数需要在调用coe_initial函数后使用）
// @param mode 输出模式，2为行优先输出，每次输出一个元素；1为行优先输出，每次输出一行元素；0为列优先输出，每次输出一列元素（默认值为2）
// @retval 1为成功输出，0为失败
int Matrix::to_coe(int mode) {
	if (fid_write == NULL)
	{
		return 0;
	}
	int cnt = 0;
	int i_max = mode ? row : col;
	int j_max = mode ? col : row;
	if (precision == FP32) {
		for (int i = 0; i < i_max; i++) {
			for (int j = 0; j < j_max; j++) {
				float* pf = &(mode ? arr[i][j] : arr[j][i]);
				char* pc = (char*)pf;
				pc = pc + 3;
				for (int k = 0; k < 4; k++) {
					int shift = 0;
					while (shift < 8 * sizeof(char))
					{
						fprintf(fid_write, "%d", (*pc & (0x80 >> shift++)) >> (8 * sizeof(char) - shift));
					}
					pc--;
				}
				cnt++;
				if (mode == 3 && cnt % (128 / 32) == 0) fprintf(fid_write, ",\n");
				if (mode == 2) fprintf(fid_write, ",\n");
			}
			if (mode != 2 && mode != 3) fprintf(fid_write, ",\n");
		}
	}
	if (precision == FP16) {
		this->fp32_to_fp16();
		for (int i = 0; i < i_max; i++) {
			for (int j = 0; j < j_max; j++) {
				short* ps = (short*)&(mode ? arr[i][j] : arr[j][i]);
				char* pc = (char*)ps;
				pc = pc + 1;
				for (int k = 0; k < 2; k++) {
					int shift = 0;
					while (shift < 8 * sizeof(char))
					{
						fprintf(fid_write, "%d", (*pc & (0x80 >> shift++)) >> (8 * sizeof(char) - shift));
					}
					pc--;
				}
				cnt++;
				if (mode == 3 && cnt % (128 / 16) == 0) fprintf(fid_write, ",\n");
				if (mode == 2) fprintf(fid_write, ",\n");
			}
			if (mode != 2 && mode != 3) fprintf(fid_write, ",\n");
		}
		this->fp16_to_fp32();
	}
	if (precision == INT4) {
		for (int i = 0; i < i_max; i++) {
			for (int j = 0; j < j_max; j++) {
				int shift = 0;
				float elem = mode ? arr[i][j] : arr[j][i];
				while (shift < 4)
				{
					fprintf(fid_write, "%d", (char(elem) & (0x08 >> shift++)) >> (4 - shift));
				}
				cnt++;
				if (mode == 3 && cnt % (128 / 4) == 0) fprintf(fid_write, ",\n");
				if (mode == 2) fprintf(fid_write, ",\n");
			}
			if (mode != 2 && mode != 3) fprintf(fid_write, ",\n");
		}
	}
	if (precision == INT8) {
		for (int i = 0; i < i_max; i++) {
			for (int j = 0; j < j_max; j++) {
				int shift = 0;
				float elem = mode ? arr[i][j] : arr[j][i];
				while (shift < 8)
				{
					fprintf(fid_write, "%d", (char(elem) & (0x80 >> shift++)) >> (8 - shift));
				}
				cnt++;
				if (mode == 3 && cnt % (128 / 8) == 0) fprintf(fid_write, ",\n");
				if (mode == 2) fprintf(fid_write, ",\n");
			}
			if (mode != 2 && mode != 3) fprintf(fid_write, ",\n");
		}
	}
	if (precision == INT32) {
		for (int i = 0; i < i_max; i++) {
			for (int j = 0; j < j_max; j++) {
				float elem = (mode ? arr[i][j] : arr[j][i]);
				int* pi = (int*)&elem;
				char* pc = (char*)pi;
				pc = pc + 3;
				for (int k = 0; k < 4; k++) {
					int shift = 0;
					while (shift < 8 * sizeof(char))
					{
						fprintf(fid_write, "%d", (*pc & (0x80 >> shift++)) >> (8 * sizeof(char) - shift));
					}
					pc--;
				}
				cnt++;
				if (mode == 3 && cnt % (128 / 32) == 0) fprintf(fid_write, ",\n");
				if (mode == 2) fprintf(fid_write, ",\n");
			}
			if (mode != 2 && mode != 3) fprintf(fid_write, ",\n");
		}
	}
	return 1;
}



int Matrix::get_from_txt(int mode) {
	string buf;
	if(!mode)
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				/*结果为32位*/
				getline(infile, buf);
				if (buf.empty()) {
					set_font_color_red();
					cout << "错误：";
					reset_font_color();
					cout << "txt文件中存在数据缺失！" << endl;
					return 0;
				}
				else if (buf.find("z") != string::npos) {
					set_font_color_red();
					cout << "错误：";
					reset_font_color();
					cout << "数据中存在高阻态！" << endl;
					return 0;
				}
				else if (buf.find("x") != string::npos) {
					set_font_color_red();
					cout << "错误：";
					reset_font_color();
					cout << "数据中存在不定态！" << endl;
					return 0;
				}
				std::bitset<32> bits(buf);
				uint32_t data = static_cast<uint32_t>(bits.to_ulong());
				memcpy(&arr[i][j], &data, sizeof(float));
			}
		}
	if(mode == 3)
		for (int i = 0; i < row * col / 4; i++) {
			getline(infile, buf);
			if (buf.empty()) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "txt文件中存在数据缺失！" << endl;
				return 0;
			}
			else if (buf.find("z") != string::npos) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "数据中存在高阻态！" << endl;
				return 0;
			}
			else if (buf.find("x") != string::npos) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "数据中存在不定态！" << endl;
				return 0;
			}
			string buf1, buf2, buf3, buf4;
			buf1 = buf.substr(0, 32);
			buf2 = buf.substr(32, 32);
			buf3 = buf.substr(64, 32);
			buf4 = buf.substr(96, 32);
			bitset<32> bits1(buf1);
			bitset<32> bits2(buf2);
			bitset<32> bits3(buf3);
			bitset<32> bits4(buf4);
			uint32_t data1 = static_cast<uint32_t>(bits1.to_ulong());
			uint32_t data2 = static_cast<uint32_t>(bits2.to_ulong());
			uint32_t data3 = static_cast<uint32_t>(bits3.to_ulong());
			uint32_t data4 = static_cast<uint32_t>(bits4.to_ulong());
			memcpy(&arr[(i * 4) / col][(i * 4) % col], &data1, sizeof(float));
			memcpy(&arr[(i * 4 + 1) / col][(i * 4 + 1) % col], &data2, sizeof(float));
			memcpy(&arr[(i * 4 + 2) / col][(i * 4 + 2) % col], &data3, sizeof(float));
			memcpy(&arr[(i * 4 + 3) / col][(i * 4 + 3) % col], &data4, sizeof(float));
		}
	return 1;
}

int Matrix::get_from_bin(string& bin_path) {
	ifstream bin;
	bin.open(bin_path, ios::in | ios::binary);
	if (!bin.is_open()) {
		set_font_color_red();
		cout << "错误：";
		reset_font_color();
		cout << "bin文件打开失败，文件路径：" << bin_path << endl;
		return 0;
	}

	bin.seekg(0, ios::end);
	size_t bin_file_size = bin.tellg();
	bin.seekg(0, ios::beg);

	vector<char> buffer(bin_file_size);
	bin.read(buffer.data(), bin_file_size);

	bin.close();

	if (precision == INT4) {
		int cnt = 0;
		char data;
		char* p = buffer.data();
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				data = (cnt % 2 == 0) ? ((*p & 0xf0) >> 4) : (*p & 0x0f);	//第奇数个数据取高4位并右移4位，第偶数个数据取低4位
				if ((data & 0x08) == 0x08) data |= 0xf0;	//判断符号位并补全符号位
				arr[i][j] = float(data);
				if (cnt % 2 != 0) p++;
				cnt++;
			}
		}
	}
	if (precision == INT8) {
		char* p = buffer.data();
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				arr[i][j] = float(*p);
				p++;
			}
		}
	}
	if (precision == FP16) {
		short* p = (short*)buffer.data();
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				arr[i][j] = FP16_to_FP32(*p);
				p++;
			}
		}
	}
	if (precision == FP32) {
		float* p = (float*)buffer.data();
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				arr[i][j] = *p;
				p++;
			}
		}
	}
	if (precision == INT32) {
		int* p = (int*)buffer.data();
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				arr[i][j] = *(float*)p;
				p++;
			}
		}
	}
	return 1;
}

/*比较两矩阵，相同返回1，不同返回0*/
int matrix_compare(Matrix& A, Matrix& B, int i) {
	int error_flag = 0;
	if ((A.row != B.row) || (A.col != B.col)) {
		set_font_color_red();
		cout << "错误：";
		reset_font_color();
		cout << "需对比的两矩阵行列数不相同" << endl;
		return 0;
	}
	else {
		Matrix error_matrix(A.row, A.col);
		for (int i = 0; i < A.row; i++) {
			for (int j = 0; j < A.col; j++) {
				if (A.precision == FP32) {
					double x = double(A.arr[i][j]) - double(B.arr[i][j]);
					double rel_err = abs(x) / abs(double(A.arr[i][j]));
					if (isinf(A.arr[i][j]) && isinf(B.arr[i][j]) &&
						((((*(int*)&A.arr[i][j]) & 0x80000000) >> 31) == (((*(int*)&B.arr[i][j]) & 0x80000000) >> 31))) {}
					else if (isnan(A.arr[i][j]) && isnan(B.arr[i][j])) {}
					else if (rel_err <= PRECISION) {}
					else {
						error_flag = 1;
						error_matrix.arr[i][j] = 1;
					}
				}
				if (A.precision == INT32) {
					if ((*(int*)&A.arr[i][j] == *(int*)&B.arr[i][j])) {}
					else {
						error_flag = 1;
						error_matrix.arr[i][j] = 1;
					}
				}
			}
		}
		double acc;
		acc = (1.0 - double(error_matrix.count_ones()) / double(error_matrix.get_elem_num()));
		if (error_flag) {
			set_font_color_red();
			cout << "第[" << i << "]组 结果错误" << endl;
			reset_font_color();
			cout <<"对于第[" << i << "]组数据，正确结果为: " << endl;
			A.print();
			cout << endl;
			cout << "Result[" << i << "]输出结果:" << endl;
			B.print(error_matrix);
			cout << "正确率: " << fixed << setprecision(1) << acc * 100 << "%" << endl;
			return 0;
		}
		else {
			cout << "第[" << i << "]组 结果正确" << endl;
			cout << "Result[" << i << "]:" << endl;
			set_font_color_green();
			B.print();
			reset_font_color();
			cout << "正确率: " << fixed << setprecision(1) << acc * 100 << "%" << endl;
			return 1;
		}
	}
}

int Matrix::count_ones() {
	int cnt = 0;
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			if (arr[i][j]) cnt++;
		}
	}
	return cnt;
}

void Matrix::fp32_to_fp16() {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			short* ps = (short*)&arr[i][j];
			short temp = FP32_to_FP16(arr[i][j]);
			*ps = temp;
		}
	}
}

void Matrix::fp16_to_fp32() {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			short* ps = (short*)&arr[i][j];
			float temp = FP16_to_FP32(*ps);
			arr[i][j] = temp;
		}
	}
}

void Matrix::initial(float num) {
	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			arr[i][j] = num;
		}
	}
}

