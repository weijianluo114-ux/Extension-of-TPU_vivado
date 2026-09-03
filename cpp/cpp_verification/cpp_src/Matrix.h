#ifndef MATRIX_H
#define MATRIX_H

#include<string>

class Matrix {
public:
	int precision;
	int row, col;
	float** arr;

	Matrix(int, int);
	Matrix();
	~Matrix();
	Matrix(const Matrix&);
	int get_elem_num();
	void dimension_set(int, int);
	void precision_set(int);
	void print();
	void print(Matrix&);
	void random();
	void operator=(const Matrix&);
	Matrix operator*(const Matrix&);
	Matrix operator+(const Matrix&);
	void bin_print();
	int to_coe(int mode = 2);
	int get_from_txt(int mode = 0);
	int get_from_bin(std::string&);
	void fp32_to_fp16();
	void fp16_to_fp32();
	void initial(float);
	int count_ones();
};

void print_bin(float&);
int matrix_compare(Matrix&, Matrix&, int);


#endif