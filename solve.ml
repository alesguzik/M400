world.(x1).(y1).(z1) <- Step(0);;

let rec next_generation cur_surface new_distance w =
  let new_surface = ref [] in
  let try_set x y z =
    match w.(x).(y).(z) with
        F -> begin
          w.(x).(y).(z) <- Step(new_distance);
          new_surface := Coord(x,y,z) :: !new_surface;
        end
      | _ -> () in
  List.iter (fun coord ->
    match coord with
        Coord(x,y,z) ->
          begin
            if x > 0  then try_set (x-1) y z;
            if x < 49 then try_set (x+1) y z;
            if y > 0  then try_set x (y-1) z;
            if y < 49 then try_set x (y+1) z;
            if z > 0  then try_set x y (z-1);
            if z < 49 then try_set x y (z+1);
          end) cur_surface;
  if w.(x2).(y2).(z2) != F or !new_surface == []
  then w
  else next_generation !new_surface (new_distance+1) w;;

let rec get_route waypoints cur_step w =
  if cur_step==0 then waypoints else
    match waypoints with
      Coord(x,y,z)::xs ->
          let next_step = (cur_step-1) in
          if      x > 0  && (match w.(x-1).(y).(z) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x-1,y,z)::waypoints) next_step w
          else if x < 49 && (match w.(x+1).(y).(z) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x+1,y,z)::waypoints) next_step w
          else if y > 0  && (match w.(x).(y-1).(z) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x,y-1,z)::waypoints) next_step w
          else if y < 49 && (match w.(x).(y+1).(z) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x,y+1,z)::waypoints) next_step w
          else if z > 0  && (match w.(x).(y).(z-1) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x,y,z-1)::waypoints) next_step w
          else if z < 49 && (match w.(x).(y).(z+1) with Step(v) -> v | _ -> -1) == next_step then get_route (Coord(x,y,z+1)::waypoints) next_step w
          else waypoints;;

let rec print_result list =
  match list with
      [] -> ()
    | Coord(x,y,z)::xs -> print_string ("(" ^ (string_of_int x) ^ "," ^ (string_of_int y) ^ "," ^ (string_of_int z) ^ ")");print_result xs;;

let do_it () =
  let w = next_generation [Coord(x1,y1,z1)] 1 world in
  let end_step = match w.(x2).(y2).(z2) with
      Step(v) -> v
    | T -> 0
    | F -> 0 in
  print_result(get_route [Coord(x2,y2,z2)] end_step w);;

do_it ();;
