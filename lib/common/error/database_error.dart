enum DatabaseError {
  unableToUpdate('unable-to-update'),
  ;

  final String code;
  const DatabaseError(this.code);
}

extension DatabaseErrorHelper on DatabaseError {
  static DatabaseError getByCode(String code) {
    return DatabaseError.values.firstWhere(
      (element) => element.code == code,
      orElse: () => DatabaseError.unableToUpdate,
    );
  }
}
