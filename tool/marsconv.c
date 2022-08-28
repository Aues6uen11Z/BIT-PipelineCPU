#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
MARSconv <RAW_FILENAME>
    Convert MARS dump file to Vivado $readmemb & $readmemh compatible format.

Usage: 
    You can also simply drag dump file to this program, this works in common OSes.
    The converted file will be saved as "<RAW_FILENAME>.mem", overwriting if file exists.
    For example, "code.txt" will be converted to "code.txt.mem".
    
    When dumping machine code in MARS, choose Binary Text or Hexadecimal Text mode.
    The program will decide which mode you're using.
    For Binary Text mode, the converted file is compatible to $readmemb function.
    For Hexadecimal Text mode, the converted file is compatible to $readmemh function.
*/

char buf[256];

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Invalid arguments!\n");
        printf("MARSconv <RAW_FILENAME>\n"
               "    Convert MARS dump file to Vivado $readmemb & $readmemh compatible format.\n"
               "\n"
               "Usage: \n"
               "    You can also simply drag dump file to this program, this works in common OSes.\n"
               "    The converted file will be saved as ""<RAW_FILENAME>.mem"", overwriting if file exists.\n"
               "    For example, ""code.txt"" will be converted to ""code.txt.mem"".\n"
               "    \n"
               "    When dumping machine code in MARS, choose Binary Text or Hexadecimal Text mode.\n"
               "    The program will decide which mode you're using.\n"
               "    For Binary Text mode, the converted file is compatible to $readmemb function.\n"
               "    For Hexadecimal Text mode, the converted file is compatible to $readmemh function.\n");
        getchar();
        return 1;
    }
    FILE *fi = fopen(argv[1], "r");
    if (fi == NULL) {
        printf("Failed to open \"%s\"!\n", argv[1]);
        getchar();
        return 2;
    }
    sprintf(buf, "%s.mem", argv[1]);
    FILE *fo = fopen(buf, "w");
    if (fo == NULL) {
        printf("Failed to open \"%s\"!\n", buf);
        getchar();
        return 3;
    }

    while (fgets(buf, 256, fi) != NULL) {
        int len = strlen(buf) - 1, byteseg = 0;
        if (len == 8) {
            byteseg = 2;
        }
        else if (len == 32) {
            byteseg = 8;
        }
        else {
            printf("Error in file! %d", len);
            getchar();
            return 4;
        }
        for (int i = 3; i >= 0; --i) {
            for (int j = 0; j < byteseg; ++j) {
                fputc(buf[i * 2 + j], fo);
            }
            fputc(' ', fo);
        }
        fputc('\n', fo);
    }
    
    fclose(fi);
    fclose(fo);
    printf("Done.\n");
    return 0;
}
