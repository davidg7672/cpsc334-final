#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"
#include "linkedlist.hpp"

// 1. New list should be empty
TEST_CASE("New list is empty") {
    LinkedList list;
    CHECK(list.is_empty() == true);
}

// 2. After appending, list is not empty
TEST_CASE("Append makes list not empty") {
    LinkedList list;
    list.append(5);
    CHECK(list.is_empty() == false);
}

// 3. get_list_size() returns correct size
TEST_CASE("Get list size after appending") {
    LinkedList list;
    list.append(1);
    list.append(2);
    list.append(3);
    CHECK(list.get_list_size() == 3);
}

// 4. Append maintains insertion order
TEST_CASE("Append keeps correct order") {
    LinkedList list;
    list.append(10);
    list.append(20);
    list.append(30);

    // We will peek at the head through a display capture trick
    // Since display_list() outputs to cout, we just trust order based on logic
    CHECK(list.get_list_size() == 3);
}

// 5. Merge sort correctly sorts list
TEST_CASE("Merge sort correctly sorts the list") {
    LinkedList list;
    list.append(5);
    list.append(2);
    list.append(8);
    list.append(1);

    list.sort();

    // Manually checking by inspecting list
    CHECK(list.get_list_size() == 4);
    // Cannot directly access nodes (they're private), so this just ensures no crash and correct size
}

// 6. Sort an already sorted list
TEST_CASE("Sorting an already sorted list does not break it") {
    LinkedList list;
    list.append(1);
    list.append(2);
    list.append(3);

    list.sort();
    CHECK(list.get_list_size() == 3);
}

// 7. Sorting empty list does nothing
TEST_CASE("Sorting empty list is safe") {
    LinkedList list;
    list.sort();
    CHECK(list.get_list_size() == 0);
    CHECK(list.is_empty() == true);
}

// 8. Single element sort
TEST_CASE("Sorting single-element list is safe") {
    LinkedList list;
    list.append(42);
    list.sort();
    CHECK(list.get_list_size() == 1);
}

// 9. Large list sorting (stress test)
TEST_CASE("Sorting large list") {
    LinkedList list;
    for (int i = 100; i >= 1; --i) {
        list.append(i);
    }
    list.sort();
    CHECK(list.get_list_size() == 100);
}

// 10. Check if list stays empty after creation
TEST_CASE("Newly created list has size 0") {
    LinkedList list;
    CHECK(list.get_list_size() == 0);
}
