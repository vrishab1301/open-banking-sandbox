package com.vrishab.bank.account;

import java.math.BigDecimal;

public record AccountResponse(
        Long id,
        String accountNumber,
        String type,
        String nickname,
        BigDecimal balance,
        String currency
) {
    static AccountResponse from(Account account) {
        return new AccountResponse(
                account.getId(),
                account.getAccountNumber(),
                account.getType().name(),
                account.getNickname(),
                account.getBalance(),
                account.getCurrency()
        );
    }
}
