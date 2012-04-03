(* Mathematica Package *)

BeginPackage["Hyper`Graphics`"]
(* Exported symbols added here with SymbolName::usage *)  

Render[anything_, format_String : "PNG"] := 
	Module[{filename = TempFileFor[anything, format /. FileExtensions]},
		Export[filename, Evaluate[anything], format];
		Return[filename]
	];


SetAttribute[TempFileFor, HoldFirst];
Begin["`Private`"] (* Begin Private Context *)
TempFileFor[expression_, extension_String : ".file"] := 
	Module[{out = OpenWrite[], basefilename},
		basefilename = Part[out, 1];
		Write[out, ToString[expression]]; Close[out];
		Return[basefilename <> extension];
	];

FileExtensions = {"PNG" -> ".png", "JPEG" -> ".jpg", "GIF" -> ".gif", "BMP" -> ".bmp", "SVG" -> ".svg"};

End[] (* End Private Context *)

EndPackage[]