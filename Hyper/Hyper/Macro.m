(* Mathematica Package *)

BeginPackage["Hyper`Macro`", {"Hyper`", "Hyper`Util`", "Hyper`Graphics`"}]
(* Exported symbols added here with SymbolName::usage *)  
Img[src_String] := img[{"src" -> src}, EMPTY];
Img[g_Graphics] := img[{"src" -> Evaluate[Render[g]]}, EMPTY];

Begin["`Private`"] (* Begin Private Context *) 

End[] (* End Private Context *)

EndPackage[]