(* Mathematica Package *)

(* Created by the Wolfram Workbench Mar 24, 2012 *)

BeginPackage["Hyper`"]
(* Exported symbols added here with SymbolName::usage *) 

XHtmlStrict[lang_String : "EN"] := XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Strict//" ~~ lang, "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"];
XHtmlTransitional[lang_String : "EN"] := XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Transitional//" ~~ lang, "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"];
XHtmlFrameset[lang_String : "EN"] := XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Frameset//" ~~ lang, "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"];
XHtml11Strict[lang_String : "EN"] := XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.1//" ~~ lang, "System" -> "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"];

TAGS = {"a", "abbr", "acronym", "address", "applet", "area", "b", "base", "basefont", "bdo", "big", "blockquote",
	"body", "br", "button", "caption", "center", "cite", "code", "col", "colgroup", "dd", "del", "dfn", "dir",
	"div", "dl", "dt", "em", "fieldset", "font", "form", "frame", "frameset", "head", "h1", "h2", "h3", "h4",
	"h5", "h6", "hr", "html", "i", "iframe", "img", "input", "ins", "kbd", "label", "legend", "li", "link", "map",
	"menu", "meta", "noframes", "noscript", "object", "ol", "optgroup", "option", "p", "param", "pre", "q",
	"s", "samp", "script", "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody",
	"td", "textarea", "tfoot", "th", "thead", "title", "tr", "tt", "u", "ul", "var"};
EMPTY = "";

(* In case they are defined elsewhere, suspend evaluation of HTML tag symbols *)
Map[SetAttributes[Evaluate[Symbol[#]], HoldAll] &, TAGS];

(* Build an initial set of empty tag attribute defaults *)
Map[Set[TAGDEFAULTS[Evaluate[Symbol[#]]], {}] &, TAGS];

TAGDEFAULTS[html] = {"xmlns" -> "http://www.w3.org/1999/xhtml"};
TAGDEFAULTS[img] = {"src" -> Unevaluated[GenSym[]]};

(* H builds a symbolic XML tree out of the Mathematica syntax tree *)
H[element_String] := element;
H[element_Graphics] := Module[{filename = Unique["img"] <> ".png"},
	Export[filename, element]; 
	Return[
		H[img[{"src" -> filename}, ""]]
	]
];
H[element_] := Module[{hasAttributes = Head[element[[1]]] === List},
	XMLElement[SymbolName[Head[element]],
    	If[hasAttributes, DeleteEmptyRules @ MergeRules[element[[1]], TAGDEFAULTS[Head[element]]], TAGDEFAULTS[Head[element]]],
    	If[hasAttributes, Map[H, List @@ element[[2 ;;]]], 
     	List @@ Map[H, element[[1 ;;]]]]
    	]
   	];
(* wrap in an XML symbolic document *)
W[doc_, type_ : XHtmlStrict[]] := XMLObject["Document"][
		{
			XMLObject["Declaration"]["Version" -> "1.0", "Encoding" -> "UTF-8"],
			type
		},
		doc,
		{}
	];
(* textify *)
T[doc_] := ExportString[doc, "XML"];
(* shortcuts *)
TH[doc_] := T @ H[doc];
TWH[doc_] := T @ W @ H[doc];

Begin["`Private`"]
(* Implementation of the package *)
MergeRules[rules_List, default_List] :=
	DeleteDuplicates[
 		Join[rules, default], (* order matters *)
 		First[#1] === First[#2] &
 	];	

DeleteEmptyRules[rules_List] := 
	DeleteCases[rules, Part[#, 2] == EMPTY &];

End[]

EndPackage[]

