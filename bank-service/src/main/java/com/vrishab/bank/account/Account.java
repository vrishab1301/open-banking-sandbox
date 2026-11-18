package com.vrishab.bank.account;

import jakarta.persistence.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;

@Entity
@Table(name = "accounts")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "customer_id", nullable = false)
    private Long customerId;

    @Column(name = "account_number", nullable = false, unique = true, length = 20)
    private String accountNumber;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private AccountType type;

    @Column(length = 50)
    private String nickname;

    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal balance;

    @JdbcTypeCode(SqlTypes.CHAR)
    @Column(nullable = false, length = 3)
    private String currency;

    protected Account() {
        // Required by JPA: it creates empty objects, then fills them from the database
    }

    public Long getId() { return id; }
    public Long getCustomerId() { return customerId; }
    public String getAccountNumber() { return accountNumber; }
    public AccountType getType() { return type; }
    public String getNickname() { return nickname; }
    public BigDecimal getBalance() { return balance; }
    public String getCurrency() { return currency; }
}
