include karax / prelude
import karax / [jjson, kajax, vstyles], std / [dom, random]

type
  Quote = ref object
    text, author: cstring

template `^`(s: string): cstring = cstring(s)

let quotes = @[
  Quote(text: "One thing i know, that i know nothing. This is the source of my wisdom.", author: "Socrates"),
  Quote(text: "Love is composed of a single soul inhabiting two bodies.", author: "Socrates"),
  Quote(text: "There is nothing permanent except change.", author: "Socrates"),
  Quote(text: "I am indebted to my father for living, but to my teacher for living well.", author: "Plutarch"),
  Quote(text: "He who steals a little steals with the same wish as he who steals much, but with less power.", author: "Epicurus"),
  Quote(text: "Let no man be called happy before his death. Till then, he is not happy, only lucky.", author: "Xenophon"),
  Quote(text: "By all means, get married: if you find a good wife, you'll be happy; if not, you'll become a philosopher.", author: "Demosthenes"),
  Quote(text: "Small opportunities are often the beginning of great enterprises.", author: "Pericles")
]

var
  current = quotes.sample()

proc createDom(): VNode =
  result = buildHtml:
    tdiv(class = "flex flex-col items-center justify-center min-h-screen p-10 bg-blurred bg-center"):
      h1(class = "font-light text-2xl md:text-4xl text-gray-600 mb-8 md:mb-12"):
        text ^"Ancient Wisdom"
      tdiv(class = "relative w-full md:w-3/4 lg:w-1/2"):
        tdiv(class = "flex card"):
          img(src = "img/portrait.jpg", width = "512", class = "object-cover h-auto w-1/2", alt = "", height = "512")
          tdiv(class = "p-4 w-1/2"):
            span(class = "font-semibold italic text-base text-gray-600"):
              text ^"“" & current.text & ^"”"
            span(class = "block text-lg font-light text-gray-400"):
              text ^"— " & current.author
        tdiv(class = "flex justify-center mt-4 md:mt-8 md:absolute md:right-0"):
          button(class = "btn"):
            var laziness = false
            proc onClick() =
              if not laziness:
                laziness = true
                current = quotes.sample()
                discard setTimeout(proc () = laziness = false, 500)
            text ^"New quote"

setRenderer createDom
