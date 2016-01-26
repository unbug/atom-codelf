MainView = require "./lib/MainView"
{CompositeDisposable} = require 'atom'

module.exports = Codelf =
  MainView: null
  modalPanel: null
  browserPanel: null
  subscriptions: null

  activate: () ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'codelf:search': => @search()

    atom.config.onDidChange 'codelf.browser.position', () => @browserChanged()
    atom.config.onDidChange 'codelf.browser.size', () => @browserChanged()
    atom.config.onDidChange 'codelf.browser.useragent', () => @browserChanged()

  search: ()->
    e = atom.workspace.getActiveTextEditor()
    return unless e?
    text = if e.getSelectedText().length > 0 then e.getSelectedText() else ""

    if @browserPanel is null
      @addMainView(text)

    else
      @browserPanel.show()
      setTimeout ( => @MainView.setSearchText(text)), 100

  browserChanged: () ->
    @browserHide()
    @browserPanel.destroy()
    @browserPanel = null

  addMainView: (text) ->
    @MainView = new MainView(encodeURIComponent(text), this)
    @browserPanel = atom.workspace.addRightPanel(item: @MainView)

  deactivate: ->
    @modalPanel.destroy()
    @browserPanel.destroy()
    @subscriptions.dispose()
    @MainView.destroy()

  browserHide: ->
    @browserPanel?.hide()
