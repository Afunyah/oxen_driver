/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Customer type in your schema. */
@immutable
class Customer extends Model {
  static const classType = const _CustomerModelType();
  final String id;
  final String? _firstName;
  final String? _lastName;
  final String? _phoneNumber;
  final String? _email;
  final String? _address;
  final String? _status;
  final String? _birthdate;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get lastName {
    try {
      return _lastName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get phoneNumber {
    try {
      return _phoneNumber!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get address {
    try {
      return _address!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get status {
    try {
      return _status!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get birthdate {
    try {
      return _birthdate!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const Customer._internal({required this.id, required firstName, required lastName, required phoneNumber, required email, required address, required status, required birthdate}): _firstName = firstName, _lastName = lastName, _phoneNumber = phoneNumber, _email = email, _address = address, _status = status, _birthdate = birthdate;
  
  factory Customer({String? id, required String firstName, required String lastName, required String phoneNumber, required String email, required String address, required String status, required String birthdate}) {
    return Customer._internal(
      id: id == null ? UUID.getUUID() : id,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      status: status,
      birthdate: birthdate);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Customer &&
      id == other.id &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _phoneNumber == other._phoneNumber &&
      _email == other._email &&
      _address == other._address &&
      _status == other._status &&
      _birthdate == other._birthdate;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Customer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("birthdate=" + "$_birthdate");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Customer copyWith({String? id, String? firstName, String? lastName, String? phoneNumber, String? email, String? address, String? status, String? birthdate}) {
    return Customer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      status: status ?? this.status,
      birthdate: birthdate ?? this.birthdate);
  }
  
  Customer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _phoneNumber = json['phoneNumber'],
      _email = json['email'],
      _address = json['address'],
      _status = json['status'],
      _birthdate = json['birthdate'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'firstName': _firstName, 'lastName': _lastName, 'phoneNumber': _phoneNumber, 'email': _email, 'address': _address, 'status': _status, 'birthdate': _birthdate
  };

  static final QueryField ID = QueryField(fieldName: "customer.id");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField BIRTHDATE = QueryField(fieldName: "birthdate");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Customer";
    modelSchemaDefinition.pluralName = "Customers";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.FIRSTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.LASTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.PHONENUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.ADDRESS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.STATUS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.BIRTHDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CustomerModelType extends ModelType<Customer> {
  const _CustomerModelType();
  
  @override
  Customer fromJson(Map<String, dynamic> jsonData) {
    return Customer.fromJson(jsonData);
  }
}