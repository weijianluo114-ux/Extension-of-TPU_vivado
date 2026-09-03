#include "Matrix.h"
#include "system.h"
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <random>
#include <ctime>
#include <stdio.h>
#include <fstream>
#include <string>
#include <vector>
#include <Windows.h>

#ifndef DEBUG_MODE
#define DEBUG_MODE 0             //1为调试模式，0为发行模式
#endif
#ifndef MODE
#define MODE 2				     //2为数据集矩阵验证模式，1为读取数据集模式，0为验证模式
#endif

#define INT4  1
#define INT8  2
#define FP16  3
#define FP32  4
#define INT32 5

#define ROW_MAJOR 1
#define COL_MAJOR 0
#define FIXED_WIDTH 3

using namespace std;


/*文件路径*/
string txt_path = "txt/D_result.txt";
string A_coe_path = "output/A.coe";
string B_coe_path = "output/B.coe";
string C_coe_path = "output/C.coe";
string dataset_coe_path = "output/dataset.coe";

//"D:/Flies/CS/C++/program/other/matrix/v4.0/dataset"
string dataset_path = "dataset";

string A_bin_path;
string B_bin_path;
string C_bin_path;

string path_precision, path_dimension;

int random_mode, mix_mode, precision, A_precision, B_precision, C_precision, dimension, num = 1;	//矩阵运算参数
int m = 8, n = 8, k = 8;				//默认矩阵大小
int coe_flag = 0;


