namespace anubhav.common;
using { Currency } from '@sap/cds/common';

type Gender : String(2) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}

type Guid : String(32);
type PhoneNumber : String(30) @assert.format : '^[6-9]\d{9}$';
type Email : String(250) @assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

type AmountT : Decimal(10, 2) @(
    Semantic.amount.CurrencyCode: 'CURRENCY_Code'
);

aspect Amount {
    CURRENCY: Currency;
    GROSS_AMOUNT: AmountT;
    NET_AMOUNT: AmountT;
    TAX_AMOUNT: AmountT;
}
