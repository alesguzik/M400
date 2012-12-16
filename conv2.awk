BEGIN {
    print "let world = [|"; x=0 }
/layer/ {
  y=0;
  if(x==0){
    print "  [|";
  } else {
    print "  |];\n  [|";
  }
  x+=1;
}
/^[= ]+$/ {
  gsub("= ","T;");
  gsub("  ","F;");
  gsub("  ","F;");
  print "    [|" $0 "|];";
}
END {
    print "  |]\n|];;\n";
}
