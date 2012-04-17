Meteor.startup ->
  if Documents.find().count() is 0
    Documents.insert
      name: "Sample doc"
      text: "Write here..."