import
  dom,
  macros,
  strutils


const
  hljs_langs {.strdefine.} = "nim,json"
  hljsv {.strdefine.} = "11.9.0"
  hljs_theme {.strdefine.} = "default"


proc emitJs(code: string): NimNode {.compileTime.} =
  newNimNode(nnkPragma).add(
    newNimNode(nnkExprColonExpr).add(
      ident"emit",
      newLit(code.replace("`", "``").replace("\n", ""))
    )
  )


proc fetchFromUrl(url: string): string {.compileTime.} =
  let data = gorgeEx("curl -N -s " & url)
  return data.output


macro fetch() =
  var cssData = fetchFromUrl(
    "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/" & hljsv & "/styles/" & hljs_theme & ".min.css"
  )
  var mainJsData = fetchFromUrl(
    "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@" & hljsv & "/build/highlight.min.js"
  )

  result = newStmtList(
    newCall(
      "&=",
      newDotExpr(
        newDotExpr(ident"document", ident"head"),
        ident"innerHTML"
      ),
      newLit("<style>" & cssData & "</style>")
    ),
    emitJs(mainJsData)
  )
  for lang in hljs_langs.split(","):
    var data = fetchFromUrl(
      "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/" & hljsv & "/languages/" & lang.strip() & ".min.js"
    )
    result.add(emitJs(data))

fetch()
