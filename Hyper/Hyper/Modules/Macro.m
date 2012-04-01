Begin["`M`"]

Img[url_String, alt_String : ""] := img[{"src" -> url, "alt" -> alt}];
LinkTo[url_String, content__] := a[{"href" -> url}, content];
MailTo[addr_String, content__] := a[{"href" -> "mailto:" <> addr}, content];
OrderedList[elements_List] := ol @@ li /@ elements;
UnorderedList[elements_List] := ul @@ li /@ elements;

End[]