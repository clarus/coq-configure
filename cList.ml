(** Functions imported from the Coq library. *)

let fold_left_i f =
  let rec it_list_f i a = function
    | [] -> a
    | b::l -> it_list_f (i+1) (f i a b) l
  in
  it_list_f

let rec map_filter f = function
  | [] -> []
  | x::l ->
      let l' = map_filter f l in
      match f x with None -> l' | Some y -> y::l'