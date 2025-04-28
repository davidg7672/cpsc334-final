#include "linkedlist.hpp"

int main() {
    LinkedList list;

    list.append(5);
    list.append(1);
    list.append(8);
    list.append(3);

    // list.display_list();

    list.sort();

    // list.display_list(); // After sort

    return 0;
}
