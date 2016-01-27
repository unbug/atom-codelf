{View, $} = require "atom-space-pen-views"
module.exports =
class MainView extends View
  @content: () ->
    style = "height:100%;width:640px"
    @div style:style, =>
      @div class:"codelf inline",  =>
        @button "Close", outlet:"close", style:"float:left", class:"btn"
      @tag "webview", src:"about:blank", outlet:"webview", class: "native-key-bindings", plugins: 'on', allowfullscreen: 'on', autosize: 'on'

  initialize: (text, self) ->
    @self = self
    @close.on "click", =>
      @self.browserHide()
    @setSearchText(text)

  setURL: (url) ->
    @webview.attr("src", url)

  setSearchText: (text) ->
    url = 'http://unbug.github.io/codelf/'
    url = (url+'#'+text) if text&&text.length
    setTimeout (=>@setURL(url)), 100
