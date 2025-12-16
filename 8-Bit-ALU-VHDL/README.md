\# 8-bit ALU Design in VHDL



An 8-bit Arithmetic Logic Unit designed in VHDL and synthesized using Xilinx ISE 14.7.



\## ✨ Features



\- \*\*Input:\*\* Two 8-bit operands (A, B)

\- \*\*Output:\*\* 16-bit result 

\- \*\*Operations:\*\* 8 different arithmetic and logical operations

\- \*\*Status:\*\* ✅ Fully synthesized with 0 errors, 0 warnings



\## 📊 Operations



| Select Code | Operation | Description |

|------------|-----------|-------------|

| 000 | AND | Bitwise AND |

| 001 | NAND | Bitwise NAND |

| 010 | OR | Bitwise OR |

| 011 | NOR | Bitwise NOR |

| 100 | XOR | Bitwise XOR |

| 101 | Addition | A + B |

| 110 | Subtraction | A - B |

| 111 | Multiplication | A × B |



\## 🛠️ Tools Used



\- \*\*Language:\*\* VHDL

\- \*\*IDE:\*\* Xilinx ISE 14.7  

\- \*\*Target Device:\*\* Spartan-3E (xc3s250e)

\- \*\*Simulation:\*\* ISim and GTKWave



\## 📈 Synthesis Results



\- \*\*Errors:\*\* 0

\- \*\*Warnings:\*\* 0

\- \*\*Resource Usage:\*\* 1% of FPGA

\- \*\*LUTs Used:\*\* 82 out of 4896

\- \*\*Multipliers:\*\* 1 (MULT18X18)

\- \*\*Max Delay:\*\* 10.837ns



\## 📸 RTL Schematic



!\[RTL](synthesis/rtl\_schematic.png)



\## 📊 Simulation Waveform



!\[Waveform](simulation/waveform.png)



\## 🚀 How to Use



1\. Clone this repository

2\. Open Xilinx ISE 14.7

3\. Add source files from `src/` folder

4\. Add testbench from `testbench/` folder

5\. Run Behavioral Simulation



\## 📁 Project Structure



```

8bit-ALU-VHDL/

├── src/              # VHDL source code

├── testbench/        # Testbench files  

├── simulation/       # Waveform results

└── synthesis/        # Synthesis outputs

```



\## 👤 Author



\*\*Rohan Musale\*\*

\- LinkedIn: www.linkedin.com/in/rohan-musale-2501rm

\- GitHub: Rohan-Musale

---

⭐ If you found this helpful, please give it a star!

