namespace anbhav.cds;

using { anubhav.db.master, anubhav.db.transaction } from './datamodel';

context CDSViews {
    define view ![POWorkList] as
        select from transaction.purchaseorder {
            key NODE_KEY as ![PurchaseOrderId],
            key ITEMS.PO_ITEM_POS as ![PurchaseOrderItemPos],
            PARTNER_GUID.BP_ID as ![PartnerId],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            GROSS_AMOUNT as![GrossAmount],
            NET_AMOUNT as![NetAmount],
            TAX_AMOUNT as![TaxAmount],
            CURRENCY as![CurrencyCode],
            OVERALL_STATUS as![OverallStatus],
            ITEMS.PRODUCT_GUID.PRODUCT_ID as ![ProductId],
            ITEMS.PRODUCT_GUID.DESCRIPTION as ![ProductDescription],
            PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]
        }
}
