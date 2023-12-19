import 'dart:convert';

class SecureTacInfoResponse {
  String? status;
  String? errorCode;
  String? errorMessage;
  String? monetary;
  String? amount;
  String? ibTxnId;
  List<TxnDetail>? txnDetail;

  SecureTacInfoResponse({
    this.status,
    this.errorCode,
    this.errorMessage,
    this.monetary,
    this.amount,
    this.ibTxnId,
    this.txnDetail,
  });

  factory SecureTacInfoResponse.fromRawJson(String str) =>
      SecureTacInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SecureTacInfoResponse.fromJson(Map<String, dynamic> json) =>
      SecureTacInfoResponse(
        status: json["status"],
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        monetary: json["monetary"],
        amount: json["amount"],
        ibTxnId: json["ibTxnId"],
        txnDetail: json["txnDetail"] == null
            ? []
            : List<TxnDetail>.from(
                json["txnDetail"]!.map(
                  (x) => TxnDetail.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "monetary": monetary,
        "amount": amount,
        "ibTxnId": ibTxnId,
        "txnDetail": txnDetail == null
            ? []
            : List<dynamic>.from(txnDetail!.map((x) => x.toJson())),
      };
}

class TxnDetail {
  String? key;
  String? value;
  String? rank;

  TxnDetail({
    this.key,
    this.value,
    this.rank,
  });

  factory TxnDetail.fromRawJson(String str) =>
      TxnDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TxnDetail.fromJson(Map<String, dynamic> json) => TxnDetail(
        key: json["key"],
        value: json["value"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "rank": rank,
      };
}
