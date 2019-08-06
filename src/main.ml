let json_of_tm tm =
     Ezjsonm.dict
       [ "tm_sec", (Ezjsonm.int tm.Unix.tm_sec);
         "tm_min", (Ezjsonm.int tm.Unix.tm_min);
         "tm_hour", (Ezjsonm.int tm.Unix.tm_hour);
         "tm_mday", (Ezjsonm.int tm.Unix.tm_mday);
         "tm_mon", (Ezjsonm.int tm.Unix.tm_mon);
         "tm_year", (Ezjsonm.int tm.Unix.tm_year)]
                  
let epoch_time_of_string epoch_time =
  let localtm =
    match epoch_time with
    | Some x ->
       Unix.localtime x
    | None ->
       Unix.localtime (Unix.time ())
  in
  let (_, tm) = Unix.mktime localtm in
  json_of_tm tm

let print_time_formatted = Opium.Std.get "/time/:seconds_since_epoch" (fun req ->                                                            `Json (epoch_time_of_string ((Opium.Std.param req "seconds_since_epoch") |> float_of_string_opt)) |> Opium.Std.respond'
                             )

let _ =
  Opium.Std.App.empty
  |> print_time_formatted
  |> Opium.Std.App.run_command
