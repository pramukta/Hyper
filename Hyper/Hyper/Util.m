(* Mathematica Package *)

BeginPackage["Hyper`Util`", {"JLink`"}]
InstallJava[];


(* Exported symbols added here with SymbolName::usage *)  
UrlEncode::usage = "UrlEncode[str] replaces special characters in str with their URL safe versions";
UrlEncode[str_String] := URLEncoder`encode[str];


Begin["`Private`"] (* Begin Private Context *) 
LoadJavaClass["java.net.URLEncoder"];
End[] (* End Private Context *)

EndPackage[]