# Assembly-language-project

Overview
--------

This program is written in x86 Assembly language and implements a **multi-cipher encoding tool**. Users can input a string and select from three encoding methods: **ROT Cipher**, **Affine Cipher**, or **XOR Cipher**. The program processes the input string according to the chosen cipher and displays the encoded output.

* * * * *

Features
--------

1.  **ROT Cipher**:

    -   Shifts each character of the string by a fixed value (KEY = 13).
    -   Handles both uppercase and lowercase letters.
2.  **Affine Cipher**:

    -   Encodes characters using the formula: `E(x) = (a * x + b) mod m`, where:
        -   `a = 17`, `b = 20`, `m = 26`.
    -   Works on both uppercase and lowercase alphabets.
3.  **XOR Cipher**:

    -   Encodes characters by XOR-ing them with a predefined key (`xorKey = 5`).
4.  **Error Handling**:

    -   Displays an error message for invalid cipher choices.

* * * * *

Program Flow
------------

1.  The user is prompted to **enter a string** to encode.
2.  The program displays a menu for the user to **choose a cipher**:
    -   `1`: ROT Cipher
    -   `2`: Affine Cipher
    -   `3`: XOR Cipher
3.  Based on the user's choice, the selected cipher is applied to the string:
    -   Each cipher operates on individual characters.
4.  The encoded string is displayed as the output.
5.  The program terminates gracefully.
