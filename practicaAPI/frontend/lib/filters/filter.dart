abstract class Filter {
  Filter? next;

  Filter linkWith(Filter nextFilter) {
    next = nextFilter;
    return nextFilter;
  }

  bool check(String email, String password);
}
