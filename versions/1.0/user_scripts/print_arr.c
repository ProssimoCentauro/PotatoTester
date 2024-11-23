#include <stdio.h>
#include <stdlib.h>

int main(int ac, char **av)
{
    if (ac == 1)
    {
        printf("\n");
        return (0);
    }

    int *arr;
    int i;
    int j;

    arr = (int *)malloc((ac * sizeof(int)) - 1);
    i = 0;
    j = 1;
    while (av[j])
    {
        arr[i] = atoi(av[j]);
        i++;
        j++;
    }
    i = 0;
    printf("[");
    while (arr[i])
    {
        if (i + 2 < ac)
            printf("%d ", arr[i]);
        else
            printf("%d", arr[i]);
        i++;
    }
    printf("]\n");
    return (0);
}
