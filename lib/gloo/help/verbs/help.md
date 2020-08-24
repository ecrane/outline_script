# HELP VERB

 - NAME: help
 - SHORTCUT: ?

## DESCRIPTION

 - Show information about the application.
 - The help command can also be used to show a list of objects, verbs, or to show detail about a single object or a single verb.


## SYNTAX

  `help <about>`

### PARAMETERS

#### about
  - Optional parameter.  If no parameter is given, shows the default help screen
  - settings - Show application settings
  - verbs - List available verbs
  - objects - List available objects
  - keywords - List all keywords
  - `<verb>` - Look up detail about a verb
  - `<object>` - Look up detail about an object


### RESULT

  The help screen will be shown with relevant information.
  `<it>` will also contain the help text.
  TODO:  Should `<it>` have the help text?  Why?

### ERRORS

  Trying to access a help topic that does not exist will result
  in an error.
