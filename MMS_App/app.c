#include <stdio.h>

void print_moza(unsigned int number);

int main(void)
{
    unsigned int user_number = 0;

    printf("Enter the number of mozas: ");
    scanf("%i", &user_number);

    print_moza(user_number);

    return 0;
}

void print_moza(unsigned int number)
{
    unsigned int index = 0;

    for (index = 0; index < number; index++)
    {
        printf("Ana Moza\n");
    }
}