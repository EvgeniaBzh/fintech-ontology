предметна область: платіжні системи та фінтехнології

## опис проєкту

онтологія описує предметну область платіжних систем та фінтехнологій. база знань містить класифікацію платіжних методів, типів транзакцій, учасників процесу та їх взаємозв'язків.

система дозволяє робити автоматичні запити для аналізу зв'язків між об'єктами, пошуку залежностей та перевірки бізнес-правил.

## виконання вимог

вимоги до лабораторної роботи:
- **класів**: 35+ (вимога: 20+)
- **відношень**: 5 (вимога: 3+, включаючи is_a та part_of)
- **рівнів ієрархії**: 5 (вимога: 4)
- **інстансів на практичний клас**: 2+ для кожного

реалізовані відношення:
1. `is_a` - таксономія/класифікація
2. `part_of` - композиція
3. `requires` - залежності
4. `processes` - обробка
5. `belongs_to` - приналежність

## структура онтології

### загальна кількість елементів

- класів: 35+
- відношень: 5
- інстансів: 28
- практичних класів з реалізаціями: 14

### основні гілки класифікації

financial_entity (корінь)
├── payment
├── payment_method
├── actor
├── subscription
├── dispute
├── currency
├── security_feature
├── routing
├── api_request
└── invoice


## відношення

### 1. is_a (таксономія)

визначає ієрархію "є типом", наприклад:
- visa_card is_a branded_card
- branded_card is_a card
- card is_a payment_method

транзитивне замикання: `is_a_transitive(X, Y)` дозволяє перевіряти непрямі зв'язки

### 2. part_of (композиція)

визначає відношення "є частиною", наприклад:
- card_number part_of card_data
- card_data part_of card

транзитивне замикання: `part_of_transitive(X, Y)`

### 3. requires (залежності)

описує необхідні залежності для виконання операцій:
- authorization requires card_data
- settle requires authorization
- refund requires settle

### 4. processes (обробка)

показує хто обробляє що:
- processor processes payment
- merchant processes order
- gateway processes api_request

### 5. belongs_to (приналежність)

визначає власність:
- card belongs_to customer
- order belongs_to merchant
- transaction belongs_to order

## ієрархія класів

### payment гілка (5 рівнів)

financial_entity (1)
  └── payment (2)
      └── order (3)
          └── transaction (4)
              ├── authorization (5)
              ├── settle (5)
              ├── refund (5)
              └── void (5)

### payment_method гілка (5 рівнів)

financial_entity (1)
  └── payment_method (2)
      ├── card (3)
      │   └── branded_card (4)
      │       ├── visa_card (5)
      │       ├── mastercard_card (5)
      │       └── amex_card (5)
      │
      ├── alternative_payment_method (3)
      │   └── regional_apm (4)
      │       ├── pix (5)
      │       ├── upi (5)
      │       └── ideal (5)
      │
      └── digital_wallet (3)
          └── mobile_wallet (4)
              ├── apple_pay (5)
              └── google_pay (5)

### actor гілка (4 рівні)

financial_entity (1)
  └── actor (2)
      ├── merchant (3)
      │   ├── ecommerce_merchant (4)
      │   └── retail_merchant (4)
      │
      ├── customer (3)
      │   ├── individual_customer (4)
      │   └── business_customer (4)
      │
      └── processor (3)

## інстанси

всі практичні класи мають мінімум 2 реалізації з реальними властивостями.

### картки (6 інстансів)

visa_card: visa_card_4111, visa_card_4532
mastercard_card: mastercard_5555, mastercard_5105
amex_card: amex_3782, amex_3714

### регіональні платіжні методи (6 інстансів)

pix (бразилія): pix_br_001, pix_br_002
upi (індія): upi_in_001, upi_in_002
ideal (нідерланди): ideal_nl_001, ideal_nl_002

### мобільні гаманці (4 інстанси)

apple_pay: apple_pay_001, apple_pay_002
google_pay: google_pay_001, google_pay_002

### транзакції (8 інстансів)

authorization: auth_tx_001, auth_tx_002
settle: capture_tx_001, capture_tx_002
refund: refund_tx_001, refund_tx_002
void: void_tx_001, void_tx_002

### учасники (8 інстансів)

ecommerce_merchant: ecommerce_merchant_001, ecommerce_merchant_002
retail_merchant: retail_merchant_001, retail_merchant_002
individual_customer: individual_customer_001, individual_customer_002
business_customer: business_customer_001, business_customer_002

## запити до бази

### базові предикати

#### перевірка відношень

% пряме відношення
?- is_a(visa_card, branded_card).
true

% транзитивне відношення
?- is_a_transitive(visa_card, card).
true

?- is_a_transitive(visa_card, financial_entity).
true

#### пошук нащадків

% всі типи карток
?- all_descendants(card, Cards).
Cards = [branded_card, visa_card, mastercard_card, amex_card]

% всі методи оплати
?- all_descendants(payment_method, Methods).
Methods = [card, alternative_payment_method, digital_wallet, 
           branded_card, regional_apm, mobile_wallet, 
           visa_card, mastercard_card, amex_card, 
           pix, upi, ideal, apple_pay, google_pay]

% всі типи транзакцій
?- all_descendants(transaction, Types).
Types = [authorization, settle, refund, void]

#### композиція

% компоненти card_data
?- all_parts(card_data, Parts).
Parts = [card_number, bin, cvv, expiration_month, 
         expiration_year, cardholder_name]

% транзитивна композиція
?- part_of_transitive(card_number, card).
true

#### залежності

% що потрібно для authorization
?- all_requirements(authorization, Reqs).
Reqs = [card_data, three_ds_secure]

% ланцюжок залежностей
?- requires(refund, X).
X = settle

?- requires(settle, Y).
Y = authorization

