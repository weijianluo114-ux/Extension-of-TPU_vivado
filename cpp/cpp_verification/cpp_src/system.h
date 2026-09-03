#ifndef SYSTEM_H
#define SYSTEM_H

int coe_initial(const char*);
void coe_end();

int get_data_initial();
void get_data_end();

void set_font_color_green();
void set_font_color_red();
void reset_font_color();

short FP32_to_FP16(float);
float FP16_to_FP32(short);

#endif