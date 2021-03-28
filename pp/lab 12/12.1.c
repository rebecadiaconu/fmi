#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

char *prefix(char *s, ...) {
    char *p, *prefix;
    int i;

    va_list lp;
    va_start(lp, s);
    prefix = (char *) malloc(strlen(s) + 1);
    strcpy(prefix, s);

    while ((p = va_arg(lp, char*)) != 0)
    {
        for (i = 0; i < strlen(p); i++)
            if (prefix[i] != p[i]) {
                prefix[i] = '\0';
                break;
            }
    }
    va_end(lp);

    return prefix;
}

int main() {
    char *result;
    result = prefix("ana", "analiza", "anus", 0);
    printf("%s ", result);

    return 0;
}