### робота з інстансами

% всі visa картки
?- all_instances(visa_card, Instances).
Instances = [visa_card_4111, visa_card_4532]

% всі картки через ієрархію
?- all_instances(card, AllCards).
AllCards = [visa_card_4111, visa_card_4532, 
            mastercard_5555, mastercard_5105, 
            amex_3782, amex_3714]

% інформація про інстанс
?- instance_info(visa_card_4111, Type, Props).
Type = visa_card,
Props = [card_number('4111111111111111'), 
         expiry('12/2025'), 
         cvv('123')]

% інформація про pix
?- instance_info(pix_br_001, Type, Props).
Type = pix,
Props = [country('Brazil'), currency('BRL'), 
         pix_key('user@example.com'), status('active')]

### пошук шляхів

% простий шлях
?- find_path(card, customer, Path).
Path = [card, customer]

% складний шлях через підписку
?- find_path(subscription, chargeback, Path).
Path = [subscription, recurring_payment, order, transaction, chargeback]

% зворотний напрямок
?- find_path(chargeback, subscription, Path).
Path = [chargeback, transaction, order, recurring_payment, subscription]

% через вимоги
?- find_path(refund, authorization, Path).
Path = [refund, settle, authorization]

% довгий шлях (7 рівнів)
?- find_path(apple_pay, chargeback, Path).
Path = [apple_pay, mobile_wallet, digital_wallet, 
        payment_method, order, transaction, chargeback]

### перевірка зв'язків

% чи зв'язані через будь-яке відношення
?- connected_transitive(apple_pay, customer).
true

% тип відношення
?- relation_type(visa_card, branded_card, Type).
Type = 'is_a'

?- relation_type(card_number, card_data, Type).
Type = 'part_of'


### відношення processes та belongs_to

% хто обробляє payment
?- processes(X, payment).
X = processor

% що обробляє merchant
?- processes(merchant, X).
X = order

% кому належить card
?- belongs_to(card, X).
X = customer

% що належить customer (множинна відповідь)
?- belongs_to(X, customer).
X = card ;
X = subscription

## приклади використання

### use case 1: валідація транзакції

питання: чи може бути виконаний refund?

?- requires(refund, X).
X = settle

?- requires(settle, Y).
Y = authorization

висновок: для refund потрібен ланцюжок authorization → settle → refund

### use case 2: аналіз платіжного методу

питання: які властивості має pix?

?- instance_info(pix_br_001, Type, Props).
Type = pix,
Props = [country('Brazil'), currency('BRL'), 
         pix_key('user@example.com'), status('active')]

### use case 3: пошук всіх карток клієнта

?- all_instances(card, Cards).
Cards = [visa_card_4111, visa_card_4532, 
         mastercard_5555, mastercard_5105, 
         amex_3782, amex_3714]

### use case 4: перевірка можливості chargeback

питання: чи може підписка призвести до chargeback?

?- find_path(subscription, chargeback, Path).
Path = [subscription, recurring_payment, order, transaction, chargeback]

відповідь: так, через ланцюжок з 5 кроків.

### use case 5: аналіз структури картки

?- all_parts(card_data, Parts).
Parts = [card_number, bin, cvv, expiration_month, 
         expiration_year, cardholder_name]

## запуск

### вимоги

- swi-prolog 8.0 або новіше

### встановлення

1. встановити swi-prolog з офіційного сайту
2. завантажити файл `ontology.pl`

### запуск

swipl

у консолі prolog:

?- ['ontology'].
true

### тестові запити

після завантаження можна виконувати запити:

% перевірка базових зв'язків
?- is_a_transitive(visa_card, card).

% пошук шляху
?- find_path(subscription, chargeback, Path).

% всі методи оплати
?- all_descendants(payment_method, Methods).

% інформація про інстанс
?- instance_info(visa_card_4111, Type, Props).


## статистика онтології

| метрика                   | значення |
|---------------------------|----------|
| загальна кількість класів | 35+      |
| відношень                 | 5        |
| максимальна глибина is_a  | 5 рівнів |
| кількість інстансів       | 28       |
| практичних класів         | 14       |

## технічні особливості

### транзитивні замикання

- `is_a_transitive/2` - для ієрархії класів
- `part_of_transitive/2` - для композиції
- `connected_transitive/2` - для всіх зв'язків

### алгоритм пошуку шляху

функція `find_path/3` використовує depth-first search з запобіганням циклів:

find_path(X, Y, Path) :- find_path(X, Y, [X], Path).

find_path(X, Y, Visited, Path) :-
    connected(X, Y),
    \+ member(Y, Visited),
    reverse([Y|Visited], Path).

find_path(X, Y, Visited, Path) :-
    connected(X, Z),
    \+ member(Z, Visited),
    find_path(Z, Y, [Z|Visited], Path).

### допоміжні предикати

- `all_descendants/2` - пошук всіх нащадків класу
- `all_parts/2` - пошук всіх компонентів
- `all_requirements/2` - пошук всіх вимог
- `all_instances/2` - пошук всіх інстансів класу
- `instance_info/3` - отримання інформації про інстанс
- `relation_type/3` - визначення типу зв'язку

## висновки

створена онтологія повністю покриває предметну область платіжних систем та фінтехнологій. система дозволяє:

- автоматично перевіряти зв'язки між об'єктами
- шукати шляхи між віддаленими вузлами
- валідувати правила (наприклад, послідовність транзакцій)
- аналізувати залежності
- навігувати по складній ієрархії класів

завдяки транзитивним замиканням система може знаходити непрямі зв'язки через декілька рівнів ієрархії, що особливо корисно для аналізу складних сценаріїв у фінтех-системах.

всі вимоги лабораторної роботи виконані з запасом, база знань містить реальні дані та готова до практичного використання.