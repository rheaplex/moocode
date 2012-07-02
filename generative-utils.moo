;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"-----------------------------------------------------------------------------"

@create $generic_utils called "Generative Utilities"
@addalias generative_utils to "Generative Utilities"

@verb generative_utils:choose_one tnt rxd
@program generative_utils:choose_one
"Choose one item from a list. From Yib's book p141";
the_list = args[1];
index = random(length(the_list));
return the_list[index];
.

@verb generative_utils:choose_n tnt rxd
@program generative_utils:choose_n
"Choose n items from a list. Slowly.";
{the_list, n} = args;
shuffled_list = $list_utils:randomly_permute(the_list);
return shuffled_list[1..n];
.

@verb generative_utils:maybe tnt rxd
@program generative_utils:maybe
"Call o:(verb)() 1/probability of the time";
{object, verb, ?prob = 2, ?default = #-1} = args;
if (random(prob) == 1)
  result = object:(verb)();
else
  result = default;
endif
return result;
.

@verb generative_utils:maybe_choose_one tnt rxd
@program generative_utils:maybe_choose_one
"Choose one item from the list, or not";
{the_list, ?prob = 2, ?default = #-1} = args;
if(random(prob) == 1)
  result = this:choose_one(the_list);
else
  result = default;
endif
return result;
.

@verb generative_utils:maybe_choose_n tnt rxd
@program generative_utils:maybe_choose_n
"Choose n objects from list probability of the time.";
{the_list, n, ?prob = 2, ?default = #-1} = args;
if(random(prob) == 1)
  result = this:choose_n(the_list, n);
else
  result = default;
endif
return result;
.

@verb generative_utils:cycle tnt rxd
@program generative_utils:cycle
"Cycle through the elements of a list on an object";
{object, source, current_index} = args;
if (object.(current_index) > length(object.(source)))
  object.(current_index) = 1;
endif
result = object.(source)[object.(current_index)];
object.(current_index) = object.(current_index) + 1;
return result;
.

@verb generative_utils:cycle_random tnt rxd
@program generative_utils:cycle_random
"Randomly cycle through the elements of a list on an object";
{object, source, state} = args;
if (object.(state) == {})
  "Use a permuted copy of the source list to keep stable between calls";
  object.(state) = $list_utils:randomly_permute(object.(source));
endif
result = object.(state)[1];
object.(state) = listdelete(object.(state), 1);
return result;
.

@edit generative_utils.help_msg
delete
enter
Utilities for generating random respnses and descriptions.
choose_one        (list)
  => one item chosen randomly from list
choose_n          (list, n)
  => n random items (chosen slowly) from list, n must be <= length(list)
maybe             (function[ ,probability[, default]]) 
  => the result of calling function 1/probability of the time, otherwise default
     probability defaults to 2, default defaults to #-1
maybe_choose_one  (list[, probability[, default]]) 
  => a random item from the list 1/probability of the time, else default
     probability defaults to 2, default defaults to #-1
maybe_choose_n    (list, n[ ,probability[, default]]) 
  => a random item from the list 1/probability of the time, else default
     probability defaults to 2, default defaults to {}
cycle             (object, source, current_index)
  => object.source[object.current_index], incrementing and looping current_index
cycle_random      (object, source, state)
  => object.state[1], deleting object.state[1]
     when object.state == {}, object.state is reset to a shuffled copy of the
     list object.source
.
save
