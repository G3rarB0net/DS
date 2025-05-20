abstract class Filter {
  Filter? next;

  Filter linkWith(Filter nextFilter) {
    next = nextFilter;
    return nextFilter;
  }

  String? check(String email, String password);
}