int main() {

	/*读写路径读入*/
	/*读写路径读入（path.txt 覆盖默认相对路径）*/
#if !DEBUG_MODE
	{
		ifstream read_path;
		read_path.open("path.txt", ios::in);
		if (read_path.is_open()) {
			vector<string> paths;
			string line;
			while (getline(read_path, line)) {
				if (!line.empty()) paths.push_back(line);
			}
			read_path.close();
			if (paths.size() >= 1) txt_path = paths[0];
			if (paths.size() >= 2) A_coe_path = paths[1];
			if (paths.size() >= 3) B_coe_path = paths[2];
			if (paths.size() >= 4) C_coe_path = paths[3];
			if (paths.size() >= 5) dataset_coe_path = paths[4];
			cout << "初始化成功" << endl;
			cout << "输入.txt文件路径为：" << txt_path << endl;
		}
		else {
			set_font_color_red();
			cout << "错误：";
			reset_font_color();
			cout << "无法打开path.txt文件，将使用默认相对路径" << endl;
			Sleep(3000);
		}
	}
#endif

	
#if MODE == 0
	/*主循环*/
	while (1) {
		cout << "1: 随机模式：生成随机矩阵" << endl << "2: 验证模式：根据数据集生成验证矩阵" << endl;
		cout << "请输入数字1或2并按下回车键(输入0退出程序): ";
		cin >> random_mode;
		if (!random_mode) break;
		if (random_mode == 1) {
			cout << "\n1: 单一精度模式" << endl << "2: 混合精度模式" << endl;
			cout << "请输入数字1或2并按下回车键: ";
			cin >> mix_mode;
			if (mix_mode == 1) {
				cout << "\n请选择精度: \n1: INT4\n2: INT8\n3: FP16\n4: FP32" << endl;
				cout << "请输入数字1~4并按下回车键: ";
				cin >> A_precision;
				B_precision = A_precision;
				C_precision = A_precision;
			}
			else if (mix_mode == 2) {
				cout << "\n请选择矩阵A的精度: \n1: INT4\n2: INT8\n3: FP16\n4: FP32" << endl;
				cout << "请输入数字1~4并按下回车键: ";
				cin >> A_precision;
				cout << "\n请选择矩阵B的精度: \n1: INT4\n2: INT8\n3: FP16\n4: FP32" << endl;
				cout << "请输入数字1~4并按下回车键: ";
				cin >> B_precision;
				cout << "\n请选择矩阵C的精度: \n1: INT4\n2: INT8\n3: FP16\n4: FP32\n5: INT32" << endl;
				cout << "请输入数字1~4并按下回车键: ";
				cin >> C_precision;
			}
		}
		if (random_mode != 1) {
			cout << "\n请选择精度: \n1: int4\n2: int8\n3: fp16\n4: fp32\n5: int4_int32\n6: int8_int32" << endl;
			cout << "请输入数字1~6并按下回车键: ";
			cin >> precision;
			switch (precision) {
			case 1: 
				A_precision = INT4;
				B_precision = INT4;
				C_precision = INT4;
				path_precision = "int4";
				break;
			case 2:
				A_precision = INT8;
				B_precision = INT8;
				C_precision = INT8;
				path_precision = "int8";
				break;
			case 3:
				A_precision = FP16;
				B_precision = FP16;
				C_precision = FP16;
				path_precision = "fp16";
				break;
			case 4:
				A_precision = FP32;
				B_precision = FP32;
				C_precision = FP32;
				path_precision = "fp32";
				break;
			case 5:
				A_precision =  INT4;
				B_precision =  INT4;
				C_precision = INT32;
				path_precision = "int4_int32";
				break;
			case 6:
				A_precision =  INT8;
				B_precision =  INT8;
				C_precision = INT32;
				path_precision = "int8_int32";
				break;
			default:
				A_precision = INT4;
				B_precision = INT4;
				C_precision = INT4;
				path_precision = "int4";
				break;
			}
		}
		cout << "\n请选择矩阵维度: \n1: m16n16k16\n2: m32n8k16\n3: m8n32k16" << endl;
		cout << "请输入数字1~4并按下回车键(输入0为默认m4n4k4): ";
		cin >> dimension;
		switch (dimension) {
			case 1:  m = 16; n = 16; k = 16; path_dimension = "m16n16k16"; break;
			case 2:  m = 32; n =  8; k = 16; path_dimension = "m32n8k16" ; break;
			case 3:  m =  8; n = 32; k = 16; path_dimension = "m8n32k16" ; break;
			default: m =  4; n =  4; k =  4; path_dimension = "m16n16k16"; break;
		}
		if (random_mode == 1) {
			cout << "\n请输入需要生成矩阵的组数: ";
			cin >> num;
			cout << endl;
		}
		
		if (precision != 5 && precision != 6) {
			A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_" + path_precision + "_" + path_dimension + ".bin";
			B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_" + path_precision + "_" + path_dimension + ".bin";
			C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_" + path_precision + "_" + path_dimension + ".bin";
		}
		else if (precision == 5) {
			A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int4_"  + path_dimension + ".bin";
			B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int4_"  + path_dimension + ".bin"; 
			C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
		}
		else if (precision == 6) {
			A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int8_"  + path_dimension + ".bin";
			B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int8_"  + path_dimension + ".bin";
			C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
		}

		//cout << A_bin_path << endl << B_bin_path << endl << C_bin_path << endl;
		

		/*生成矩阵数组*/
		Matrix* A = new Matrix[num];
		Matrix* B = new Matrix[num];
		Matrix* C = new Matrix[num];
		Matrix* gold = new Matrix[num];

		/*初始化并打印随机矩阵*/
		for (int i = 0; i < num; i++) {
			A[i].dimension_set(m, k);
			A[i].precision_set(A_precision);
			if (random_mode == 1) A[i].random();
			if (random_mode == 2) A[i].get_from_bin(A_bin_path);
			cout << "A[" << i << "]: " << endl;
			if (A_precision == FP16) {
				A[i].fp32_to_fp16();
				A[i].fp16_to_fp32();
			}
			A[i].print();
			cout << endl;
		}
		for (int i = 0; i < num; i++) {
			B[i].dimension_set(k, n);
			B[i].precision_set(B_precision);
			if (random_mode == 1) B[i].random();
			if (random_mode == 2) B[i].get_from_bin(B_bin_path);
			cout << "B[" << i << "]: " << endl;
			if (B_precision == FP16) {
				B[i].fp32_to_fp16();
				B[i].fp16_to_fp32();
			}
			B[i].print();
			cout << endl;
		}

		for (int i = 0; i < num; i++) {
			C[i].dimension_set(m, n);
			C[i].precision_set(C_precision);
			if (random_mode == 1) C[i].random();
			if (random_mode == 2) C[i].get_from_bin(C_bin_path);
			cout << "C[" << i << "]: " << endl;
			if (C_precision == FP16) {
				C[i].fp32_to_fp16();
				C[i].fp16_to_fp32();
			}
			C[i].print();
			cout << endl;
		}
		
		/*随机矩阵输出至coe文件*/
		while (1) {
			coe_flag = coe_initial(A_coe_path.c_str());
			if (coe_flag) {
				for (int i = 0; i < num; i++) {
					A[i].to_coe(ROW_MAJOR);
				}
				coe_end();
				cout << "矩阵A的coe文件已生成" << endl;
				break;
			}
			else if (!coe_flag) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "矩阵A的coe文件生成失败，是否重新生成？[y/n] ";
				char if_retry;
				cin >> if_retry;
				if (if_retry == 'y' || if_retry == 'Y') continue;
				else break;
			}
		}

		while (1) {
			coe_flag = coe_initial(B_coe_path.c_str());
			if (coe_flag) {
				for (int i = 0; i < num; i++) {
					B[i].to_coe(COL_MAJOR);
				}
				coe_end();
				cout << "矩阵B的coe文件已生成" << endl;
				break;
			}
			else if (!coe_flag) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "矩阵B的coe文件生成失败，是否重新生成？[y/n] ";
				char if_retry;
				cin >> if_retry;
				if (if_retry == 'y' || if_retry == 'Y') continue;
				else break;
			}
		}

		while (1) {
			coe_flag = coe_initial(C_coe_path.c_str());
			if (coe_flag) {
				for (int i = 0; i < num; i++) {
					C[i].to_coe();
				}
				coe_end();
				cout << "矩阵C的coe文件已生成" << endl;
				break;
			}
			else if (!coe_flag) {
				set_font_color_red();
				cout << "错误：";
				reset_font_color();
				cout << "矩阵C的coe文件生成失败，是否重新生成？[y/n] ";
				char if_retry;
				cin >> if_retry;
				if (if_retry == 'y' || if_retry == 'Y') continue;
				else break;
			}
		}

		/*矩阵运算*/
		for (int i = 0; i < num; i++) {
			gold[i] = A[i] * B[i] + C[i];
		}

		/*创建结果矩阵（读取到的矩阵将存储在result_matrix[]中）*/
		Matrix* result_matrix = new Matrix[num];
		for (int i = 0; i < num; i++) {
			result_matrix[i].dimension_set(m, n);
			result_matrix[i].precision_set(gold->precision);
		}

		/*结果读取与验证*/
		while (1) {
			cout << "等待生成txt文件..." << endl;
			cout << "是否开始读文件？[y/n] ";
			char if_read;									//判断是否读txt文件
			int read_flag = 1;								//判断读数据是否成功（1为成功，0为错误）
			int comp_flag = 1;								//判断结果是否正确（1为正确，0为错误）
			cin >> if_read;
			if (if_read == 'y' || if_read == 'Y') {
				if (!get_data_initial()) {
					read_flag = 0;
				}
				else {
					comp_flag = 1;
					for (int i = 0; i < num; i++) {
						read_flag &= result_matrix[i].get_from_txt(FIXED_WIDTH);
						if (!read_flag) {
							comp_flag = 0;
							break;
						}
						comp_flag &= matrix_compare(gold[i], result_matrix[i], i);
					}
					get_data_end();
				}
			}

			if (comp_flag && (if_read == 'y' || if_read == 'Y')) {
				set_font_color_green();
				cout << "结果正确" << endl;
				reset_font_color();
				//break;
			}
			else {
				if (!comp_flag) {
					set_font_color_red();
					cout << "结果错误" << endl;
					reset_font_color();
				}
				cout << "是否重新读txt文件？[y/n] ";
				char if_retry;
				cin >> if_retry;
				if (if_retry == 'y' || if_retry == 'Y') continue;
				else {
					delete[] A;
					delete[] B;
					delete[] C;
					delete[] gold;
					delete[] result_matrix;
					break;
				}
			}
		}
	}

	return 0;

