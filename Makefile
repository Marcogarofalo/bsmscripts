All: mean_and_err v0 norm_scalar ASCII_scalar


mean_and_err: mean_and_err.cpp
	g++ mean_and_err.cpp -o mean_and_err

v0: v0.cpp
	g++ v0.cpp -o v0

norm_scalar: norm_scalar.cpp
	g++ norm_scalar.cpp -o norm_scalar

ASCII_scalar: ASCII_scalar.cpp
	g++ ASCII_scalar.cpp -o ASCII_scalar
