
open Pratt
open Pratt.Foundation
open Pratt.Lexer
open Pratt.Syntax
open Fold.Lang

(* -- Mini Testing Engine -- *)

let parse_string s =
  let expr = init
      ~lexer:(create_lexer_with_string "Fold.Lang.Tests" s)
      ~grammar:core_lang in
  expr

let (~>) s =
  try
    print ((bright_blue "-> ") ^ s);
    print (" = " ^ Show.expr (parse_string s))
  with Failure msg ->
    print_endline (bright_red " * " ^ bright_white "Error" ^ ": " ^ msg);
    flush stdout

let (~~) s = ()

let (==) s e =
  try
    print_endline (fmt "%s %s" (bright_blue "->") (white s));
    let r = parse_string s in
    let y = r = e in
    let i = if y then (bright_green "✓ ") else (bright_red "✗ ") in
    print_endline (fmt "%s %s %s %s" i (Show.expr r) "::" (red "Expr"));
    if not y then
        (print_endline (fmt "\n  Expected: %s" (Show.expr e));
       print_endline (fmt "    Actual: %s\n" (Show.expr r)))
    else ()
  with Failure msg ->
    print_endline (bright_red " * " ^ bright_white "Error" ^ ": " ^ msg);
    flush stdout

let (~>!) s =
  try
    print_endline (fmt "%s %s" (bright_blue "->") (white s));
    let r = parse_string s in
    let m = bright_red "✗ " in
    print_endline (fmt "%s %s %s %s" m (Show.expr r) "::" (red "exprr"));
    print_endline (bright_red " * " ^ bright_white "Error: Expression Expected to fail.");
  with Failure msg ->
    let m = (bright_green "✓ ") in
    print_endline (fmt "%s %s" m (bright_white ("Expected failure" ^ ": " ^ msg)));
    flush stdout


