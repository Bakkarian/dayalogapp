// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> orderFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String orderToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  OrdersModel({
    required this.fromMerchantCode,
    required this.toMerchantCode,
    required this.toEmail,
    required this.toPhone,
    required this.loggedId,
    required this.id,
    required this.generatedInstrumentNo,
    required this.companyUserId,
    required this.quotationNo,
    required this.fromCompanyId,
    required this.toCompanyId,
    required this.fromName,
    required this.fromBillingAddress,
    required this.toBillingAddress,
    required this.vat,
    required this.validityPeriod,
    required this.toName,
    required this.termsAndConditions,
    required this.grandTotal,
    required this.type,
    required this.deliveryMethod,
    required this.deliveryStatus,
    required this.status,
    required this.currencyId,
    required this.currencyFormat,
    required this.updatedAt,
    required this.createdAt,
    required this.receiverFinanceRequestStatus,
    required this.senderFinanceRequestStatus,
    required this.toEmailAddress,
    required this.latitude,
    required this.longitude,
    required this.platform,
    required this.poItems,
  });

  String? fromMerchantCode;
  String? toMerchantCode;
  String? toEmail;
  String? toPhone;
  int loggedId;
  int id;
  String generatedInstrumentNo;
  dynamic companyUserId;
  dynamic quotationNo;
  int fromCompanyId;
  dynamic toCompanyId;
  String? fromName;
  String? fromBillingAddress;
  String? toBillingAddress;
  String? vat;
  String? validityPeriod;
  String? toName;
  String? termsAndConditions;
  String? grandTotal;
  String? type;
  String? deliveryMethod;
  String? deliveryStatus;
  int status;
  int currencyId;
  String? currencyFormat;
  String? updatedAt;
  String? createdAt;
  int receiverFinanceRequestStatus;
  int senderFinanceRequestStatus;
  dynamic toEmailAddress;
  String? latitude;
  String? longitude;
  String? platform;
  List<PoItem> poItems;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    fromMerchantCode: json["from_merchant_code"],
    toMerchantCode: json["to_merchant_code"],
    toEmail: json["to_email"],
    toPhone: json["to_phone"],
    loggedId: json["logged_id"],
    id: json["id"],
    generatedInstrumentNo: json["generated_instrument_no"],
    companyUserId: json["company_user_id"],
    quotationNo: json["quotation_no"],
    fromCompanyId: json["from_company_id"],
    toCompanyId: json["to_company_id"],
    fromName: json["from_name"],
    fromBillingAddress: json["from_billing_address"],
    toBillingAddress: json["to_billing_address"],
    vat: json["vat"],
    validityPeriod: json["validity_period"],
    toName: json["to_name"],
    termsAndConditions: json["terms_and_conditions"],
    grandTotal: json["grand_total"],
    type: json["type"],
    deliveryMethod: json["delivery_method"],
    deliveryStatus: json["delivery_status"],
    status: json["status"],
    currencyId: json["currency_id"]==null?0:json["currency_id"],
    currencyFormat: json["currency_format"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    receiverFinanceRequestStatus: json["receiver_finance_request_status"],
    senderFinanceRequestStatus: json["sender_finance_request_status"],
    toEmailAddress: json["to_email_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    platform: json["platform"],
    poItems: List<PoItem>.from(json["po_items"].map((x) => PoItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "from_merchant_code": fromMerchantCode,
    "to_merchant_code": toMerchantCode,
    "to_email": toEmail,
    "to_phone": toPhone,
    "logged_id": loggedId,
    "id": id,
    "generated_instrument_no": generatedInstrumentNo,
    "company_user_id": companyUserId,
    "quotation_no": quotationNo,
    "from_company_id": fromCompanyId,
    "to_company_id": toCompanyId,
    "from_name": fromName,
    "from_billing_address": fromBillingAddress,
    "to_billing_address": toBillingAddress,
    "vat": vat,
    "validity_period": "${validityPeriod}",
    "to_name": toName,
    "terms_and_conditions": termsAndConditions,
    "grand_total": grandTotal,
    "type": type,
    "delivery_method": deliveryMethod,
    "delivery_status": deliveryStatus,
    "status": status,
    "currency_id": currencyId,
    "currency_format": currencyFormat,
    "updated_at": "${updatedAt}",
    "created_at": "${createdAt}",
    "receiver_finance_request_status": receiverFinanceRequestStatus,
    "sender_finance_request_status": senderFinanceRequestStatus,
    "to_email_address": toEmailAddress,
    "latitude": latitude,
    "longitude": longitude,
    "platform": platform,
    "po_items": List<dynamic>.from(poItems.map((x) => x.toJson())),
  };
}

class PoItem {
  PoItem({
    required this.id,
    required this.financialInstrumentId,
    required this.productAndServiceId,
    required this.qty,
    required this.item,
    required this.price,
    required this.unitMeasure,
    required this.ordered,
    required this.delivered,
    required this.outstanding,
    required this.deductions,
    required this.companyId,
    required this.companySupplierId,
    required this.isMisDeliveryItem,
    required this.period,
    required this.total,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int financialInstrumentId;
  dynamic productAndServiceId;
  String? qty;
  String? item;
  String? price;
  String? unitMeasure;
  dynamic ordered;
  dynamic delivered;
  dynamic outstanding;
  dynamic deductions;
  dynamic companyId;
  dynamic companySupplierId;
  String? isMisDeliveryItem;
  String? period;
  String? total;
  int deleted;
  String? createdAt;
  String? updatedAt;

  factory PoItem.fromJson(Map<String, dynamic> json) => PoItem(
    id: json["id"],
    financialInstrumentId: json["financial_instrument_id"],
    productAndServiceId: json["product_and_service_id"],
    qty: json["qty"],
    item: json["item"],
    price: json["price"],
    unitMeasure: json["unit_measure"],
    ordered: json["ordered"],
    delivered: json["delivered"],
    outstanding: json["outstanding"],
    deductions: json["deductions"],
    companyId: json["company_id"],
    companySupplierId: json["company_supplier_id"],
    isMisDeliveryItem: json["is_mis_delivery_item"],
    period: json["period"],
    total: json["total"],
    deleted: json["deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "financial_instrument_id": financialInstrumentId,
    "product_and_service_id": productAndServiceId,
    "qty": qty,
    "item": item,
    "price": price,
    "unit_measure": unitMeasure,
    "ordered": ordered,
    "delivered": delivered,
    "outstanding": outstanding,
    "deductions": deductions,
    "company_id": companyId,
    "company_supplier_id": companySupplierId,
    "is_mis_delivery_item": isMisDeliveryItem,
    "period": period,
    "total": total,
    "deleted": deleted,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };
}
