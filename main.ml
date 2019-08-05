let json_of_tm tm =
     Ezjsonm.dict
       [ "tm_sec", (Ezjsonm.string (string_of_int tm.Unix.tm_sec));
         "tm_min", (Ezjsonm.string (string_of_int tm.Unix.tm_min));
         "tm_hour", (Ezjsonm.string (string_of_int tm.Unix.tm_hour));
         "tm_mday", (Ezjsonm.string (string_of_int tm.Unix.tm_mday));
         "tm_mon", (Ezjsonm.string (string_of_int tm.Unix.tm_mon));
         "tm_year", (Ezjsonm.string (string_of_int tm.Unix.tm_year))]
                  
let epoch_time_of_string epoch_time =
  match epoch_time with
  | Some x ->
     begin
       let localtm = Unix.localtime x in
       let (_, tm) = Unix.mktime localtm in
       json_of_tm tm
     end
  | None ->
     begin
       let localtm = Unix.localtime (Unix.time ()) in
       let (_, tm) = Unix.mktime localtm in
       json_of_tm tm
     end

let print_time_formatted = Opium.Std.get "/time/:seconds_since_epoch" (fun req ->                                                            `Json (epoch_time_of_string ((Opium.Std.param req "seconds_since_epoch") |> float_of_string_opt)) |> Opium.Std.respond'
                             )

let _ =
  Opium.Std.App.empty
  |> print_time_formatted
  |> Opium.Std.App.run_command
