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

    define view ![ProductValueHelp] as 
        select from master.product {
            @EndUserText.Label: [
                {
                    language: 'en',
                    text: 'Product Id'
                },
                {
                    language: 'de',
                    text: 'Produkt Id'
                }
            ]
            NODE_KEY as ![ProductId],
            @EndUserText.Label: [
                {
                    language: 'en',
                    text: 'Product Description'
                },
                {
                    language: 'de',
                    text: 'Produkt beschreibung'
                }
            ]
            DESCRIPTION as ![Description]
        }

        define view ![ItemView] as 
            select from transaction.poitems {
                PARENT_KEY.PARTNER_GUID.NODE_KEY as ![CustomerId],
                PRODUCT_GUID.NODE_KEY as ![ProductId],
                CURRENCY as ![CurrencyCode],
                GROSS_AMOUNT as ![GrossAmount],
                NET_AMOUNT as ![NetAmount],
                TAX_AMOUNT as ![TaxAmount],
                PARENT_KEY.OVERALL_STATUS as ![Status]
        };

        define view ![ProductView] as  
            select from master.product
                mixin {
                    PO_ORDER: Association to many ItemView on PO_ORDER.ProductId = $self.ProductId
                } into {
                    NODE_KEY as ![ProductId],
                    DESCRIPTION as ![Description],
                    CATEGORY as ![Category],
                    PRICE as ![Price],
                    SUPPLIER_GUID.BP_ID as ![SupplierId],
                    SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
                    SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
                    PO_ORDER as ![To_Items]
        };

    define view ![ProductValueView] as 
        select from ProductView {
            ProductId,
            Country,
            To_Items.CurrencyCode as ![CurrencyCode],
            Description,
            round(To_Items.GrossAmount, 2) as ![TotalAmount]
            
        } group by ProductId;
}
