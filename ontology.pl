% ============================================
% онтологія фінтех системи (розширена версія)
% предметна область: платіжні системи та фінтехнології
% ============================================

% ============================================
% 1. відношення is_a (таксономія/класифікація)
% ============================================
% описує ієрархію "є типом чогось"

% рівень 1 -> 2
% всі основні сутності фінансової системи є типами financial_entity (фінансова сутність)
is_a(payment, financial_entity).
is_a(payment_method, financial_entity).
is_a(actor, financial_entity).
is_a(subscription, financial_entity).
is_a(dispute, financial_entity).
is_a(currency, financial_entity).
is_a(security_feature, financial_entity).
is_a(routing, financial_entity).
is_a(api_request, financial_entity).
is_a(api_key, security_feature).
is_a(gateway, processor).
is_a(fraud_system, processor).
is_a(invoice, financial_entity).
is_a(dispute_reason, dispute).

% рівень 2 -> 3 (payment гілка)
% деталізація типів платежів
is_a(order, payment).

% рівень 2 -> 3 (paymentmethod гілка)
% різні категорії методів оплати
is_a(card, payment_method).
is_a(alternative_payment_method, payment_method).
is_a(digital_wallet, payment_method).

% рівень 2 -> 3 (actor гілка)
% типи учасників фінансової системи
is_a(merchant, actor).
is_a(customer, actor).
is_a(processor, actor).

% рівень 2 -> 3 (dispute гілка)
% типи суперечок
is_a(chargeback, dispute).
is_a(retrieval_request, dispute).

% рівень 3 -> 4 (payment гілка - order -> transaction)
% транзакція є типом замовлення
is_a(transaction, order).

% рівень 3 -> 4 (paymentmethod гілки)
% деталізація типів карток, альтернативних методів та гаманців
is_a(branded_card, card).
is_a(regional_apm, alternative_payment_method).
is_a(mobile_wallet, digital_wallet).

% рівень 3 -> 4 (actor гілка)
% типи продавців та клієнтів
is_a(ecommerce_merchant, merchant).
is_a(retail_merchant, merchant).
is_a(individual_customer, customer).
is_a(business_customer, customer).

% рівень 4 -> 5 (payment гілка - transaction -> transactiontype)
% конкретні типи транзакцій
is_a(authorization, transaction).
is_a(settle, transaction).
is_a(refund, transaction).
is_a(void, transaction).

% рівень 4 -> 5 (card types)
% конкретні бренди карток
is_a(visa_card, branded_card).
is_a(mastercard_card, branded_card).
is_a(amex_card, branded_card).

% рівень 4 -> 5 (apm types)
% конкретні регіональні методи оплати
is_a(pix, regional_apm).
is_a(upi, regional_apm).
is_a(ideal, regional_apm).

% рівень 4 -> 5 (wallet types)
% конкретні типи мобільних гаманців
is_a(apple_pay, mobile_wallet).
is_a(google_pay, mobile_wallet).

% ============================================
% 2. відношення part_of (композиція)
% ============================================
% описує що є частиною чогось

% carddata компоненти
% структура даних картки та її складові частини
part_of(card_data, card).
part_of(card_number, card_data).
part_of(bin, card_data).
part_of(cvv, card_data).
part_of(expiration_month, card_data).
part_of(expiration_year, card_data).
part_of(cardholder_name, card_data).

% security components
part_of(token, security_feature).
part_of(three_ds_secure, security_feature).
part_of(antifraud_solution, security_feature).

% routing components
part_of(route, routing).
part_of(routing_rule, routing).
part_of(routing_condition, routing).

% order components
part_of(order_id, order).
part_of(amount, order).
part_of(order_currency, order).
part_of(order_description, order).

% subscription components
part_of(recurring_payment, subscription).
part_of(billing_cycle, subscription).
part_of(subscription_plan, subscription).

% api request components
% компоненти api запиту
part_of(public_key, api_request).
part_of(secret_key, api_request).
part_of(signature, api_request).
part_of(timestamp, api_request).

% ============================================
% 3. відношення requires (вимагає)
% ============================================
% описує залежності між сутностями

