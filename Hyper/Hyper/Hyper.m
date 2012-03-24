(* Mathematica Package *)

(* Created by the Wolfram Workbench Mar 24, 2012 *)

BeginPackage["Hyper`"]
(* Exported symbols added here with SymbolName::usage *) 

XHtmlStrict = XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Strict//EN", "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"];
XHtmlTransitional = XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Transitional//EN", "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"];
XHtmlFrameset = XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.0 Frameset//EN", "System" -> "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"];
XHtml11Strict = XMLObject["Doctype"]["html", "Public" -> "-//W3C//DTD XHTML 1.1//EN", "System" -> "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"];

XHtmlDoc[type_, root_XMLElement] := 
	XMLObject["Document"][{
		XMLObject["Declaration"]["Version" -> "1.0", "Encoding" -> "UTF-8"],
		type},
		root,
		{}
	];
XHtmlDoc[root_XMLElement] := XHtmlDoc[XHtmlStrict, root];

TAGS = {"a", "abbr", "acronym", "address", "applet", "area", "b", "base", "basefont", "bdo", "big", "blockquote",
	"body", "br", "button", "caption", "center", "cite", "code", "col", "colgroup", "dd", "del", "dfn", "dir",
	"div", "dl", "dt", "em", "fieldset", "font", "form", "frame", "frameset", "head", "h1", "h2", "h3", "h4",
	"h5", "h6", "hr", "html", "i", "iframe", "img", "input", "ins", "kbd", "label", "legend", "li", "link", "map",
	"menu", "meta", "noframes", "noscript", "object", "ol", "optgroup", "option", "p", "param", "pre", "q",
	"s", "samp", "script", "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody",
	"td", "textarea", "tfoot", "th", "thead", "title", "tr", "tt", "u", "ul", "var"};
	
(* dynamically create generic functions for all tags *)
Map[
	SetDelayed[
		Evaluate[Symbol[#]][attrib_List, elements___],
		XMLElement[#, attrib, Flatten @ List @ elements]
	] &, 
	TAGS
];

(* dynamically create single argument functions for all tags *)
Map[
	SetDelayed[
		Evaluate[Symbol[#]][elements___],
		XMLElement[#, {}, Flatten @ List @ elements]
	] &, 
	TAGS
];

(* override specific tags with more specific functionality *)
html[elements___] := html[{"xmlns" -> "http://www.w3.org/1999/xhtml"}, elements];



(* basic generation functions *)
HyperGen[doc_] := 
	If[HValidQ[doc],
		ExportString[doc,"XML"],
		EmptyDoc
	];


(* validation functions *)
HValidQ[doc_] := Head[doc] === XMLObject["Document"];

Begin["`Private`"]
(* Implementation of the package *)
TAGS = {"a", "abbr", "acronym", "address", "applet", "area", "b", "base", "basefont", "bdo", "big", "blockquote",
	"body", "br", "button", "caption", "center", "cite", "code", "col", "colgroup", "dd", "del", "dfn", "dir",
	"div", "dl", "dt", "em", "fieldset", "font", "form", "frame", "frameset", "head", "h1", "h2", "h3", "h4",
	"h5", "h6", "hr", "html", "i", "iframe", "img", "input", "ins", "kbd", "label", "legend", "li", "link", "map",
	"menu", "meta", "noframes", "noscript", "object", "ol", "optgroup", "option", "p", "param", "pre", "q",
	"s", "samp", "script", "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody",
	"td", "textarea", "tfoot", "th", "thead", "title", "tr", "tt", "u", "ul", "var"};


End[]

EndPackage[]

