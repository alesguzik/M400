/Find/ {
    sub(/^Find a path between /, "");
    sub(/ and /,             " -> ");
    sub(/:/,                   "");
    print $0;
  }
