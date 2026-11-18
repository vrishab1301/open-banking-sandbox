-- Customers of the bank
CREATE TABLE customers (
                           id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           full_name   VARCHAR(100) NOT NULL,
                           email       VARCHAR(255) NOT NULL UNIQUE,
                           created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- Each customer can have several accounts
CREATE TABLE accounts (
                          id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          customer_id     BIGINT        NOT NULL REFERENCES customers(id),
                          account_number  VARCHAR(20)   NOT NULL UNIQUE,
                          type            VARCHAR(20)   NOT NULL CHECK (type IN ('CHEQUING', 'SAVINGS')),
                          nickname        VARCHAR(50),
                          balance         NUMERIC(15,2) NOT NULL DEFAULT 0,
                          currency        CHAR(3)       NOT NULL DEFAULT 'CAD',
                          created_at      TIMESTAMPTZ   NOT NULL DEFAULT now()
);

-- Each account has many transactions
-- Negative amount = money out, positive = money in
CREATE TABLE transactions (
                              id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                              account_id   BIGINT        NOT NULL REFERENCES accounts(id),
                              amount       NUMERIC(15,2) NOT NULL,
                              description  VARCHAR(255)  NOT NULL,
                              posted_at    TIMESTAMPTZ   NOT NULL
);

-- Indexes make common lookups fast
CREATE INDEX idx_accounts_customer ON accounts(customer_id);
CREATE INDEX idx_transactions_account_date ON transactions(account_id, posted_at DESC);