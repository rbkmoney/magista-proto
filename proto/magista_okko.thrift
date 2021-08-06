include "proto/base.thrift"
include "proto/domain.thrift"
include "proto/merch_stat.thrift"

namespace java com.rbkmoney.magista.okko
namespace erlang magista_okko

typedef string ContinuationToken

exception BadContinuationToken { 1: string reason }
exception LimitExceeded {}

struct PaymentSearchQuery {
    1: required SearchQuery search_query
    2: optional domain.InvoiceID invoice_id
    3: optional domain.InvoicePaymentID payment_id
    4: optional domain.InvoicePaymentStatus payment_status
    5: optional domain.InvoicePaymentFlow payment_flow
    6: optional domain.PaymentTool payment_tool
    7: optional domain.LegacyTerminalPaymentProvider payment_terminal_provider
    8: optional string payment_email
    9: optional string payment_ip
    10: optional string payment_fingerprint
    11: optional string payment_first6
    12: optional domain.LegacyBankCardPaymentSystem payment_system
    13: optional string payment_last4
    14: optional domain.CustomerID payment_customer_id
    15: optional domain.Amount payment_amount
    16: optional domain.DataRevision payment_domain_revision
    17: optional domain.DataRevision from_payment_domain_revision
    18: optional domain.DataRevision to_payment_domain_revision
    19: optional string payment_rrn
    20: optional string payment_approval_code
    21: optional string external_id
    22: optional domain.LegacyBankCardTokenProvider payment_token_provider
}

struct RefundSearchQuery {
    1: required SearchQuery search_query
    2: optional domain.InvoiceID invoice_id
    3: optional domain.InvoicePaymentID payment_id
    4: optional domain.InvoicePaymentRefundID refund_id
    5: optional domain.InvoicePaymentRefundStatus refund_status
    6: optional string external_id
}

struct SearchQuery {
    1: optional base.Timestamp to_time
    2: optional base.Timestamp from_time
    3: optional domain.PartyID party_id
    4: optional domain.ShopID shop_id
    5: optional ContinuationToken continuation_token
    6: optional i32 limit
}

struct StatResponse {
    1: required list<merch_stat.EnrichedStatInvoice> enriched_invoices
    2: optional ContinuationToken continuation_token
}

service OkkoMerchantStatisticsService {

    StatResponse SearchInvoicesByPaymentQuery (PaymentSearchQuery payment_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2)

    StatResponse SearchInvoicesByRefundQuery (RefundSearchQuery refund_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2)

}
