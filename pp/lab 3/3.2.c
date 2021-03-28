#include <stdio.h>
#include <stdlib.h>

int main() {
    char op;
    int a, b;

    printf("Constructia este:");
    scanf("%d %c %d", &a, &op, &b);

    switch (op) {
        case '+': {
            printf("%d", a + b);
        }
            break;
        case '-': {
            printf("%d", a - b);
        }
            break;
        case '*': {
            printf("%d", a * b);
        }
            break;
        case '%': {
            printf("%d", a % b);
        }
            break;
        case '/': {
            if (b != 0) printf("%d", a / b);
            else printf("Operatia nu poate avea loc.\n");
        }
            break;
        default:
            printf("Constructia data nu indeplineste cerintele enuntului.\n");
            break;
    }

    return 0;
}
