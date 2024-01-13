<div align="center">

# highlightjs.nim

#### [highlight.js](https://highlightjs.org/) for Nim
#### [API Reference](https://ethosa.github.io/highlightjs/highlightjs.html)

</div>


## Features

- automatic including library in your HTML (disables with `-d:no_i_hljs`)


## Flags
| Flag                                 | Description                                  | Default     |
| :--                                  | :--                                          | :--:        |
| `-d:hljsv="11.9.0"`                  | Choose other highlight.js version            | `"11.9.0"`  |
| `-d:hljs_theme="tokyo-night-dark"`   | Choose highlight.js theme                    | `"default"` |
| `-d:hljs_langs="nim,json,go,python"` | Choose additional languages separated by "," | `"nim"`     |
| `-d:no_i_hljs`                       | Disable automatic including cdn library      | `false`     |
