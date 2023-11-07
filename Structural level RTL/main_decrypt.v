`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    22:51:31 09/29/22
// Design Name:    
// Module Name:    main
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module main_decrypt(en_key,key,data);
input [0:127] en_key,key;
output [0:127] data;
wire [0:127] en_key0,en_key1,en_key2,en_key3,en_key4,en_key5,en_key6,en_key7,en_key8;
wire [0:127] s_key0,s_key1,s_key2,s_key3,s_key4,s_key5,s_key6,s_key7,s_key8,s_key9;
wire [0:127] sh_key0,sh_key1,sh_key2,sh_key3,sh_key4,sh_key5,sh_key6,sh_key7,sh_key8,sh_key9;
wire [0:127] mx_key0,mx_key1,mx_key2,mx_key3,mx_key4,mx_key5,mx_key6,mx_key7,mx_key8;
wire [0:127] gen_key0,gen_key1,gen_key2,gen_key3,gen_key4,gen_key5,gen_key6,gen_key7,gen_key8,gen_key9;
wire [0:127] pr_key;

inv_key_gen k00(key,,32'h01000000,gen_key0,);
inv_key_gen k11(gen_key0,,32'h02000000,gen_key1,);
inv_key_gen k22(gen_key1,,32'h04000000,gen_key2,);
inv_key_gen k33(gen_key2,,32'h08000000,gen_key3,);
inv_key_gen k44(gen_key3,,32'h10000000,gen_key4,);
inv_key_gen k55(gen_key4,,32'h20000000,gen_key5,);
inv_key_gen k66(gen_key5,,32'h40000000,gen_key6,);
inv_key_gen k77(gen_key6,,32'h80000000,gen_key7,);
inv_key_gen k88(gen_key7,,32'h1b000000,gen_key8,);
inv_key_gen k99(gen_key8,,32'h36000000,gen_key9,);


//********************************FINAL ROUND**********************************
//add round key operation

inv_key_gen k9(gen_key8,en_key,32'h36000000,gen_key9,s_key9);

//inverse shift row operation

inv_shift_row sh9(s_key9,sh_key9);

//no mix column
//sub bytes operation

inv_sub_byte s9(sh_key9,en_key8);



 //****************************ROUND9*****************************************

//add round key operation

inv_key_gen k8(gen_key7,en_key8,32'h1b000000,gen_key8,mx_key8);


//mix column

inv_mix_col  m8(mx_key8,s_key8);

//inverse shift row operation

inv_shift_row sh8(s_key8,sh_key8);


//sub bytes operation

inv_sub_byte s8(sh_key8,en_key7);


//**************************ROUND8********************************************
//add round key operation

inv_key_gen k7(gen_key6,en_key7,32'h80000000,gen_key7,mx_key7);

//mix column

inv_mix_col  m7(mx_key7,s_key7);

//inverse shift row operation

inv_shift_row sh7(s_key7,sh_key7);


//sub bytes operation

inv_sub_byte s7(sh_key7,en_key6);


//*******************************ROUND7*************************************

//add round key operation

inv_key_gen k6(gen_key5,en_key6,32'h40000000,gen_key6,mx_key6);

//mix column

inv_mix_col  m6(mx_key6,s_key6);

//inverse shift row operation

inv_shift_row sh6(s_key6,sh_key6);

//sub bytes operation

inv_sub_byte s6(sh_key6,en_key5);
//**********************************ROUND6**********************************

//add round key operation

inv_key_gen k5(gen_key4,en_key5,32'h20000000,gen_key5,mx_key5);
//mix column

inv_mix_col  m5(mx_key5,s_key5);

//inverse shift row operation

inv_shift_row sh5(s_key5,sh_key5);

//sub bytes operation

inv_sub_byte s5(sh_key5,en_key4);

//*********************************ROUND5*********************************

//add round key operation

inv_key_gen k4(gen_key3,en_key4,32'h10000000,gen_key4,mx_key4);

//mix column

inv_mix_col  m4(mx_key4,s_key4);

//inverse shift row operation

inv_shift_row sh4(s_key4,sh_key4);

//sub bytes operation

inv_sub_byte s4(sh_key4,en_key3);

//*******************************ROUND4************************************

//add round key operation

inv_key_gen k3(gen_key2,en_key3,32'h08000000,gen_key3,mx_key3);

//mix column

inv_mix_col  m3(mx_key3,s_key3);

//inverse shift row operation

inv_shift_row sh3(s_key3,sh_key3);

//sub bytes operation

inv_sub_byte s3(sh_key3,en_key2);

//******************************ROUND3**************************************

//add round key operation

inv_key_gen k2(gen_key1,en_key2,32'h04000000,gen_key2,mx_key2);
//mix column

inv_mix_col  m2(mx_key2,s_key2);

//inverse shift row operation

inv_shift_row sh2(s_key2,sh_key2);

//sub bytes operation

inv_sub_byte s2(sh_key2,en_key1);

//****************************************ROUND2********************************

//add round key operation

inv_key_gen k1(gen_key0,en_key1,32'h02000000,gen_key1,mx_key1);

//mix column

inv_mix_col  m1(mx_key1,s_key1);

//inverse shift row operation

inv_shift_row sh1(s_key1,sh_key1);

//sub bytes operation

inv_sub_byte s1(sh_key1,en_key0);


//*****************************round1*****************************************

//add round key operation

inv_key_gen k0(key,en_key0,32'h01000000,gen_key0,mx_key0);


//mix column

inv_mix_col  m0(mx_key0,s_key0);

//inverse shift row operation

inv_shift_row sh0(s_key0,sh_key0);

//sub bytes operation

inv_sub_byte s0(sh_key0,pr_key);

//pre round operation

assign data = pr_key^key;

endmodule
