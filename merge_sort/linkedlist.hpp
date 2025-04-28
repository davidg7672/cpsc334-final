#ifndef LINKEDLIST_HPP
#define LINKEDLIST_HPP

#include <iostream>

class LinkedList {
private:
    struct Node {
        int data;
        Node* next;
        Node(int val) : data(val), next(nullptr) {}
    };

    Node* head;

    Node* merge(Node* head1, Node* head2);
    void split_list(Node* source, Node** left, Node** right);
    Node* merge_sort(Node* head, int size);

public:
    LinkedList();
    ~LinkedList();

    bool is_empty() const;
    int get_list_size() const;
    void display_list() const;
    void append(int val);
    void sort();
};

#endif // LINKEDLIST_HPP
