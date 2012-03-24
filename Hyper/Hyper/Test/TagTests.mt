(* Mathematica Test File *)

(* make sure all tags map to xml elements *)
Map[
	Test[
		Head[
			Evaluate[Symbol[#]]["content"]
		],
		XMLElement,
		TestID -> # ~~ "-single-argument-" ~~ ToString[Unique[]]
	] &,
	TAGS
]

(* test html tag override *)
Test[
	ExportString[
		html["content"],
		"XML"
	],
	"<html xmlns='http://www.w3.org/1999/xhtml'>content</html>",
	TestID -> "html-single-argument-1"
]

Test[
	ExportString[
		html[],
		"XML"
	],
	"<html xmlns='http://www.w3.org/1999/xhtml' />",
	TestID -> "html-zero-argument-1"
]


(* test simple document generation *)
Test[
	Head[
		XHtmlDoc[
			html[
				head[
					title["Simple Document"]
				],
				body[
					p["Simple Test Document"]
				]
			]
		]
	],
	XMLObject["Document"]
	,
	TestID -> "simple-doc-1"
]

Test[
	HyperGen[
		XHtmlDoc[
			html[
				head[
					title["Simple Document"]
				],
				body[
					p["Simple Test Document"]
				]
			]
		]
	],
	ExportString[
		XHtmlDoc[
			html[
				head[
					title["Simple Document"]
				],
				body[
					p["Simple Test Document"]
				]
			]
		],
		"XML"
	],
	TestID -> "hypergen-simple-doc-1"
]