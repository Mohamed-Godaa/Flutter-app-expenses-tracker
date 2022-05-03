import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'transaction_model.g.dart';

/// {@template transaction}
/// A single todo item.
///
/// Contains a [title], [amount] and [id], in addition to a [date]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Transaction]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}

@immutable
@JsonSerializable()
class Transaction extends Equatable {
  /// {@macro transaction}
  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the transaction.
  ///
  /// Cannot be empty.
  final String id;

  ///The title of the transaction
  ///
  ///cannot be empty
  final String title;

  ///The amount of the transaction
  ///
  ///cannot be empty
  final double amount;

  ///The date of the transaction
  ///
  ///cannot be empty
  final DateTime date;

  ///Returns a copy of this transaction with the given values updated.
  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  /// Deserializes the given [JsonMap] into a [Transaction].
  static Transaction fromJson(JsonMap json) => _$TransactionFromJson(json);

  ///Serializies a given [Transaction] into a [JsonMap].
  JsonMap toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [id, title, amount, date];
}

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;
