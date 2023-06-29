$Regex_Pattern = '\S\S\s\S\S\s\S\S';

$Test_String = <STDIN> ;
if($Test_String =~ /$Regex_Pattern/){
    print "true";
} else {
    print "false";
}