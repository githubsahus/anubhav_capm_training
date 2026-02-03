namespace anubhav.db;
using { cuid, Currency } from '@sap/cds/common';
using { anubhav.common as commons } from './commons';



context master {

    entity businesspartner {
        key NODE_KEY: commons.Guid;
        BP_ROLE: String(2);
        EMAIL_ADDRESS: commons.Email;
        PHONE_NUMBER: commons.PhoneNumber;
        FAX_NUMBER: String(32);
        WEB_ADDRESS: String(44);
        COMPANY_NAME: String(250);
        BP_ID: String(32);
        ADDRESS_GUID: Association to one address;
    }

    entity address{
        key NODE_KEY: commons.Guid;
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING: String(128);
        COUNTRY: String(44);
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE: Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        //$self - which represent the primary key of current table
        businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }


    //cuid is an aspect which is provided by cds/common and it creates a primary key 'ID' of type UUID
    entity employee: cuid {
        nameFirst: String(256);
        nameMiddle: String(256);
        nameLast: String(256);
        nameInitials: String(40);
        sex: commons.Gender;
        language: String(1);
        phoneNumber: commons.PhoneNumber;
        email: commons.Email;
        loginName: String(12);
        currency: Currency;
        salaryAmount: commons.AmountT;
        accountNumber: String(16);
        bankId: String(8);
        bankName: String(64);
    }

    //master data products
    entity product {
        key NODE_KEY: commons.Guid;
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID: Association to one businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE: Decimal(5, 2);
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE: String(4);
        PRICE:  Decimal(15,2);
        WIDTH:  Decimal(5,2);
        DEPTH:  Decimal(5,2);
        HEIGHT: Decimal(5,2);
        DIM_UNIT: String(2);
    }
}

context transaction {
    entity purchaseorder: commons.Amount {
        key NODE_KEY: commons.Guid;
        PO_ID: String(32);
        PARTNER_GUID: Association to one master.businesspartner;
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS: String(1);
        NOTE: String(100);
        ITEMS: Association to many poitems on ITEMS.PARENT_KEY = $self;
    };

    entity poitems: commons.Amount {
        key NODE_KEY: commons.Guid;
        PARENT_KEY: Association to one purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to one master.product;
    }
    
}