-- Demo data: fake customers only, never real people

-- Two customers
INSERT INTO customers (full_name, email) VALUES
                                             ('Priya Sharma',  'priya.sharma@example.com'),
                                             ('Daniel Okafor', 'daniel.okafor@example.com');

-- Their accounts (Priya has two, Daniel has one)
INSERT INTO accounts (customer_id, account_number, type, nickname, balance)
SELECT id, '100-200-001', 'CHEQUING', 'Everyday Chequing', 2450.00
FROM customers WHERE email = 'priya.sharma@example.com'
UNION ALL
SELECT id, '100-200-002', 'SAVINGS', 'Emergency Fund', 8100.00
FROM customers WHERE email = 'priya.sharma@example.com'
UNION ALL
SELECT id, '100-300-001', 'CHEQUING', 'Main Account', 1275.50
FROM customers WHERE email = 'daniel.okafor@example.com';

-- Transactions (negative = money out, positive = money in)
INSERT INTO transactions (account_id, amount, description, posted_at)
SELECT a.id, t.amount, t.description, t.posted_at::timestamptz
FROM (VALUES
          ('100-200-001',  3200.00, 'Payroll deposit - Northwind Ltd', '2026-11-01 09:00:00-07'),
          ('100-200-001', -1400.00, 'Rent - Maple Property Mgmt',      '2026-11-01 12:00:00-07'),
          ('100-200-001',   -86.40, 'Loblaws',                         '2026-11-03 18:20:00-07'),
          ('100-200-001',   -14.75, 'Tim Hortons',                     '2026-11-04 08:05:00-07'),
          ('100-200-001',   -92.10, 'EPCOR Utilities',                 '2026-11-05 10:00:00-07'),
          ('100-200-001',   -55.00, 'Shell Gas Station',               '2026-11-08 17:40:00-07'),
          ('100-200-001',  -500.00, 'Transfer to savings',             '2026-11-10 09:30:00-07'),
          ('100-200-002',   500.00, 'Transfer from chequing',          '2026-11-10 09:30:00-07'),
          ('100-300-001',  2100.00, 'Payroll deposit - Prairie Tech',  '2026-11-01 09:00:00-07'),
          ('100-300-001',  -950.00, 'Rent - Whyte Ave Apartments',     '2026-11-01 11:00:00-07'),
          ('100-300-001',   -62.30, 'Save-On-Foods',                   '2026-11-06 19:10:00-07'),
          ('100-300-001',   -16.99, 'Netflix',                         '2026-11-07 00:00:00-07')
     ) AS t(account_number, amount, description, posted_at)
         JOIN accounts a ON a.account_number = t.account_number;