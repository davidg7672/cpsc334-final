from linkedlist import LinkedList

def main():
    ll = LinkedList()

    # Add some unsorted values
    ll.append(5)
    ll.append(1)
    ll.append(8)
    ll.append(3)

    print("Before sorting:")
    print(ll.display_list())

    # Sort the linked list
    ll.sort()

    print("After sorting:")
    print(ll.display_list())

if __name__ == "__main__":
    main()