% залежності замовлення
requires(order, payment_method).
requires(order, customer).
requires(order, currency).

% залежності авторизації
requires(authorization, card_data).
requires(authorization, three_ds_secure).

% залежності між транзакціями (ланцюжок)
requires(settle, authorization).
requires(refund, settle).
requires(void, authorization).

% залежності підписки
requires(subscription, recurring_payment).
requires(subscription, billing_cycle).
requires(subscription, invoice).

% звязок рекурентного платежу з замовленням
requires(recurring_payment, order).

% залежності чарджбеку
requires(chargeback, transaction).
requires(chargeback, dispute_reason).

% залежності api запиту
requires(api_request, api_key).
requires(api_request, merchant).

% ============================================
% 4. відношення processes (обробляє)
% ============================================
% це відношення описує хто що обробляє

processes(processor, payment).
processes(merchant, order).
processes(gateway, api_request).
processes(fraud_system, security_feature).

% ============================================
% 5. відношення belongs_to (належить)
% описує власність

belongs_to(card, customer).
belongs_to(order, merchant).
belongs_to(transaction, order).
belongs_to(subscription, customer).
belongs_to(dispute, transaction).

% ============================================
% 6. реалізації (instances) - практичні класи
% ============================================
% це конкретні екземпляри класів з реальними даними

% Visa Cards (instances)
instance(visa_card_4111, visa_card, [
    card_number('4111111111111111'),
    expiry('12/2025'),
    cvv('123'),
    status(active),
    created_at('2024-01-15')
]).

instance(visa_card_4532, visa_card, [
    card_number('4532111111111111'),
    expiry('06/2026'),
    cvv('456'),
    status(active),
    created_at('2024-03-20')
]).

% Mastercard Cards (instances)
instance(mastercard_5555, mastercard_card, [
    card_number('5555555555554444'),
    expiry('09/2025'),
    cvv('789'),
    status(active),
    created_at('2024-02-10')
]).

instance(mastercard_5105, mastercard_card, [
    card_number('5105105105105100'),
    expiry('03/2027'),
    cvv('321'),
    status(active),
    created_at('2024-04-05')
]).

% Amex Cards (instances)
instance(amex_3782, amex_card, [
    card_number('378282246310005'),
    expiry('12/2026'),
    cvv('1234'),
    status(active),
    created_at('2024-01-25')
]).

instance(amex_3714, amex_card, [
    card_number('371449635398431'),
    expiry('08/2027'),
    cvv('5678'),
    status(suspended),
    created_at('2024-05-12')
]).

% PIX instances
instance(pix_br_001, pix, [
    country('Brazil'),
    currency('BRL'),
    pix_key('user@example.com'),
    status(active)
]).

instance(pix_br_002, pix, [
    country('Brazil'),
    currency('BRL'),
    pix_key('+5511999999999'),
    status(active)
]).

% UPI instances
instance(upi_in_001, upi, [
    country('India'),
    currency('INR'),
    upi_id('user@paytm'),
    status(active)
]).

instance(upi_in_002, upi, [
    country('India'),
    currency('INR'),
    upi_id('merchant@okaxis'),
    status(active)
]).

% iDEAL instances
instance(ideal_nl_001, ideal, [
    country('Netherlands'),
    currency('EUR'),
    status(active)
]).

instance(ideal_nl_002, ideal, [
    country('Netherlands'),
    currency('EUR'),
    status(active)
]).

% Apple Pay instances
instance(apple_pay_001, apple_pay, [
    device('iPhone 15'),
    token('tok_apple_xyz123'),
    status(active)
]).

instance(apple_pay_002, apple_pay, [
    device('iPad Pro'),
    token('tok_apple_abc456'),
    status(active)
]).

% Google Pay instances
instance(google_pay_001, google_pay, [
    device('Pixel 8'),
    token('tok_google_def789'),
    status(active)
]).

instance(google_pay_002, google_pay, [
    device('Samsung S24'),
    token('tok_google_ghi012'),
    status(active)
]).

