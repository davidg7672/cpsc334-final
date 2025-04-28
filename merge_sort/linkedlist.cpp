#include "linkedlist.hpp"

LinkedList::LinkedList() : head(nullptr) {}

LinkedList::~LinkedList() {
    Node* current = head;
    while (current != nullptr) {
        Node* temp = current;
        current = current->next;
        delete temp;
    }
}

bool LinkedList::is_empty() const {
    return head == nullptr;
}

int LinkedList::get_list_size() const {
    int counter = 0;
    Node* current = head;
    while (current != nullptr) {
        current = current->next;
        counter++;
    }
    return counter;
}

void LinkedList::display_list() const {
    Node* temp = head;
    std::cout << "head->";
    while (temp != nullptr) {
        std::cout << temp->data << "->";
        temp = temp->next;
    }
    std::cout << "null" << std::endl;
}

void LinkedList::append(int val) {
    Node* new_node = new Node(val);

    if (head == nullptr) {
        head = new_node;
    } else {
        Node* current = head;
        while (current->next != nullptr) {
            current = current->next;
        }
        current->next = new_node;
    }
}

void LinkedList::split_list(Node* source, Node** left, Node** right) {
    Node* slow = source;
    Node* fast = source->next;

    while (fast != nullptr && fast->next != nullptr) {
        slow = slow->next;
        fast = fast->next->next;
    }

    *left = source;
    *right = slow->next;
    slow->next = nullptr;
}

LinkedList::Node* LinkedList::merge(Node* head1, Node* head2) {
    if (head1 == nullptr) return head2;
    if (head2 == nullptr) return head1;

    Node* new_head = nullptr;

    if (head1->data < head2->data) {
        new_head = head1;
        new_head->next = merge(head1->next, head2);
    } else {
        new_head = head2;
        new_head->next = merge(head1, head2->next);
    }

    return new_head;
}

LinkedList::Node* LinkedList::merge_sort(Node* node, int size) {
    if (node == nullptr || node->next == nullptr) {
        return node;
    }

    Node* left = nullptr;
    Node* right = nullptr;

    split_list(node, &left, &right);

    int left_size = size / 2;
    int right_size = size - left_size;

    left = merge_sort(left, left_size);
    right = merge_sort(right, right_size);

    return merge(left, right);
}

void LinkedList::sort() {
    int size = get_list_size();
    head = merge_sort(head, size);
}
