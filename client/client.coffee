DocumentsRouter = Backbone.Router.extend(
  routes:
    ":document_id": "main"

  main: (document_id) ->
    Session.set "document_id", document_id

  setDocument: (document_id) ->
    @navigate(document_id, true)
)

Router = new DocumentsRouter

Meteor.startup ->
  Backbone.history.start pushState: true

Template.documentList.documents = ->
  Documents.find({},
    sort:
      name: 1
  )

Template.documentList.events = 
  'click #new-document': (e) ->
    name = $('#new-document-name').val()
    if name
      Documents.insert(
        name: name
        text: ""
      )

Template.document.events = 
  'click #delete-document': (e) ->
    Documents.remove(@_id)
  'click #edit-document': (e) ->
    Router.setDocument(@_id)

Template.document.selected = ->
    if Session.equals("document_id", @_id) then "selected" else ""

Template.documentView.selectedDocument = ->
  document_id = Session.get("document_id")
  Documents.findOne(
    _id: document_id
  )

Template.documentView.events = 
  'keyup #document-text': (e) ->
    # @_id should work here, but it doesn't
    sel = _id: Session.get("document_id")
    mod = $set: text: $('#document-text').val()
    Documents.update(sel, mod)

