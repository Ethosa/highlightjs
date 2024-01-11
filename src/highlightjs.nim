## # Highlight.js
## 
## [highlight.js](https://highlightjs.org/) for Nim
## 
when not defined(js):
  {.error: "This library works only with JS backend".}


import
  dom,
  jsffi

when not defined(no_i_hljs):
  import highlightjs/private/fetch_lib


type
  HighlightJs* = JsObject
  HighlightResult* = object of JsObject
    language*: cstring
    relevance*: int
    value*: cstring
    code*: cstring
    illegal*: bool


var hljs* {.importc, nodecl.}: HighlightJs


using
  self: HighlightJs


proc highlight*(self; code: cstring, language: cstring = "nim", ignoreIllegals: bool = false): HighlightResult {.importjs: """#.highlight(#, {
  language: #,
  ignoreIllegals: #
})""".}
 ## Core highlighting function. Accepts the code to highlight (string) and a list of options (object).
 ## The `language` parameter must be present and specify the language name or alias of the grammar to be used for highlighting.
 ## The `ignoreIllegals` is an optional parameter that when `true` forces highlighting to finish even in case of detecting illegal syntax for the language instead of throwing an exception.
 ## 
 ## Returns an object with the following properties:
 ## - `language`: language name, same as the name passed in `languageName`, returned for consistency with `highlightAuto`
 ## - `relevance`: integer value representing the relevance score
 ## - `value`: HTML string with highlighting markup
 ## - `top`: top of the current mode stack
 ## - `illegal`: boolean representing whether any illegal matches were found
 ## - `code`: the original raw code
 ## 


proc highlightElement*(self; elem: Element) {.importjs: "#.highlightElement(#)".}
  ## Applies highlighting to a DOM node containing code.
  ## This function is the one to use to apply highlighting dynamically after page load or within initialization code of third-party JavaScript frameworks.
  ## The function uses language detection by default but you can specify the language in the `class` attribute of the DOM node.
  ## See the scopes reference for all available language names and scopes.
  ## 

proc highlightAll*(self) {.importjs: "#.highlightAll()" .}
  ## Applies highlighting to all elements on a page matching the configured `cssSelector`.
  ## The default `cssSelector` value is `"pre code"`, which highlights all code blocks.
  ## This can be called before or after the page’s `onload` event has fired.
  ## 


proc newInstance*(self): HighlightJs {.importjs: "#.newInstance()".}
  ## Returns a new instance of the highlighter with default configuration.
  ## 


proc configure*(
  self;
  classPrefix: cstring = "",
  cssSelector: cstring = "pre code",
  ignoreUnescapedHTML: bool = true,
  throwUnescapedHTML: bool = false,
) {.importjs: """#.configure({
  classPrefix: #,
  cssSelector: #,
  ignoreUnescapedHTML: #,
  throwUnescapedHTML: #,
})""".}
  ## Configures global options:
  ## - `classPrefix`: a string prefix added before class names in the generated markup, used for backwards compatibility with stylesheets.
  ## - `languages`: an array of language names and aliases restricting auto detection to only these languages.
  ## - `languageDetectRe`: a regex to configure how CSS class names map to language (allows class names like say color-as-php vs the default of language-php, etc.)
  ## - `noHighlightRe`: a regex to configure which CSS classes are to be skipped completely.
  ## - `cssSelector`: a CSS selector to configure which elements are affected by hljs.highlightAll. Defaults to 'pre code'.
  ## - `ignoreUnescapedHTML`: do not log warnings to console about unescaped HTML in code blocks
  ## - `throwUnescapedHTML`: throw a HTMLInjectionError when highlightElement is asked to highlight content that includes unescaped HTML
  ## 
  ## Accepts an object representing options with the values to updated. Other options don’t change
  ## 
  ## ```nim
  ## hljs.configure(
  ##   classPrefix = ""
  ## )
  ## ```


proc debugMode*(self) {.importjs: "#.debugMode()".}
 ## Enables *debug/development* mode.
 ## 
 ## .. Warning ::
 ##    This mode purposely makes Highlight.js more fragile!
 ##    It should only be used for testing and local development (of languages or the library itself).
 ##    
 ## For example, if a new version suddenly had a serious bug (or breaking change) that affected only a single language:
 ## - **In Safe Mode** all other languages would continue to highlight just fine. The broken language would appear as a code block, but without any highlighting (as if it were plaintext).
 ## - **In Debug Mode** all highlighting would stop and a JavaScript error would be thrown.
 ## 
