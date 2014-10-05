(** Functions imported from the Coq library. *)

let dirsep = Filename.dir_sep (* Unix: "/" *)
let dirsep_len = String.length dirsep
let curdir = Filename.concat Filename.current_dir_name "" (* Unix: "./" *)
let curdir_len = String.length curdir

(** cut path [p] after all the [/] that come at position [pos]. *)
let rec cut_after_dirsep p pos =
  if CString.is_sub dirsep p pos then
    cut_after_dirsep p (pos + dirsep_len)
  else
    String.sub p pos (String.length p - pos)

(** remove all initial "./" in a path *)
let rec remove_path_dot p =
  if CString.is_sub curdir p 0 then
    remove_path_dot (cut_after_dirsep p curdir_len)
  else
    p

(** If a path [p] starts with the current directory $PWD then
    [strip_path p] returns the sub-path relative to $PWD.
    Any leading "./" are also removed from the result. *)
let strip_path p =
  let cwd = Filename.concat (Sys.getcwd ()) "" in (* Unix: "`pwd`/" *)
  if CString.is_sub cwd p 0 then
    remove_path_dot (cut_after_dirsep p (String.length cwd))
  else
    remove_path_dot p

let canonical_path_name p =
  let current = Sys.getcwd () in
  try
    Sys.chdir p;
    let p' = Sys.getcwd () in
    Sys.chdir current;
    p'
  with Sys_error _ ->
    (* We give up to find a canonical name and just simplify it... *)
    strip_path p

let correct_path f dir =
  if Filename.is_relative f then Filename.concat dir f else f