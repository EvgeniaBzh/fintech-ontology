% ============================================
% ОНТОЛОГІЯ ФІНТЕХ СИСТЕМИ
% Предметна область: Платіжні системи та фінтехнології
% ============================================

% ============================================
% 1. ВІДНОШЕННЯ IS_A (таксономія/класифікація)
% ============================================

% Рівень 1 -> 2
is_a(payment, financial_entity).
is_a(payment_method, financial_entity).
is_a(actor, financial_entity).
is_a(subscription, financial_entity).
is_a(dispute, financial_entity).
is_a(currency, financial_entity).
is_a(security_feature, financial_entity).
is_a(routing, financial_entity).

% Рівень 2 -> 3 (Payment гілка)
is_a(order, payment).

% Рівень 2 -> 3 (PaymentMethod гілка)
is_a(card, payment_method).
is_a(alternative_payment_method, payment_method).
is_a(digital_wallet, payment_method).

% Рівень 2 -> 3 (Actor гілка)
is_a(merchant, actor).
is_a(customer, actor).
is_a(processor, actor).

% Рівень 2 -> 3 (Dispute гілка)
is_a(chargeback, dispute).
is_a(retrieval_request, dispute).

% Рівень 3 -> 4 (Payment гілка - Order -> Transaction)
is_a(transaction, order).

% Рівень 3 -> 4 (PaymentMethod гілки)
is_a(branded_card, card).
is_a(regional_apm, alternative_payment_method).
is_a(mobile_wallet, digital_wallet).

% Рівень 3 -> 4 (Actor гілка)
is_a(ecommerce_merchant, merchant).
is_a(retail_merchant, merchant).
is_a(individual_customer, customer).
is_a(business_customer, customer).

% Рівень 4 -> 5 (Payment гілка - Transaction -> TransactionType)
is_a(authorization, transaction).
is_a(settle, transaction).
is_a(refund, transaction).
is_a(void, transaction).

% Рівень 4 -> 5 (Card types)
is_a(visa_card, branded_card).
is_a(mastercard_card, branded_card).
is_a(amex_card, branded_card).

% Рівень 4 -> 5 (APM types)
is_a(pix, regional_apm).
is_a(upi, regional_apm).
is_a(ideal, regional_apm).

% Рівень 4 -> 5 (Wallet types)
is_a(apple_pay, mobile_wallet).
is_a(google_pay, mobile_wallet).

% ============================================
% 2. ВІДНОШЕННЯ PART_OF (композиція)
% ============================================

% CardData компоненти
part_of(card_data, card).
part_of(card_number, card_data).
part_of(bin, card_data).
part_of(cvv, card_data).
part_of(expiration_month, card_data).
part_of(expiration_year, card_data).
part_of(cardholder_name, card_data).

% Security components
part_of(token, security_feature).
part_of(three_ds_secure, security_feature).
part_of(antifraud_solution, security_feature).

% Routing components
part_of(route, routing).
part_of(routing_rule, routing).
part_of(routing_condition, routing).

% Order components
part_of(order_id, order).
part_of(amount, order).
part_of(order_currency, order).
part_of(order_description, order).

% Subscription components
part_of(recurring_payment, subscription).
part_of(billing_cycle, subscription).
part_of(subscription_plan, subscription).

% API Request components
part_of(public_key, api_request).
part_of(secret_key, api_request).
part_of(signature, api_request).
part_of(timestamp, api_request).

% ============================================
% 3. ВІДНОШЕННЯ REQUIRES (вимагає)
% ============================================

requires(order, payment_method).
requires(order, customer).
requires(order, currency).

requires(authorization, card_data).
requires(authorization, three_ds_secure).

requires(settle, authorization).
requires(refund, settle).
requires(void, authorization).

requires(subscription, recurring_payment).
requires(subscription, billing_cycle).
requires(subscription, invoice).

requires(recurring_payment, order). % додано для зв’язку з order

requires(chargeback, transaction).
requires(chargeback, dispute_reason).

requires(api_request, api_key).
requires(api_request, merchant).

% ============================================
% 4. ВІДНОШЕННЯ PROCESSES (обробляє)
% ============================================

processes(processor, payment).
processes(merchant, order).
processes(gateway, api_request).
processes(fraud_system, security_feature).

% ============================================
% 5. ВІДНОШЕННЯ BELONGS_TO (належить)
% ============================================

belongs_to(card, customer).
belongs_to(order, merchant).
belongs_to(transaction, order).
belongs_to(subscription, customer).
belongs_to(dispute, transaction).

% ============================================
% 6. РЕАЛІЗАЦІЇ (INSTANCES) - практичні класи
% ============================================

