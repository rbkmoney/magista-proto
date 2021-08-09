include "proto/base.thrift"
include "proto/domain.thrift"
include "proto/merch_stat.thrift"
include "proto/payout_manager.thrift"

namespace java com.rbkmoney.magista
namespace erlang magista

typedef string ContinuationToken

exception BadContinuationToken { 1: string reason }
exception LimitExceeded {}

struct InvoiceSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: required PaymentParams payment_params
    3: optional list<domain.InvoiceID> invoice_ids
    4: optional domain.InvoiceStatus invoice_status
    5: optional domain.Amount invoice_amount
    6: optional string external_id
}

struct PaymentSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: required PaymentParams payment_params
    3: optional list<domain.InvoiceID> invoice_ids
    4: optional string external_id
    5: optional list<domain.ShopID> excluded_shop_ids
}

struct RefundSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: optional list<domain.InvoiceID> invoice_ids
    3: optional domain.InvoicePaymentID payment_id
    4: optional domain.InvoicePaymentRefundID refund_id
    5: optional domain.InvoicePaymentRefundStatus refund_status
    6: optional string external_id
}

struct ChargebackSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: optional list<domain.InvoiceID> invoice_ids
    3: optional domain.InvoicePaymentID payment_id
    4: optional domain.InvoicePaymentChargebackID chargeback_id
    5: optional list<domain.InvoicePaymentChargebackStatus> chargeback_statuses
    6: optional list<domain.InvoicePaymentChargebackStage> chargeback_stages
    7: optional list<domain.InvoicePaymentChargebackCategory> chargeback_categories
}

struct PayoutSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: optional payout_manager.PayoutID payout_id
    3: optional list<payout_manager.PayoutStatus> payout_statuses
    4: optional domain.PayoutToolInfo payout_type
}

struct InvoiceTemplateSearchQuery {
    1: required CommonSearchQueryParams common_search_query_params
    2: optional domain.InvoiceTemplateID invoice_template_id
    3: optional base.Timestamp invoice_valid_until
    4: optional string product
}

struct CommonSearchQueryParams {
    1: required base.Timestamp to_time
    2: required base.Timestamp from_time
    3: required domain.PartyID party_id
    4: optional list<domain.ShopID> shop_ids
    5: optional ContinuationToken continuation_token
    6: optional i32 limit
}

struct PaymentParams {
    1: optional domain.InvoicePaymentID payment_id
    2: optional domain.InvoicePaymentStatus payment_status
    3: optional domain.InvoicePaymentFlow payment_flow
    4: optional domain.PaymentTool payment_tool
    5: optional domain.LegacyTerminalPaymentProvider payment_terminal_provider
    6: optional string payment_email
    7: optional string payment_ip
    8: optional string payment_fingerprint
    9: optional string payment_first6
    10: optional domain.LegacyBankCardPaymentSystem payment_system
    12: optional string payment_last4
    11: optional domain.CustomerID payment_customer_id
    13: optional string payment_provider_id
    14: optional string payment_terminal_id
    15: optional domain.Amount payment_amount
    16: optional domain.DataRevision payment_domain_revision
    17: optional domain.DataRevision from_payment_domain_revision
    18: optional domain.DataRevision to_payment_domain_revision
    19: optional string payment_rrn
    20: optional string payment_approval_code
    21: optional domain.Amount payment_amount_from
    22: optional domain.Amount payment_amount_to
    23: optional domain.LegacyBankCardTokenProvider payment_token_provider
}

struct StatInvoiceResponse {
    1: required list<merch_stat.StatInvoice> invoices
    2: optional string continuation_token
}

struct StatPaymentResponse {
    1: required list<merch_stat.StatPayment> payments
    2: optional string continuation_token
}

struct StatRefundResponse {
    1: required list<merch_stat.StatRefund> refunds
    2: optional string continuation_token
}

struct StatChargebackResponse {
    1: required list<merch_stat.StatChargeback> chargebacks
    2: optional string continuation_token
}

struct StatPayoutResponse {
    1: required list<merch_stat.StatPayout> payouts
    2: optional string continuation_token
}

struct StatInvoiceTemplateResponse {
    1: required list<StatInvoiceTemplate> invoice_templates
    2: optional string continuation_token
}

struct StatInvoiceTemplate {
    1: required base.Timestamp created_at
    2: required domain.PartyID party_id
    3: required domain.ShopID shop_id
    4: required domain.InvoiceTemplateID invoice_template_id
    5: required base.Timestamp invoice_valid_until
    6: required string product
    7: optional string description
    8: optional domain.InvoiceTemplateDetails details
    9: optional domain.InvoiceContext context
}

service MerchantStatisticsService {

    StatInvoiceResponse SearchInvoices (1: InvoiceSearchQuery invoice_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

    StatPaymentResponse SearchPayments (1: PaymentSearchQuery payment_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

    StatRefundResponse SearchRefunds (1: RefundSearchQuery refund_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

    StatChargebackResponse SearchChargebacks (1: ChargebackSearchQuery chargeback_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

    StatPayoutResponse SearchPayouts (1: PayoutSearchQuery payout_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

    StatInvoiceTemplateResponse SearchInvoiceTemplates (1: InvoiceTemplateSearchQuery invoice_template_search_query)
        throws (1: BadContinuationToken ex1, 2: LimitExceeded ex2, 3: base.InvalidRequest ex3)

}