% Authorization transactions
instance(auth_tx_001, authorization, [
    amount(100.00),
    currency('USD'),
    status(auth_ok),
    timestamp('2025-09-29T10:30:00Z')
]).

instance(auth_tx_002, authorization, [
    amount(250.50),
    currency('EUR'),
    status(auth_failed),
    timestamp('2025-09-29T11:45:00Z')
]).

% Capture transactions
instance(capture_tx_001, settle, [
    amount(100.00),
    currency('USD'),
    status(settle_ok),
    timestamp('2025-09-29T12:00:00Z'),
    authorization_id(auth_tx_001)
]).

instance(capture_tx_002, settle, [
    amount(250.50),
    currency('EUR'),
    status(settle_failed),
    timestamp('2025-09-29T13:15:00Z'),
    authorization_id(auth_tx_002)
]).

% Refund transactions
instance(refund_tx_001, refund, [
    amount(50.00),
    currency('USD'),
    type(partial),
    status(processing),
    timestamp('2025-09-29T14:30:00Z'),
    settle_id(capture_tx_001)
]).

instance(refund_tx_002, refund, [
    amount(125.25),
    currency('EUR'),
    type(full),
    status(processing),
    timestamp('2025-09-29T15:45:00Z'),
    settle_id(capture_tx_002)
]).

% Void transactions
instance(void_tx_001, void, [
    original_amount(100.00),
    currency('USD'),
    status(void_ok),
    timestamp('2025-09-29T16:00:00Z'),
    authorization_id(auth_tx_001)
]).

instance(void_tx_002, void, [
    original_amount(250.50),
    currency('EUR'),
    status(void_failed),
    timestamp('2025-09-29T17:15:00Z'),
    authorization_id(auth_tx_002)
]).

% Ecommerce Merchants
instance(ecommerce_merchant_001, ecommerce_merchant, [
    name('OnlineShop Ltd'),
    merchant_id('merch_001'),
    website('https://onlineshop.com'),
    accepted_methods([visa_card, mastercard_card, apple_pay])
]).

instance(ecommerce_merchant_002, ecommerce_merchant, [
    name('Fashion Store'),
    merchant_id('merch_002'),
    website('https://fashionstore.com'),
    accepted_methods([visa_card, mastercard_card, amex_card, google_pay])
]).

% Retail Merchants
instance(retail_merchant_001, retail_merchant, [
    name('Local Supermarket'),
    merchant_id('merch_003'),
    location('123 Main St, Kyiv'),
    accepted_methods([visa_card, mastercard_card])
]).