% Visa Cards (instances)
instance(visa_card_4111, visa_card, [
    card_number('4111111111111111'),
    expiry('12/2025'),
    cvv('123')
]).

instance(visa_card_4532, visa_card, [
    card_number('4532111111111111'),
    expiry('06/2026'),
    cvv('456')
]).

% Mastercard Cards (instances)
instance(mastercard_5555, mastercard_card, [
    card_number('5555555555554444'),
    expiry('09/2025'),
    cvv('789')
]).

instance(mastercard_5105, mastercard_card, [
    card_number('5105105105105100'),
    expiry('03/2027'),
    cvv('321')
]).

% Amex Cards (instances)
instance(amex_3782, amex_card, [
    card_number('378282246310005'),
    expiry('12/2026'),
    cvv('1234')
]).

instance(amex_3714, amex_card, [
    card_number('371449635398431'),
    expiry('08/2027'),
    cvv('5678')
]).

% PIX instances
instance(pix_br_001, pix, [
    country('Brazil'),
    currency('BRL'),
    pix_key('user@example.com'),
    status('active')
]).

instance(pix_br_002, pix, [
    country('Brazil'),
    currency('BRL'),
    pix_key('+5511999999999'),
    status('active')
]).

% UPI instances
instance(upi_in_001, upi, [
    country('India'),
    currency('INR'),
    upi_id('user@paytm'),
    status('active')
]).

instance(upi_in_002, upi, [
    country('India'),
    currency('INR'),
    upi_id('merchant@okaxis'),
    status('active')
]).

% iDEAL instances
instance(ideal_nl_001, ideal, [
    country('Netherlands'),
    currency('EUR'),
    status('active')
]).

instance(ideal_nl_002, ideal, [
    country('Netherlands'),
    currency('EUR'),
    status('active')
]).

% Apple Pay instances
instance(apple_pay_001, apple_pay, [
    device('iPhone 15'),
    token('tok_apple_xyz123'),
    status('active')
]).

instance(apple_pay_002, apple_pay, [
    device('iPad Pro'),
    token('tok_apple_abc456'),
    status('active')
]).

% Google Pay instances
instance(google_pay_001, google_pay, [
    device('Pixel 8'),
    token('tok_google_def789'),
    status('active')
]).

instance(google_pay_002, google_pay, [
    device('Samsung S24'),
    token('tok_google_ghi012'),
    status('active')
]).

% Authorization transactions
instance(auth_tx_001, authorization, [
    amount(100.00),
    currency('USD'),
    status('auth_ok'),
    timestamp('2025-09-29T10:30:00Z')
]).

instance(auth_tx_002, authorization, [
    amount(250.50),
    currency('EUR'),
    status('auth_failed'),
    timestamp('2025-09-29T11:45:00Z')
]).

% Capture transactions
instance(capture_tx_001, settle, [
    amount(100.00),
    currency('USD'),
    status('settle_ok'),
    timestamp('2025-09-29T12:00:00Z')
]).

instance(capture_tx_002, settle, [
    amount(250.50),
    currency('EUR'),
    status('settle_failed'),
    timestamp('2025-09-29T13:15:00Z')
]).

% Refund transactions
instance(refund_tx_001, refund, [
    amount(50.00),
    currency('USD'),
    type('partial'),
    status('processing'),
    timestamp('2025-09-29T14:30:00Z')
]).

instance(refund_tx_002, refund, [
    amount(125.25),
    currency('EUR'),
    type('full'),
    status('processing'),
    timestamp('2025-09-29T15:45:00Z')
]).

% Void transactions
instance(void_tx_001, void, [
    original_amount(100.00),
    currency('USD'),
    status('void_ok'),
    timestamp('2025-09-29T16:00:00Z')
]).

instance(void_tx_002, void, [
    original_amount(250.50),
    currency('EUR'),
    status('void_failed'),
    timestamp('2025-09-29T17:15:00Z')
]).

% Ecommerce Merchants
instance(ecommerce_merchant_001, ecommerce_merchant, [
    name('OnlineShop Ltd'),
    merchant_id('merch_001'),
    website('https://onlineshop.com')
]).

instance(ecommerce_merchant_002, ecommerce_merchant, [
    name('Fashion Store'),
    merchant_id('merch_002'),
    website('https://fashionstore.com')
]).

% Retail Merchants
instance(retail_merchant_001, retail_merchant, [
    name('Local Supermarket'),
    merchant_id('merch_003'),
    location('123 Main St, Kyiv')
]).

instance(retail_merchant_002, retail_merchant, [
    name('Electronics Store'),
    merchant_id('merch_004'),
    location('456 Tech Avenue, Lviv')
]).