#endif

#if MODE == 1
	coe_initial(dataset_coe_path.c_str());
	for (precision = 1; precision <= 6; precision++) {
		switch (precision) {
		case 1:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT4;
			path_precision = "int4";
			break;
		case 2:
			A_precision = INT8;
			B_precision = INT8;
			C_precision = INT8;
			path_precision = "int8";
			break;
		case 3:
			A_precision = FP16;
			B_precision = FP16;
			C_precision = FP16;
			path_precision = "fp16";
			break;
		case 4:
			A_precision = FP32;
			B_precision = FP32;
			C_precision = FP32;
			path_precision = "fp32";
			break;
		case 5:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT32;
			path_precision = "int4_int32";
			break;
		case 6:
			A_precision = INT8;
			B_precision = INT8;
			C_precision = INT32;
			path_precision = "int8_int32";
			break;
		default:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT4;
			path_precision = "int4";
			break;
		}
		for (dimension = 1; dimension <= 3; dimension++) {
			switch (dimension) {
			case 1:  m = 16; n = 16; k = 16; path_dimension = "m16n16k16"; break;
			case 2:  m = 32; n = 8; k = 16; path_dimension = "m32n8k16"; break;
			case 3:  m = 8; n = 32; k = 16; path_dimension = "m8n32k16"; break;
			default: m = 4; n = 4; k = 4; path_dimension = "m16n16k16"; break;
			}
			if (precision != 5 && precision != 6) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_" + path_precision + "_" + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_" + path_precision + "_" + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_" + path_precision + "_" + path_dimension + ".bin";
			}
			else if (precision == 5) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int4_" + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int4_" + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
			}
			else if (precision == 6) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int8_" + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int8_" + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
			}

			Matrix a(m, k), b(k, n), c(m, n);
			a.precision = A_precision;
			b.precision = B_precision;
			c.precision = C_precision;
			a.get_from_bin(A_bin_path);
			b.get_from_bin(B_bin_path);
			c.get_from_bin(C_bin_path);
			a.to_coe(FIXED_WIDTH);
			b.to_coe(FIXED_WIDTH);
			c.to_coe(FIXED_WIDTH);
		}
	}
	coe_end();

	return 0;
	
