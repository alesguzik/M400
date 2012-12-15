BEGIN {
    print "type cell = F | T | Step of int ;;";
    print "type coord = Coord of int * int * int ;;";
}
/Find/ {
    sub(/^Find a path between \(/, "let x1 = ");
    sub(", ",                    " and y1 = ");
    sub(", ",                    " and z1 = ");
    sub(/\) and \(/,             " and x2 = ");
    sub(", ",                    " and y2 = ");
    sub(", ",                    " and z2 = ");
    sub(/\):/,                   ";;");
    print $0;
  }
