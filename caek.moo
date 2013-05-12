
@create $thing called Dreyannah's Birthday Cake
@addalias cake, caek, slice to Dreyannah's Birthday Cake

@describe caek as "Dreyannah's birthday cake. It's mostly chocolate. And incredibly delicious."

@verb caek:eat this none none rxd
@program caek:eat
$you:say_action("%N %<eats> some of %p slice of Dreyannah's birthday cake.");
.

@verb caek:serve this to any rxd
@program caek:serve
$you:say_action("%N %<hands> %i a slice of Dreyannah's birthday cake.");
.
