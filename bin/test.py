import unittest
from linkedlist import LinkedList

class TestLinkedList(unittest.TestCase):
    def test_empty_list(self):
        ll = LinkedList()
        self.assertTrue(ll.is_empty())
        self.assertEqual(ll.get_list_size(), 0)

    def test_append_single_element(self):
        ll = LinkedList()
        ll.append(10)
        self.assertFalse(ll.is_empty())
        self.assertEqual(ll.get_list_size(), 1)

    def test_append_multiple_elements(self):
        ll = LinkedList()
        ll.append(1)
        ll.append(2)
        ll.append(3)
        self.assertEqual(ll.get_list_size(), 3)

    def test_display_list(self):
        ll = LinkedList()
        ll.append(5)
        ll.append(10)
        ll.append(15)
        self.assertEqual(ll.display_list(), "head->5->10->15->null")

    def test_sort_unsorted_list(self):
        ll = LinkedList()
        ll.append(3)
        ll.append(1)
        ll.append(2)
        ll.sort()
        self.assertEqual(ll.display_list(), "head->1->2->3->null")

    def test_sort_sorted_list(self):
        ll = LinkedList()
        ll.append(1)
        ll.append(2)
        ll.append(3)
        ll.sort()
        self.assertEqual(ll.display_list(), "head->1->2->3->null")

    def test_sort_reverse_list(self):
        ll = LinkedList()
        ll.append(5)
        ll.append(4)
        ll.append(3)
        ll.append(2)
        ll.append(1)
        ll.sort()
        self.assertEqual(ll.display_list(), "head->1->2->3->4->5->null")

    def test_sort_single_element_list(self):
        ll = LinkedList()
        ll.append(42)
        ll.sort()
        self.assertEqual(ll.display_list(), "head->42->null")

    def test_sort_empty_list(self):
        ll = LinkedList()
        ll.sort()
        self.assertTrue(ll.is_empty())

    def test_large_list_sort(self):
        ll = LinkedList()
        for i in range(100, 0, -1):
            ll.append(i)
        ll.sort()

        # Check first 5 elements manually
        current = ll.head
        for expected_value in range(1, 6):
            self.assertEqual(current.data, expected_value)
            current = current.next

if __name__ == "__main__":
    unittest.main()
