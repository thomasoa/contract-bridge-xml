use Math::BigFloat;

$value = new Math::BigFloat("14.13472514173469379045725198356247027078");

$count = $ARGV[0];

$lastp = 0; $p = 1;
$lastq = 1; $q = 0;
$one = new Math::BigFloat(1);
while ($count-->0) {
    $a = new Math::BigFloat($value->copy()->bfloor);
    $a = int($value);
    $value = $one/($value-$a);
    $newp = $a*$p+$lastp;
    $newq = $a*$q+$lastq;
    ($lastp,$lastq)=($p,$q);
    ($p,$q) = ($newp,$newq);
    printf "%5d %10d %10d\n",$a,$p,$q,"\n";
}


