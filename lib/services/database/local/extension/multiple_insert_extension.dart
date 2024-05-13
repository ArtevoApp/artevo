import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

extension MultipleInsert on Database {
  Future<int?> insertMultiple(
    String table,
    Iterable<Map<String, Object?>> data, {
    ConflictAlgorithm? conflictAlgorithm,
    int blockSize = 100,
  }) async {
    final conflictStr = conflictAlgorithm == null
        ? ''
        : '${_conflictValues[conflictAlgorithm]}';
    final cols = data.first.keys.toList();
    final colsString = cols.map((e) => '"$e"').join(',\n\t');
    final command =
        'INSERT $conflictStr INTO "$table" (\n\t$colsString\n\t)\nVALUES\n\t';
    final argsString = '(${cols.map((e) => '?').join(', ')})';

    int? result;
    for (var chunk in chunk(data, blockSize)) {
      final sql = StringBuffer(command);
      final params = <Object?>[];
      chunk.forEachIndexed((i, row) {
        sql.write(argsString);
        if (i == chunk.length - 1) {
          sql.write(';');
        } else {
          sql.write(',\n\t');
        }
        for (var col in cols) {
          params.add(row[col]);
        }
      });
      result = await rawInsert(sql.toString(), params);
    }
    return result;
  }
}

Iterable<Iterable<T>> chunk<T>(Iterable<T> iterable, int chunkSize) sync* {
  var start = 0;
  while (start < iterable.length) {
    yield iterable.skip(start).take(chunkSize);
    start += chunkSize;
  }
}

const _conflictValues = {
  ConflictAlgorithm.rollback: 'OR ROLLBACK',
  ConflictAlgorithm.abort: 'OR ABORT',
  ConflictAlgorithm.fail: 'OR FAIL',
  ConflictAlgorithm.ignore: 'OR IGNORE',
  ConflictAlgorithm.replace: 'OR REPLACE'
};
