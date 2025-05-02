class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None

    def is_empty(self):
        return self.head is None

    def get_list_size(self):
        count = 0
        current = self.head
        while current:
            count += 1
            current = current.next
        return count

    def append(self, value):
        new_node = Node(value)
        if self.is_empty():
            self.head = new_node
            return
        current = self.head
        while current.next:
            current = current.next
        current.next = new_node

    def display_list(self):
        current = self.head
        elements = []
        while current:
            elements.append(str(current.data))
            current = current.next
        return "head->" + "->".join(elements) + "->null"

    def split_list(self, source):
        if source is None or source.next is None:
            return source, None
        slow = source
        fast = source.next
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
        mid = slow.next
        slow.next = None
        return source, mid

    def merge(self, left, right):
        if not left:
            return right
        if not right:
            return left

        if left.data < right.data:
            result = left
            result.next = self.merge(left.next, right)
        else:
            result = right
            result.next = self.merge(left, right.next)
        return result

    def merge_sort(self, node):
        if node is None or node.next is None:
            return node

        left, right = self.split_list(node)
        left = self.merge_sort(left)
        right = self.merge_sort(right)

        return self.merge(left, right)

    def sort(self):
        self.head = self.merge_sort(self.head)
