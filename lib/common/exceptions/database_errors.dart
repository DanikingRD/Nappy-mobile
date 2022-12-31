/// This file contains all the Database related errors.
/// These are unrecoverable errors and therefore when thrown the aplication
/// will crash. It is up to the programmer to make this impossible to happen.

/// Thrown if the user was not authenticated when a database action was requested.
class NotAuthenticatedError extends Error {}

/// Thrown if the database document requested was null
class NullDocumentError extends Error {}
