import
  dom,
  highlightjs


hljs.highlightAll()

var hljsRes = hljs.highlight("echo 1", "nim")
echo hljsRes.value
echo hljsRes
