{View, $} = require "atom-space-pen-views"
module.exports =
class MainView extends View
  @content: (text, self) ->
    url = 'http://unbug.github.io/codelf/'
    url = (url+'#'+text) if text
    style = "height:100%;width:640px"
    @div style:style, =>
      @div class:"codelf inline",  =>
        @button "close", outlet:"close", style:"float:left", class:"btn"
      @tag "webview", src:"#{url}", outlet:"webview"

  initialize: (text, self) ->
    @self = self
    @close.on "click", =>
      @self.browserHide()

  setURL: (url) ->
    @webview.attr("src", url)

  setSearchText: (text) ->
    url = 'http://unbug.github.io/codelf/'
    url = (url+'#'+text) if text&&text.length

    # http://superuser.com/questions/206229/how-to-make-a-blank-page-in-google-chrome-at-start-up
    @setURL('chrome://newtab')
    setTimeout (=>@setURL(url)), 100
