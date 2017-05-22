{View, $} = require "space-pen"
shell = require 'shell'

module.exports =
class MainView extends View
  @content: () ->
    style = "height:96%;width:640px;position: absolute;top: 0;right: 0;z-index: 42;"
    @div style:style, =>
      @div class:"codelf-navbar",  =>
        @button "Close", outlet:"close", style:"float:left", class:"btn"
        @button "▶", outlet:"forward", style:"float:right", class:"btn"
        @button "◀", outlet:"back", style:"float:right", class:"btn"
      @tag "webview", src:"about:blank", outlet:"webview", class: "native-key-bindings codelf-webview", plugins: 'on', allowfullscreen: 'on', autosize: 'on', preload:'../clients/openLinkInBrowser.js'

  initialize: (text, self) ->
    @self = self
    @close.on "click", =>
      @self.browserHide()
    @back.on "click", =>
      @webview[0].goBack()
    @forward.on "click", =>
      @webview[0].goForward()
    @setSearchText(text)
    @webview[0].addEventListener 'new-window', (evt) =>
      shell.openExternal(evt.url);
    @webview[0].addEventListener 'console-message', (evt) =>
      console.log('consolemessage: ', evt)

  setURL: (url) ->
    @webview.attr("src", url)

  setSearchText: (text) ->
    url = 'https://unbug.github.io/codelf/'
    url = (url+'#'+text) if text&&text.length

    # http://superuser.com/questions/206229/how-to-make-a-blank-page-in-google-chrome-at-start-up
    @setURL('chrome://newtab')
    setTimeout (=>@setURL(url)), 350