% Individual Customers
instance(individual_customer_001, individual_customer, [
    name('Ivan Ivanenko'),
    customer_account_id('cust_001'),
    email('ivan@example.com')
]).

instance(individual_customer_002, individual_customer, [
    name('Olena Kovalenko'),
    customer_account_id('cust_002'),
    email('olena@example.com')
]).

% Business Customers
instance(business_customer_001, business_customer, [
    company_name('Tech Solutions LLC'),
    customer_account_id('cust_b001'),
    tax_id('12345678')
]).

instance(business_customer_002, business_customer, [
    company_name('Marketing Agency Inc'),
    customer_account_id('cust_b002'),
    tax_id('87654321')
]).

% ============================================
% 7. ДОПОМІЖНІ ПРЕДИКАТИ ДЛЯ ЗАПИТІВ
% ============================================

% Транзитивне замикання для is_a
is_a_transitive(X, Y) :- is_a(X, Y).
is_a_transitive(X, Y) :- is_a(X, Z), is_a_transitive(Z, Y).

% Транзитивне замикання для part_of
part_of_transitive(X, Y) :- part_of(X, Y).
part_of_transitive(X, Y) :- part_of(X, Z), part_of_transitive(Z, Y).

% Перевірка чи повязані два обєкти через будь-яке відношення
connected(X, Y) :- is_a(X, Y).
connected(X, Y) :- is_a(Y, X).
connected(X, Y) :- part_of(X, Y).
connected(X, Y) :- part_of(Y, X).
connected(X, Y) :- requires(X, Y).
connected(X, Y) :- requires(Y, X).
connected(X, Y) :- processes(X, Y).
connected(X, Y) :- processes(Y, X).
connected(X, Y) :- belongs_to(X, Y).
connected(X, Y) :- belongs_to(Y, X).

% Транзитивне замикання для будь-якого звязку
connected_transitive(X, Y) :- connected(X, Y).
connected_transitive(X, Y) :- connected(X, Z), connected_transitive(Z, Y).

% Пошук шляху між двома вузлами
find_path(X, Y, Path) :- find_path(X, Y, [X], Path).

find_path(X, Y, Visited, Path) :-
    connected(X, Y),
    \+ member(Y, Visited),
    reverse([Y|Visited], Path).

find_path(X, Y, Visited, Path) :-
    connected(X, Z),
    \+ member(Z, Visited),
    find_path(Z, Y, [Z|Visited], Path).

% Визначення типу звязку
relation_type(X, Y, 'is_a') :- is_a(X, Y).
relation_type(X, Y, 'part_of') :- part_of(X, Y).
relation_type(X, Y, 'requires') :- requires(X, Y).
relation_type(X, Y, 'processes') :- processes(X, Y).
relation_type(X, Y, 'belongs_to') :- belongs_to(X, Y).

% Пошук всіх нащадків класу (is_a ієрархія)
all_descendants(Class, Descendants) :-
    findall(D, is_a_transitive(D, Class), Descendants).

% Пошук всіх компонентів (part_of ієрархія)
all_parts(Whole, Parts) :-
    findall(P, part_of_transitive(P, Whole), Parts).

% Пошук всіх вимог для обєкта
all_requirements(Entity, Requirements) :-
    findall(R, requires(Entity, R), Requirements).

% Пошук всіх екземплярів класу
all_instances(Class, Instances) :-
    findall(I, (instance(I, Type, _), is_a_transitive(Type, Class)), Instances).

% Отримання інформації про екземпляр
instance_info(Instance, Type, Properties) :-
    instance(Instance, Type, Properties).

% ============================================
% 8. ПРИКЛАДИ ЗАПИТІВ
% ============================================

% Запит 1: Чи повязана subscription з chargeback?
% ?- connected_transitive(subscription, chargeback).

% Запит 2: Знайти шлях між subscription та dispute
% ?- find_path(subscription, dispute, Path).

% Запит 3: Всі типи карток
% ?- all_descendants(card, Cards).

% Запит 4: Всі компоненти card_data
% ?- all_parts(card_data, Parts).

% Запит 5: Що потрібно для authorization?
% ?- all_requirements(authorization, Reqs).

% Запит 6: Всі екземпляри Visa карток
% ?- all_instances(visa_card, Instances).

% Запит 7: Інформація про конкретний екземпляр
% ?- instance_info(visa_card_4111, Type, Props).

% Запит 8: Чи є visa_card типом card?
% ?- is_a_transitive(visa_card, card).

% Запит 9: Хто обробляє транзакції?
% ?- processes(X, transaction).

% Запит 10: Кому належить card?
% ?- belongs_to(card, X).

% ============================================
% КІНЕЦЬ БАЗИ ЗНАНЬ
% ============================================