#endif
	
#if MODE == 2

	Matrix* A = new Matrix[18];
	Matrix* B = new Matrix[18];
	Matrix* C = new Matrix[18];
	Matrix* gold = new Matrix[18];
	Matrix* result_matrix = new Matrix[18];

	int i = 0;

	for (precision = 1; precision <= 6; precision++) {
		switch (precision) {
		case 1:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT4;
			path_precision = "int4";
			break;
		case 2:
			A_precision = INT8;
			B_precision = INT8;
			C_precision = INT8;
			path_precision = "int8";
			break;
		case 3:
			A_precision = FP16;
			B_precision = FP16;
			C_precision = FP16;
			path_precision = "fp16";
			break;
		case 4:
			A_precision = FP32;
			B_precision = FP32;
			C_precision = FP32;
			path_precision = "fp32";
			break;
		case 5:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT32;
			path_precision = "int4_int32";
			break;
		case 6:
			A_precision = INT8;
			B_precision = INT8;
			C_precision = INT32;
			path_precision = "int8_int32";
			break;
		default:
			A_precision = INT4;
			B_precision = INT4;
			C_precision = INT4;
			path_precision = "int4";
			break;
		}
		for (dimension = 1; dimension <= 3; dimension++) {
			switch (dimension) {
			case 1:  m = 16; n = 16; k = 16; path_dimension = "m16n16k16"; break;
			case 2:  m = 32; n = 8;  k = 16; path_dimension = "m32n8k16";  break;
			case 3:  m = 8;  n = 32; k = 16; path_dimension = "m8n32k16";  break;
			default: m = 4;  n = 4;  k = 4;  path_dimension = "m16n16k16"; break;
			}
			if (precision != 5 && precision != 6) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_" + path_precision + "_" + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_" + path_precision + "_" + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_" + path_precision + "_" + path_dimension + ".bin";
			}
			else if (precision == 5) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int4_"  + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int4_"  + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
			}
			else if (precision == 6) {
				A_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/a_int8_"  + path_dimension + ".bin";
				B_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/b_int8_"  + path_dimension + ".bin";
				C_bin_path = dataset_path + "/" + path_precision + "/" + path_dimension + "/c_int32_" + path_dimension + ".bin";
			}

			A[i].dimension_set(m, k);
			B[i].dimension_set(k, n);
			C[i].dimension_set(m, n);

			A[i].precision_set(A_precision);
			B[i].precision_set(B_precision);
			C[i].precision_set(C_precision);

			A[i].get_from_bin(A_bin_path);
			B[i].get_from_bin(B_bin_path);
			C[i].get_from_bin(C_bin_path);

			result_matrix[i].dimension_set(m, n);

			i++;
			
		}
	}

	for (int i = 0; i < 18; i++) {
		gold[i] = A[i] * B[i] + C[i];
	}

	for (int i = 0; i < 18; i++) {
		result_matrix[i].precision_set(gold[i].precision);
	}

	for (int i = 0; i < 18; i++) {
		std::cout << "A[" << i << "]: precision: " << A[i].precision << " dimention: " << A[i].row << " * " << A[i].col << std::endl;
		A[i].print();
		std::cout << "B[" << i << "]: precision: " << B[i].precision << " dimention: " << B[i].row << " * " << B[i].col << std::endl;
		B[i].print();
		std::cout << "C[" << i << "]: precision: " << C[i].precision << " dimention: " << C[i].row << " * " << C[i].col << std::endl;
		C[i].print();
		std::cout << "D[" << i << "]: precision: " << gold[i].precision << " dimention: " << gold[i].row << " * " << gold[i].col << std::endl;
		gold[i].print();
	}


	/*结果读取与验证*/
	while (1) {
		std::cout << "等待生成txt文件..." << std::endl;
		std::cout << "是否开始读文件？[y/n] ";
		char if_read;									//判断是否读txt文件
		int read_flag = 1;								//判断读数据是否成功（1为成功，0为错误）
		int comp_flag = 1;								//判断结果是否正确（1为正确，0为错误）
		std::cin >> if_read;
		if (if_read == 'y' || if_read == 'Y') {
			if (!get_data_initial()) {
				read_flag = 0;
			}
			else {
				comp_flag = 1;
				for (int i = 0; i < 18; i++) {
					read_flag &= result_matrix[i].get_from_txt(FIXED_WIDTH);
					if (!read_flag) {
						comp_flag = 0;
						break;
					}
					comp_flag &= matrix_compare(gold[i], result_matrix[i], i);
				}
				get_data_end();
			}
		}

		if (comp_flag && (if_read == 'y' || if_read == 'Y')) {
			set_font_color_green();
			std::cout << "结果正确" << std::endl;
			reset_font_color();
			//break;
		}
		else {
			if (!comp_flag) {
				set_font_color_red();
				std::cout << "结果错误" << std::endl;
				reset_font_color();
			}
			std::cout << "是否重新读txt文件？[y/n] ";
			char if_retry;
			std::cin >> if_retry;
			if (if_retry == 'y' || if_retry == 'Y') continue;
			else {
				delete[] A;
				delete[] B;
				delete[] C;
				delete[] gold;
				delete[] result_matrix;
				break;
			}
		}
	}

	return 0;
#endif

}
