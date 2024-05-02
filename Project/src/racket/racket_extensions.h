#ifndef RACKET_EXTENSIONS_H
#define RACKET_EXTENSIONS_H

#include <iostream>
#include <vector>
#include <string>

// Define a structure for pairs
struct Pair {
    void* car;
    void* cdr;
};

// Function declarations
extern "C" {
    // Function to create a pair
    void* racket_cons(void* car, void* cdr);

    // Function to extract the first element of a pair
    void* racket_car(void* pair);

    // Function to extract the second element of a pair
    void* racket_cdr(void* pair);

    // Function to create a list from its arguments
    void* racket_list(std::vector<void*>& args);

    // Function to bind a symbol to a value in the current environment
    void racket_define(const std::string& symbol, void* value);

    // Function to evaluate an expression in the current environment
    void* racket_eval(void* expr);

    // Function to apply a function to a list of arguments
    void* racket_apply(void* func, std::vector<void*>& args);

    // Function to update the value bound to a symbol
    void racket_set(const std::string& symbol, void* value);

    // Define a function for error handling
    void racket_error(const std::string& message);

    // Define a function for defining macros
    void racket_macro(std::vector<void*>& args);
}

#endif // RACKET_EXTENSIONS_H