instance(retail_merchant_002, retail_merchant, [
    name('Electronics Store'),
    merchant_id('merch_004'),
    location('456 Tech Avenue, Lviv'),
    accepted_methods([visa_card, mastercard_card, amex_card, apple_pay, google_pay])
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
% 7. допоміжні предикати для запитів
% ============================================
% предикати допомагають робити складні запити до бази знань

% транзитивне замикання для is_a
% дозволяє знаходити непрямі звязки через декілька рівнів
is_a_transitive(X, Y) :- is_a(X, Y).% пряме відношення (X - підтип Y, якщо є is_a(X, Y))
is_a_transitive(X, Y) :- 
    is_a(X, Z),% якщо X є типом Z
    is_a_transitive(Z, Y).% і Z транзитивно є типом Y, то X є типом Y

%(X є підтипом Y, якщо існує такий Z, що X є підтипом Z, а Z транзитивно є підтипом Y.)

% транзитивне замикання для part_of
% дозволяє знаходити непрямі композиційні звязки
part_of_transitive(X, Y) :- part_of(X, Y).% пряме відношення
part_of_transitive(X, Y) :- 
    part_of(X, Z),% якщо X є частиною Z
    part_of_transitive(Z, Y).% і Z транзитивно є частиною Y, то X є частиною Y

% перевірка чи повязані два обєкти через будь-яке відношення
% дозволяє знайти будь-який звязок між двома сутностями
connected(X, Y) :- is_a(X, Y).% через is_a (пряме)
connected(X, Y) :- is_a(Y, X).% через is_a (зворотне)
connected(X, Y) :- part_of(X, Y).% через part_of (пряме)
connected(X, Y) :- part_of(Y, X).% через part_of (зворотне)
connected(X, Y) :- requires(X, Y).% через requires (пряме)
connected(X, Y) :- requires(Y, X).% через requires (зворотне)
connected(X, Y) :- processes(X, Y).% через processes (пряме)
connected(X, Y) :- processes(Y, X).% через processes (зворотне)
connected(X, Y) :- belongs_to(X, Y).% через belongs_to (пряме)
connected(X, Y) :- belongs_to(Y, X).% через belongs_to (зворотне)

% транзитивне замикання для будь-якого звязку
% знаходить звязок через ланцюжок проміжних сутностей
% використовує список visited щоб уникнути циклів
connected_transitive(X, Y) :-
    connected_transitive(X, Y, []).% початок з порожнім списком відвіданих

connected_transitive(X, Y, _) :-
    connected(X, Y).% якщо є прямий звязок

connected_transitive(X, Y, Visited) :-
    connected(X, Z),% якщо X звязаний з Z
    \+ member(Z, Visited),% і Z ще не відвідували (запобігаємо циклам)
    connected_transitive(Z, Y, [X|Visited]).% шукаємо шлях від Z до Y

% пошук шляху між двома вузлами
% повертає повний шлях від X до Y через проміжні вузли
find_path(X, Y, Path) :- 
    find_path(X, Y, [X], Path).% початок з X у списку відвіданих

find_path(X, Y, Visited, Path) :-
    connected(X, Y),% якщо є прямий звязок
    \+ member(Y, Visited),% і Y ще не відвідували
    reverse([Y|Visited], Path).% повертаємо шлях у правильному порядку

find_path(X, Y, Visited, Path) :-
    connected(X, Z),% якщо X звязаний з Z
    \+ member(Z, Visited),% і Z ще не відвідували
    find_path(Z, Y, [Z|Visited], Path).% продовжуємо пошук від Z

% визначення типу звязку
% дозволяє дізнатися яким саме відношенням повязані дві сутності
relation_type(X, Y, 'is_a') :- is_a(X, Y).
relation_type(X, Y, 'part_of') :- part_of(X, Y).
relation_type(X, Y, 'requires') :- requires(X, Y).
relation_type(X, Y, 'processes') :- processes(X, Y).
relation_type(X, Y, 'belongs_to') :- belongs_to(X, Y).

% пошук всіх нащадків класу (is_a ієрархія)
% знаходить всі класи що є типами вказаного класу
all_descendants(Class, Descendants) :-
    findall(D, is_a_transitive(D, Class), Descendants).

% пошук всіх компонентів (part_of ієрархія)
% знаходить всі частини що входять до цілого
all_parts(Whole, Parts) :-
    findall(P, part_of_transitive(P, Whole), Parts).

% пошук всіх вимог для обєкта
% знаходить все що потрібно для створення/використання обєкта
all_requirements(Entity, Requirements) :-
    findall(R, requires(Entity, R), Requirements).

% пошук всіх екземплярів класу
% знаходить всі конкретні реалізації класу та його підкласів
all_instances(Class, Instances) :-
    findall(I, 
        (instance(I, Type, _),% знайти всі екземпляри
         is_a_transitive(Type, Class)),% де їх тип є підтипом Class
        Instances).

% отримання інформації про екземпляр
% повертає тип та властивості конкретного екземпляра
instance_info(Instance, Type, Properties) :-
    instance(Instance, Type, Properties).

% отримання властивості екземпляра
% дозволяє витягти конкретну властивість з екземпляра
% підтримує два формати: property=value та property(value)
get_property(Instance, Property, Value) :-
    instance(Instance, _, Props),% отримати властивості екземпляра
    member(Property=Value, Props).% знайти властивість у форматі property=value

get_property(Instance, Property, Value) :-
    instance(Instance, _, Props),% отримати властивості екземпляра
    Term =.. [Property, Value],% створити терм property(value)
    member(Term, Props).% знайти його в списку

% ============================================
% 8. валідаційні правила
% ============================================
% перевіряють коректність операцій у фінтех системі

% перевірка коректності послідовності транзакцій
% визначає які транзакції можуть йти одна за одною
valid_transaction_flow(authorization, settle).
valid_transaction_flow(authorization, void).
valid_transaction_flow(settle, refund).

% чи можна виконати транзакцію після попередньої
% перевіряє чи дозволений перехід між двома типами транзакцій
can_perform_transaction(PreviousType, DesiredType) :-
    valid_transaction_flow(PreviousType, DesiredType).

% перевірка повного ланцюжка транзакцій
% перевіряє чи коректна послідовність декількох транзакцій
validate_transaction_chain([_]).% один елемент завжди валідний
validate_transaction_chain([First, Second | Rest]) :-
    valid_transaction_flow(First, Second),% перевіряємо перехід між першою та другою
    validate_transaction_chain([Second | Rest]).% рекурсивно перевіряємо решту

% валідація суми транзакції
% перевіряє чи сума є правильним числом більше нуля
valid_amount(Amount) :-
    number(Amount),% має бути числом
    Amount > 0.% додатнім

% перелік підтримуваних валют у системі
supported_currency('USD').
supported_currency('EUR').
supported_currency('UAH').
supported_currency('BRL').
supported_currency('INR').
supported_currency('GBP').

% перевіряє чи валюта підтримується системою
valid_currency(Currency) :-
    supported_currency(Currency).

% комплексна перевірка коректності параметрів транзакції
valid_transaction(Amount, Currency) :-
    valid_amount(Amount),% сума має бути валідною
    valid_currency(Currency).% валюта має бути підтримуваною

% перевірка, чи merchant приймає payment_method
% дивиться в список прийнятих методів оплати продавця
accepts_payment_method(MerchantInstance, PaymentMethodType) :-
    instance(MerchantInstance, MerchantType, Props),% отримати дані мерчанта
    is_a_transitive(MerchantType, merchant),% перевірити що це справді мерчант
    member(accepted_methods(Methods), Props),% знайти список прийнятих методів
    member(PaymentMethodType, Methods).% перевірити що метод у списку

% перевірка чи payment_method є певного типу
% використовує ієрархію класів для перевірки типу
payment_method_is_type(PaymentMethodType, RequiredType) :-
    is_a_transitive(PaymentMethodType, RequiredType).

% комплексна валідація: чи може мерчант прийняти конкретний тип картки
% перевіряє сумісність через ієрархію типів
can_accept_payment(MerchantInstance, PaymentMethodType) :-
    accepts_payment_method(MerchantInstance, AcceptedType),% що приймає продавець
    payment_method_is_type(PaymentMethodType, AcceptedType).% чи сумісний тип

% альтернатива (пряма перевірка типу)
% якщо тип точно співпадає зі списком
can_accept_payment(MerchantInstance, PaymentMethodType) :-
    accepts_payment_method(MerchantInstance, PaymentMethodType).

% перевірка статусу картки
% картка має бути активною для використання
card_is_active(CardInstance) :-
    instance(CardInstance, _, Props),% отримати властивості картки
    member(status(active), Props).% перевірити що статус активний

% перевірка чи картка не прострочена
% простий варіант - перевірка наявності expiry
% в реальній системі тут була б перевірка чи дата не минула
card_not_expired(CardInstance) :-
    instance(CardInstance, _, Props),% отримати властивості картки
    member(expiry(_), Props).% перевірити що є дата закінчення

% валідація можливості оплати карткою
% комплексна перевірка всіх умов для оплати
can_pay_with_card(CardInstance, MerchantInstance) :-
    card_is_active(CardInstance),% картка активна
    card_not_expired(CardInstance),% картка не прострочена
    instance(CardInstance, CardType, _),% отримати тип картки
    can_accept_payment(MerchantInstance, CardType).% мерчант приймає цей тип

% перевірка чи існують всі необхідні залежності
% перевіряє що всі вимоги для сутності задоволені
has_all_requirements(Entity) :-
    all_requirements(Entity, Reqs),% знайти всі вимоги
    forall(member(Req, Reqs),% для кожної вимоги
        (atom(Req) ; is_a_transitive(_, Req))).% перевірити що вона існує

% перевірка повного ланцюжка залежностей для транзакції
% знаходить які вимоги не задоволені
check_transaction_requirements(TransactionType, Missing) :-
    all_requirements(TransactionType, DirectReqs),% знайти прямі вимоги
    findall(Req,% знайти всі вимоги
        (member(Req, DirectReqs),% які є в списку
         \+ has_all_requirements(Req)),% але не мають своїх залежностей
        Missing).% записати їх як відсутні

% ============================================
% 9. агрегаційні запити
% ============================================
% предикати дозволяють робити статистичні запити та аналіз даних

% підрахунок кількості інстансів певного типу
% рахує скільки конкретних екземплярів одного типу
count_instances(Type, Count) :-
    findall(I, instance(I, Type, _), Instances),    % знайти всі екземпляри типу
    length(Instances, Count).                       % порахувати їх кількість

% підрахунок кількості інстансів класу (включаючи підкласи)
% рахує екземпляри класу разом з усіма його підкласами
count_instances_hierarchical(Class, Count) :-
    all_instances(Class, Instances),% знайти всі екземпляри через ієрархію
    length(Instances, Count).% порахувати їх кількість

% статистика по всіх типах
% виводить таблицю з кількістю екземплярів кожного типу
all_instance_statistics :-
    findall(Type, instance(_, Type, _), AllTypes),% знайти всі типи
    sort(AllTypes, UniqueTypes),% залишити унікальні
    format('~n=== СТАТИСТИКА ІНСТАНСІВ ===~n~n'),
    forall(member(Type, UniqueTypes),% для кожного типу
        (count_instances(Type, Count),% порахувати кількість
         format('  ~w: ~d екземплярів~n', [Type, Count]))),% вивести
    format('~n').

% статистика по класах (включаючи ієрархію)
% виводить статистику з врахуванням ієрархії класів
class_statistics :-
    findall(Class, (is_a(_, Class), \+ is_a(Class, _)), TopClasses),% знайти кореневі класи
    sort(TopClasses, UniqueClasses),% залишити унікальні
    format('~n=== СТАТИСТИКА ПО КЛАСАХ ===~n~n'),
    forall(member(Class, UniqueClasses),% для кожного класу
        (count_instances_hierarchical(Class, Count),% порахувати з підкласами
         Count > 0,% якщо є екземпляри
         format('  ~w: ~d екземплярів (включаючи підкласи)~n', [Class, Count]))),
    format('~n').

% підрахунок кількості класів
% рахує скільки всього різних класів в онтології
count_classes(Count) :-
    findall(Class, (is_a(Class, _) ; is_a(_, Class)), AllClasses),  % знайти всі класи
    sort(AllClasses, UniqueClasses),% залишити унікальні
    length(UniqueClasses, Count).% порахувати

% підрахунок кількості відношень кожного типу
% виводить детальну статистику по всіх типах звязків
count_relations :-
    findall(_, is_a(_, _), IsAList),% знайти всі is_a звязки
    length(IsAList, IsACount),
    findall(_, part_of(_, _), PartOfList),% знайти всі part_of звязки
    length(PartOfList, PartOfCount),
    findall(_, requires(_, _), RequiresList),% знайти всі requires звязки
    length(RequiresList, RequiresCount),
    findall(_, processes(_, _), ProcessesList),% знайти всі processes звязки
    length(ProcessesList, ProcessesCount),
    findall(_, belongs_to(_, _), BelongsToList),% знайти всі belongs_to звязки
    length(BelongsToList, BelongsToCount),
    format('~n=== СТАТИСТИКА ВІДНОШЕНЬ ===~n~n'),
    format('  is_a: ~d зв\'язків~n', [IsACount]),
    format('  part_of: ~d зв\'язків~n', [PartOfCount]),
    format('  requires: ~d зв\'язків~n', [RequiresCount]),
    format('  processes: ~d зв\'язків~n', [ProcessesCount]),
    format('  belongs_to: ~d зв\'язків~n', [BelongsToCount]),
    Total is IsACount + PartOfCount + RequiresCount + ProcessesCount + BelongsToCount,
    format('  ~nВсього: ~d зв\'язків~n~n', [Total]).

% знайти всі інстанси з певним статусом
% фільтрує екземпляри за значенням поля status
instances_by_status(Status, Instances) :-
    findall(Instance,                               
        (instance(Instance, _, Props),% для всіх екземплярів
         member(status(Status), Props)),% перевірити статус
        Instances).

% підрахунок активних карток
% спеціальний запит для підрахунку активних карток
count_active_cards(Count) :-
    instances_by_status(active, AllActive),% знайти всі активні
    findall(Card,                                   
        (member(Card, AllActive),% з активних
         instance(Card, Type, _),                   
         is_a_transitive(Type, card)),% відібрати тільки картки
        ActiveCards),
    length(ActiveCards, Count).% порахувати

% знайти всі транзакції в певній валюті
% фільтрує транзакції за валютою
transactions_by_currency(Currency, Transactions) :-
    findall(Tx,                                     
        (instance(Tx, Type, Props),% для всіх екземплярів
         is_a_transitive(Type, transaction),% які є транзакціями
         member(currency(Currency), Props)),% з потрібною валютою
        Transactions).

% порахувати загальну суму транзакцій по валютах
% сумує всі транзакції в одній валюті
sum_transactions_by_currency(Currency, Total) :-
    transactions_by_currency(Currency, Transactions),% знайти транзакції
    findall(Amount,                                 
        (member(Tx, Transactions),% для кожної транзакції
         instance(Tx, _, Props),                    
         (member(amount(Amount), Props) ;% взяти суму
          member(original_amount(Amount), Props))),% або оригінальну суму
        Amounts),
    sum_list(Amounts, Total).% підсумувати

% статистика транзакцій по валютах
% виводить повну статистику транзакцій згруповану по валютах
transaction_currency_statistics :-
    findall(Currency,                               
        (instance(_, Type, Props),% для всіх екземплярів
         is_a_transitive(Type, transaction),% які є транзакціями
         member(currency(Currency), Props)),% взяти валюту
        AllCurrencies),
    sort(AllCurrencies, UniqueCurrencies),% залишити унікальні валюти
    format('~n=== СТАТИСТИКА ТРАНЗАКЦІЙ ПО ВАЛЮТАХ ===~n~n'),
    forall(member(Curr, UniqueCurrencies),% для кожної валюти
        (transactions_by_currency(Curr, Txs),% знайти транзакції
         length(Txs, TxCount),% порахувати кількість
         sum_transactions_by_currency(Curr, Total),% порахувати суму
         format('  ~w: ~d транзакцій, сума: ~2f~n', [Curr, TxCount, Total]))),
    format('~n').

% знайти merchants що приймають певний метод оплати
% шукає всіх продавців які працюють з вказаним методом
merchants_accepting(PaymentMethodType, Merchants) :-
    findall(Merchant,                               
        accepts_payment_method(Merchant, PaymentMethodType),  % хто приймає метод
        Merchants).

% максимальна глибина ієрархії
% знаходить найдовший ланцюжок is_a відношень
max_hierarchy_depth(MaxDepth) :-
    findall(Depth,                                  
        (is_a(Class, _),% для всіх класів
         hierarchy_depth(Class, Depth)),% знайти їх глибину
        Depths),
    max_list(Depths, MaxDepth).% взяти максимальну

% глибина конкретного класу в ієрархії
% рахує скільки рівнів до кореня ієрархії
hierarchy_depth(Class, 1) :-
    is_a(Class, Parent),% якщо є батько
    \+ is_a(Parent, _).% але у батька немає батька (корінь)

hierarchy_depth(Class, Depth) :-
    is_a(Class, Parent),% якщо є батько
    is_a(Parent, _),% і у батька є батько
    hierarchy_depth(Parent, ParentDepth),% знайти глибину батька
    Depth is ParentDepth + 1.% додати 1

% повна статистика онтології
% виводить всю статистичну інформацію про онтологію
ontology_statistics :-
    format('~n╔══════════════════════════════════════════╗~n'),
    format('  ║   ПОВНА СТАТИСТИКА ОНТОЛОГІЇ             ║~n'),
    format('  ╚══════════════════════════════════════════╝~n'),
    
    count_classes(ClassCount),% порахувати класи
    format('~nКласів: ~d~n', [ClassCount]),
    
    findall(I, instance(I, _, _), AllInstances),% порахувати інстанси
    length(AllInstances, InstanceCount),
    format('Інстансів: ~d~n', [InstanceCount]),
    
    max_hierarchy_depth(MaxDepth),% знайти макс глибину
    format('Максимальна глибина ієрархії: ~d рівнів~n', [MaxDepth + 1]),
    
    count_relations,% вивести статистику звязків
    all_instance_statistics,% вивести статистику інстансів
    class_statistics,% вивести статистику класів
    transaction_currency_statistics.% вивести статистику транзакцій

% ============================================
% 10. приклади запитів
% ============================================
% нижче наведені приклади як користуватись системою
% щоб виконати запит, скопіюйте його в консоль prolog після знаку ?-

% === базові запити ===
% перевірка відношень в ієрархії

% чи є visa_card типом card?
% ?- is_a_transitive(visa_card, card).
% очікувана відповідь: true

% чи повязані subscription та chargeback через будь-які відношення?
% ?- connected_transitive(subscription, chargeback).
% очікувана відповідь: true (через ланцюжок звязків)

% знайти шлях від subscription до dispute
% ?- find_path(subscription, dispute, Path).
% поверне список вузлів що зєднують ці сутності

% === валідаційні запити ===
% перевірка бізнес-правил

% чи можна зробити settle після authorization?
% ?- can_perform_transaction(authorization, settle).
% очікувана відповідь: true

% чи правильний ланцюжок [authorization, settle, refund]?
% ?- validate_transaction_chain([authorization, settle, refund]).
% очікувана відповідь: true

% чи валідна транзакція на 100 доларів?
% ?- valid_transaction(100.00, 'USD').
% очікувана відповідь: true

% чи може ecommerce_merchant_001 прийняти visa_card?
% ?- can_accept_payment(ecommerce_merchant_001, visa_card).
% очікувана відповідь: true (якщо visa у списку прийнятих методів)

% чи можна оплатити карткою visa_card_4111 у merchant?
% ?- can_pay_with_card(visa_card_4111, ecommerce_merchant_001).
% перевіряє активність картки, термін дії та чи merchant приймає цей тип

% === агрегаційні запити ===
% статистика та аналітика

% скільки є екземплярів visa_card?
% ?- count_instances(visa_card, Count).
% поверне кількість visa карток

% скільки всього карток (включаючи всі типи)?
% ?- count_instances_hierarchical(card, Count).
% поверне загальну кількість всіх карток

% вивести статистику по всіх інстансах
% ?- all_instance_statistics.
% виведе таблицю з кількістю екземплярів кожного типу

% скільки активних карток?
% ?- count_active_cards(Count).
% поверне кількість карток зі статусом active

% знайти всі транзакції в доларах
% ?- transactions_by_currency('USD', Txs).
% поверне список транзакцій у USD

% порахувати загальну суму транзакцій у доларах
% ?- sum_transactions_by_currency('USD', Total).
% підсумує всі транзакції в USD

% які продавці приймають visa?
% ?- merchants_accepting(visa_card, Merchants).
% поверне список продавців

% вивести повну статистику онтології
% ?- ontology_statistics.
% виведе всю статистичну інформацію

% === пошукові запити ===
% пошук конкретних даних

% знайти всі активні екземпляри
% ?- instances_by_status(active, Instances).
% поверне список всіх активних обєктів

% знайти всі типи методів оплати
% ?- all_descendants(payment_method, Methods).
% поверне список всіх класів методів оплати

% знайти всі екземпляри карток
% ?- all_instances(card, Cards).
% поверне список всіх конкретних карток